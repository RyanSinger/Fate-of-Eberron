# frozen_string_literal: true

require "minitest/autorun"

# Checks the built site. Run by tests/design.sh with SITE_DIR set.
class SiteTest < Minitest::Test
  SITE_DIR = ENV.fetch("SITE_DIR")

  def read(path)
    File.read(File.join(SITE_DIR, path))
  end

  def test_tokens_css_is_generated_with_both_themes
    css = read("assets/css/tokens.css")
    assert_includes css, "--surface-0: #1a1a1f;"
    assert_includes css, %([data-theme="parchment"])
    assert_includes css, "@media print"
  end

  OLD_NAMES = %w[--bg-dark --bg-medium --bg-light --text-primary --text-secondary --text-muted
                 --accent-gold --accent-blue --accent-red --border-color --shadow-color --spacing-].freeze

  def test_style_css_uses_only_new_token_names
    css = read("assets/css/style.css")
    OLD_NAMES.each { |name| refute_includes css, name }
    refute_match(/font-size: \d*\.?\d+rem/, css, "font sizes must come from --text-* tokens")
  end

  def test_layout_loads_tokens_before_style_and_components_after
    html = read("index.html")
    tokens = html.index("assets/css/tokens.css")
    style = html.index("assets/css/style.css")
    components = html.index("assets/css/components.css")
    assert tokens && style && components, "all three stylesheets must be linked"
    assert tokens < style && style < components, "order must be tokens, style, components"
  end

  def test_sample_page_has_character_sections
    html = read("design-sample.html")
    %w[Aspect Dragonmark Stunt Pyramid Track Consequences].each do |name|
      assert_includes html, %(data-component="#{name}"), "missing sample section #{name}"
    end
  end

  def test_sample_page_is_not_in_search
    refute_includes read("search.json"), "Design System Sample"
  end

  def test_sample_page_has_reference_sections
    html = read("design-sample.html")
    %w[Statblock Tier Ladder Outcomes Die Actions].each do |name|
      assert_includes html, %(data-component="#{name}"), "missing sample section #{name}"
    end
  end
end
