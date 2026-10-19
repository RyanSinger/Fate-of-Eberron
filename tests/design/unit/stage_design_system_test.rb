# frozen_string_literal: true

require "fileutils"
require "minitest/autorun"
require "tmpdir"
require_relative "../../../script/stage_design_system"

class StageDesignSystemTest < Minitest::Test
  S = StageDesignSystem

  SAMPLE = <<~HTML
    <p>intro</p>
    <section class="ds-sample" data-component="Track" data-group="Character" data-height="160">
      <span class="track">boxes</span>
    </section>
    <section class="ds-sample" data-component="Wanted" data-group="Handouts">
      <div class="handout">poster</div>
    </section>
  HTML

  def test_previews_are_cut_from_sections
    previews = S.previews(SAMPLE)
    assert_equal %w[Track Wanted], previews.map { |p| p[:name] }
    assert_equal ["Character", "Handouts"], previews.map { |p| p[:group] }
    assert_equal [160, 240], previews.map { |p| p[:height] }
    assert_equal '<span class="track">boxes</span>', previews.first[:body]
  end

  def test_preview_html_starts_with_card_header
    html = S.preview_html({ name: "Track", group: "Character", height: 160, body: "<b>x</b>" }, "https://example.test/site")
    assert_equal '<!-- @dsCard group="Character" height=160 -->', html.lines.first.chomp
    assert_includes html, "<b>x</b>"
    assert_includes html, "fonts.googleapis.com"
    assert_includes html, "color: var(--ink)"
  end

  def test_relative_site_urls_become_absolute
    html = S.preview_html({ name: "Actions", group: "Rules", height: 400, body: '<img src="/Fate-of-Eberron/images/icons/attack.svg">' },
                          "https://ryansinger.github.io")
    assert_includes html, 'src="https://ryansinger.github.io/Fate-of-Eberron/images/icons/attack.svg"'
  end

  def test_uploaded_icons_point_at_blobs
    html = S.preview_html({ name: "Actions", group: "Rules", height: 400, body: '<img src="/Fate-of-Eberron/images/icons/attack.svg">' },
                          "https://ryansinger.github.io", { "attack.svg" => "abc123" })
    assert_includes html, 'src="/_blob/abc123"'
    refute_includes html, "github.io"
  end

  def test_stage_fails_when_a_supplied_blob_map_lacks_an_icon
    sample = <<~HTML
      <section class="ds-sample" data-component="Actions"><img src="/Fate-of-Eberron/images/icons/defend.svg"></section>
    HTML
    with_repo(readmes: %w[Actions], sample: sample) do |root, site, out|
      error = assert_raises(RuntimeError) do
        S.stage(site, out, root: root, base_url: "https://example.test", blobs: { "attack.svg" => "abc" })
      end
      assert_includes error.message, "Actions"
      assert_includes error.message, "defend.svg"
    end
  end

  def with_repo(readmes:, sample: SAMPLE)
    Dir.mktmpdir do |dir|
      root = File.join(dir, "repo")
      site = File.join(dir, "site")
      out = File.join(dir, "out")
      FileUtils.mkdir_p([File.join(root, "design"), File.join(root, "assets/css"), site])
      File.write(File.join(root, "design/tokens.json"), "{}")
      File.write(File.join(root, "design/README.md"), "# Book")
      File.write(File.join(root, "assets/css/components.css"), ".track{}")
      File.write(File.join(root, "assets/css/handouts.css"), ".handout{}")
      readmes.each do |name|
        FileUtils.mkdir_p(File.join(root, "design/components", name))
        File.write(File.join(root, "design/components", name, "README.md"), "# #{name}")
      end
      File.write(File.join(site, "design-sample.html"), sample)
      yield root, site, out
    end
  end

  def test_stage_writes_project_layout
    with_repo(readmes: %w[Track Wanted]) do |root, site, out|
      names = S.stage(site, out, root: root, base_url: "https://example.test")
      assert_equal %w[Track Wanted], names
      project = File.join(out, "project")
      assert File.exist?(File.join(project, "tokens.json"))
      assert_equal "# Book", File.read(File.join(project, "README.md"))
      assert_equal "# Track", File.read(File.join(project, "components/Track/README.md"))
      assert File.read(File.join(project, "components/Wanted/preview.html")).start_with?("<!-- @dsCard")
      assert_equal ".track{}\n\n.handout{}", File.read(File.join(project, "components/bundle.css"))
      bundle = File.read(File.join(project, "components/bundle.js"))
      assert_includes bundle, '"namespace":"FateOfEberron"'
      assert_includes bundle, "window.FateOfEberron = {}"
    end
  end

  def test_stage_fails_when_a_readme_is_missing
    with_repo(readmes: %w[Track]) do |root, site, out|
      error = assert_raises(RuntimeError) { S.stage(site, out, root: root, base_url: "https://example.test") }
      assert_includes error.message, "Wanted"
      refute Dir.exist?(File.join(out, "project")), "nothing may be staged on failure"
    end
  end

  def test_stage_fails_when_no_sections_exist
    with_repo(readmes: [], sample: "<p>empty</p>") do |root, site, out|
      error = assert_raises(RuntimeError) { S.stage(site, out, root: root, base_url: "https://example.test") }
      assert_includes error.message, "no ds-sample sections"
    end
  end
end
