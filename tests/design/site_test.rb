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
end
