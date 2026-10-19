# frozen_string_literal: true

require "json"
require "minitest/autorun"
require_relative "../../../_plugins/design_tokens"

class TokensTest < Minitest::Test
  ROOT = File.expand_path("../../..", __dir__)
  NAME = /\A[A-Za-z0-9][A-Za-z0-9_.-]{0,63}\z/
  HEX = /\A#(?:\h{3}|\h{4}|\h{6}|\h{8})\z/
  FUNCTION = /\A(?:rgb|rgba|hsl|hsla|oklch)\([^()]*\)\z/

  # [text token, surface tokens, minimum ratio]
  SHARED_PAIRS = [
    ["ink", %w[surface-0 surface-1 surface-2], 4.5],
    ["ink-soft", %w[surface-0 surface-1 surface-2], 4.5],
    ["gold", %w[surface-0 surface-1 surface-2], 4.5],
    ["gold-bright", %w[surface-0 surface-1 surface-2], 4.5],
    ["blue-bright", %w[surface-0 surface-1 surface-2], 4.5],
    ["red-text", %w[surface-0 surface-1 surface-2], 4.5],
    ["ink-muted", %w[surface-0 surface-1], 4.5],
    ["surface-0", %w[gold], 4.5],
    ["ink-print", %w[paper-news paper-letter paper-slip paper-poster], 4.5],
    ["ink-print-soft", %w[paper-news paper-letter paper-slip paper-poster], 4.5],
    ["wax", %w[paper-news paper-letter paper-slip paper-poster], 4.5],
    ["paper-letter", %w[wax], 4.5]
  ].freeze
  THEME_PAIRS = {
    "noir" => [["blue", %w[surface-0], 4.5]],
    "parchment" => [["ink-muted", %w[surface-2], 4.5], ["blue", %w[surface-0 surface-1 surface-2], 4.5]]
  }.freeze

  def tokens
    @tokens ||= JSON.parse(File.read(File.join(ROOT, "design/tokens.json")))
  end

  def colors
    tokens["color"]["tokens"]
  end

  def resolved(name, theme)
    token = colors.find { |t| t["name"] == name } or raise "no token #{name}"
    value = DesignTokens.color_value(token, theme, "noir")
    alias_name = value[/\A\{(.+)\}\z/, 1]
    alias_name ? resolved(alias_name, theme) : value
  end

  def luminance(hex)
    channels = hex.delete("#").scan(/../).map { |c| c.to_i(16) / 255.0 }
    r, g, b = channels.map { |c| c <= 0.03928 ? c / 12.92 : ((c + 0.055) / 1.055)**2.4 }
    (0.2126 * r) + (0.7152 * g) + (0.0722 * b)
  end

  def contrast(a, b)
    hi, lo = [luminance(a), luminance(b)].sort.reverse
    (hi + 0.05) / (lo + 0.05)
  end

  def test_families_are_list_shaped
    %w[color spacing radius].each do |family|
      assert_kind_of Array, tokens[family]["tokens"], "#{family}.tokens must be a list"
    end
    assert_equal %w[noir parchment], tokens["color"]["themes"].map { |t| t["id"] }
  end

  def test_names_are_valid_and_unique
    names = %w[color spacing radius].flat_map { |f| tokens[f]["tokens"].map { |t| t["name"] } }
    names.each { |n| assert_match NAME, n }
    assert_equal names.size, names.uniq.size, "duplicate token names: #{names.tally.select { |_, c| c > 1 }.keys}"
  end

  def test_every_token_has_a_usage_note
    %w[color spacing radius].each do |family|
      tokens[family]["tokens"].each { |t| refute_empty t["usage"].to_s, "#{t['name']} has no usage" }
    end
  end

  def test_color_values_are_readable
    names = colors.map { |t| t["name"] }
    colors.each do |token|
      values = token["value"].is_a?(Hash) ? token["value"].values : [token["value"]]
      values.each do |value|
        alias_name = value[/\A\{(.+)\}\z/, 1]
        if alias_name
          assert_includes names, alias_name, "#{token['name']} aliases a missing token"
          refute_equal token["name"], alias_name, "#{token['name']} aliases itself"
        else
          assert(value.match?(HEX) || value.match?(FUNCTION), "#{token['name']} has unreadable value #{value}")
        end
      end
    end
  end

  def test_text_pairs_pass_contrast_in_both_themes
    %w[noir parchment].each do |theme|
      (SHARED_PAIRS + THEME_PAIRS[theme]).each do |text, surfaces, minimum|
        surfaces.each do |surface|
          ratio = contrast(resolved(text, theme), resolved(surface, theme))
          assert ratio >= minimum, format("%s: %s on %s is %.2f, needs %.1f", theme, text, surface, ratio, minimum)
        end
      end
    end
  end

  def test_missing_theme_inherits_first_theme
    token = { "name" => "x", "value" => { "noir" => "#111111" } }
    assert_equal "#111111", DesignTokens.color_value(token, "parchment", "noir")
    assert_equal "#222222", DesignTokens.color_value({ "name" => "y", "value" => "#222222" }, "parchment", "noir")
  end

  def test_css_has_noir_root_parchment_theme_and_print
    css = DesignTokens.to_css(tokens)
    root = css[/:root \{(.*?)\n\}/m, 1]
    theme = css[/\[data-theme="parchment"\] \{(.*?)\n\}/m, 1]
    print = css[/@media print \{\n  :root \{(.*?)\n  \}/m, 1]
    assert_includes root, "--surface-0: #1a1a1f;"
    assert_includes root, "--font-display: 'Cinzel Decorative', 'Cinzel', Georgia, serif;"
    assert_includes root, "--text-h2: 1.6rem;"
    assert_includes root, "--leading-body: 1.7;"
    assert_includes root, "--weight-h3: 600;"
    assert_includes root, "--space-xxl: 3rem;"
    assert_includes root, "--radius-round: 50%;"
    assert_includes theme, "--surface-0: #f4ecd8;"
    assert_includes theme, "--red-text: var(--red);"
    assert_includes theme, "--paper-news: #efe9dc;"
    assert_includes print, "--surface-0: #f4ecd8;"
    refute_includes theme, "--space-xs", "non-color tokens belong on :root only"
  end
end
