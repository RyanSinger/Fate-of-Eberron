# Fate of Eberron Design System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build one token and component system that the Jekyll site uses through generated CSS and includes, and that a claude.ai Design System artifact is published from.

**Architecture:** `design/tokens.json` (in the claude.ai Design System list format) is the single source. A Jekyll generator plugin turns it into `/assets/css/tokens.css` at build time, with noir on `:root` and parchment under `[data-theme="parchment"]` and `@media print`. Game components live in `assets/css/components.css` plus Liquid includes in `_includes/components/`; handouts live in `assets/css/handouts.css`. A staging script and a `design-sync` skill publish the system to claude.ai, cutting component previews from the built `design-sample.html`.

**Tech Stack:** Jekyll 4.4 (kramdown GFM), Ruby 4.0 with stdlib minitest (run with plain `ruby`, not `bundle exec`, because minitest is not in the bundle), Liquid includes, plain CSS custom properties, bash test runner in `tests/`.

**Spec:** `docs/superpowers/specs/2026-10-19-design-system-design.md`

## Global Constraints

- Never use em dashes or en dashes in any written output: docs, comments, commit messages, CSS `content` strings. Use colons, commas, periods. For a minus sign in CSS use the escape `"\2212"`.
- Follow the CLAUDE.md writing rules (no "testament", "vibrant", "delve", "Additionally,", "serves as", etc.) in README and SKILL prose.
- No raw hex colors in `style.css`, `components.css` or `handouts.css`. Every color comes from a token in `design/tokens.json`. `rgba()` glow literals already in `style.css` may stay.
- Token names match `[A-Za-z0-9][A-Za-z0-9_.-]{0,63}` and are unique across color, spacing and radius.
- Text pairs pass 4.5:1 in both themes; noir `ink-muted` is never placed on `surface-2`.
- Fonts load only from Google Fonts. Handout fonts load only on pages with `handouts: true`.
- Every commit ends with `Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>` and is pushed right after (`git push`), per CLAUDE.md.
- Stress boxes carry no numbers (Fate Condensed: every box is one shift).
- Do not change any prose in `npcs.md` or `gm-guide.md`.
- Live site for visual comparison: https://ryansinger.github.io/Fate-of-Eberron/

## Review Focus

1. A stat block migration run twice must not double wrap blocks, and the Quick Reference table rows `| Physical | [ ]1 [ ]2 [ ]3 |` must stay untouched. (Task 5 tests.)
2. Bad include parameters must degrade, not break: `boxes=0`, `boxes="abc"`, `boxes=50`, capitalized or unknown consequence slots, `highlight="+4"`. (Task 3, 4 and 6 fixture tests.)
3. Printing any guide page must use parchment colors, and `?theme=` with any value other than `parchment` must do nothing. (Task 1 CSS test, Task 2 manual browser check.)
4. A handout on a noir page keeps its paper colors, and a sending longer than 25 words shows 25 filled ticks plus an over limit marker. (Task 6 fixture tests.)
5. Staging for claude.ai must fail loudly when a sample section has no README or no sections are found, rather than publishing a half empty system. (Task 8 unit tests.)

---

### Task 1: Tokens and the generator plugin

**Files:**
- Create: `design/tokens.json`
- Create: `_plugins/design_tokens.rb`
- Create: `tests/design.sh`
- Create: `tests/design/unit/tokens_test.rb`
- Create: `tests/design/site_test.rb`
- Modify: `tests/run.sh` (call `design.sh`)
- Modify: `_config.yml` (exclude `design` and `script`)

**Interfaces:**
- Produces: CSS custom properties used by every later task. Colors: `--surface-0`, `--surface-1`, `--surface-2`, `--ink`, `--ink-soft`, `--ink-muted`, `--gold`, `--gold-bright`, `--blue`, `--blue-bright`, `--red`, `--red-text`, `--rule`, `--shadow`, `--paper-news`, `--paper-letter`, `--paper-slip`, `--paper-poster`, `--ink-print`, `--ink-print-soft`, `--wax`. Fonts: `--font-display`, `--font-heading`, `--font-body`, `--font-mono`, `--font-blackletter`, `--font-news`, `--font-letter`, `--font-typewriter`, `--font-poster`. Type: `--text-<style>`, `--leading-<style>`, `--weight-<style>` for styles `display`, `title`, `h1`, `h2`, `h3`, `h4`, `body`, `small`, `caption`. Spacing: `--space-xs` through `--space-xxl`. Radius: `--radius-0`, `--radius-sm`, `--radius-round`.
- Produces: Ruby module `DesignTokens` with `DesignTokens.to_css(tokens_hash) -> String`, `DesignTokens.color_value(token, theme, first_theme) -> String`, `DesignTokens::PRINT_THEME = "parchment"`.
- Produces: `tests/design.sh` with sections later tasks extend; `tests/design/site_test.rb` reading `ENV["SITE_DIR"]`.

- [ ] **Step 1: Write the token file**

Create `design/tokens.json`:

```json
{
  "name": "Fate of Eberron",
  "version": 1,
  "color": {
    "themes": [
      { "id": "noir", "name": "Noir" },
      { "id": "parchment", "name": "Parchment" }
    ],
    "tokens": [
      { "name": "surface-0", "value": { "noir": "#1a1a1f", "parchment": "#f4ecd8" }, "usage": "Page background, paper." },
      { "name": "surface-1", "value": { "noir": "#252530", "parchment": "#ebe0c6" }, "usage": "Nav, cards, TOC, component panels." },
      { "name": "surface-2", "value": { "noir": "#2f2f3a", "parchment": "#e0d3b4" }, "usage": "Inset panels, table header and hover, highlighted ladder step." },
      { "name": "ink", "value": { "noir": "#e8e6e3", "parchment": "#1f1b16" }, "usage": "Body text on any surface." },
      { "name": "ink-soft", "value": { "noir": "#a8a5a0", "parchment": "#4a4238" }, "usage": "Secondary text, component labels, stress box borders, on any surface." },
      { "name": "ink-muted", "value": { "noir": "#918e89", "parchment": "#5f5444" }, "usage": "Captions and metadata. Noir: surface-0 and surface-1 only, never surface-2." },
      { "name": "gold", "value": { "noir": "#c9a227", "parchment": "#735709" }, "usage": "Headings, accents, active states, dragonmark borders. Text on any surface." },
      { "name": "gold-bright", "value": { "noir": "#dbb84d", "parchment": "#614a07" }, "usage": "Hover and emphasis (em) text on any surface." },
      { "name": "blue", "value": { "noir": "#4a90a4", "parchment": "#2a5c6c" }, "usage": "Fills and borders. Noir: text on surface-0 only." },
      { "name": "blue-bright", "value": { "noir": "#6bb3c9", "parchment": "#1f4f5e" }, "usage": "Links, h3, code text, focus rings, on any surface." },
      { "name": "red", "value": { "noir": "#a44a4a", "parchment": "#8a3030" }, "usage": "Fills and borders for consequences, danger, failure. Not text on noir." },
      { "name": "red-text", "value": { "noir": "#dc7f7f", "parchment": "{red}" }, "usage": "Text for consequences, failure, danger, on any surface." },
      { "name": "rule", "value": { "noir": "#3a3a45", "parchment": "#b9a67c" }, "usage": "Decorative borders and dividers. Not for control borders (too faint)." },
      { "name": "shadow", "value": { "noir": "rgba(0, 0, 0, 0.4)", "parchment": "rgba(60, 40, 10, 0.15)" }, "usage": "Drop shadows." },
      { "name": "paper-news", "value": "#efe9dc", "usage": "Korranberg Chronicle stock. Same in both themes." },
      { "name": "paper-letter", "value": "#f6efdd", "usage": "House letterhead stock; text on the wax seal. Same in both themes." },
      { "name": "paper-slip", "value": "#ece4cf", "usage": "Sending message slip stock. Same in both themes." },
      { "name": "paper-poster", "value": "#e8dcc0", "usage": "Wanted poster stock. Same in both themes." },
      { "name": "ink-print", "value": "#1c1813", "usage": "Text on any paper token." },
      { "name": "ink-print-soft", "value": "#4d4235", "usage": "Secondary text on any paper token." },
      { "name": "wax", "value": "#7a1f1f", "usage": "Seals, stamps, poster reward line. Text on any paper token." }
    ]
  },
  "type": {
    "fonts": [],
    "families": {
      "display": "'Cinzel Decorative', 'Cinzel', Georgia, serif",
      "heading": "'Cinzel', Georgia, serif",
      "body": "'Open Sans', -apple-system, BlinkMacSystemFont, sans-serif",
      "mono": "'Fira Code', Consolas, monospace",
      "blackletter": "'UnifrakturMaguntia', 'Old English Text MT', serif",
      "news": "'Old Standard TT', Georgia, serif",
      "letter": "'Cormorant Garamond', Georgia, serif",
      "typewriter": "'Courier Prime', 'Courier New', monospace",
      "poster": "'Playfair Display SC', Georgia, serif"
    },
    "groups": [
      { "name": "Display", "family": "display", "styles": [
        { "name": "display", "fontSize": "3.2rem", "lineHeight": "1.2", "fontWeight": 400 }
      ] },
      { "name": "Headings", "family": "heading", "styles": [
        { "name": "title", "fontSize": "2.5rem", "lineHeight": "1.3", "fontWeight": 600 },
        { "name": "h1", "fontSize": "2rem", "lineHeight": "1.3", "fontWeight": 600 },
        { "name": "h2", "fontSize": "1.6rem", "lineHeight": "1.3", "fontWeight": 600 },
        { "name": "h3", "fontSize": "1.3rem", "lineHeight": "1.3", "fontWeight": 600 },
        { "name": "h4", "fontSize": "1.2rem", "lineHeight": "1.3", "fontWeight": 600 }
      ] },
      { "name": "Text", "family": "body", "styles": [
        { "name": "body", "fontSize": "1rem", "lineHeight": "1.7", "fontWeight": 400 },
        { "name": "small", "fontSize": "0.9rem", "lineHeight": "1.6", "fontWeight": 400 },
        { "name": "caption", "fontSize": "0.8rem", "lineHeight": "1.5", "fontWeight": 400 }
      ] }
    ]
  },
  "spacing": {
    "tokens": [
      { "name": "space-xs", "value": "0.25rem", "usage": "Gaps between boxes, tight label spacing." },
      { "name": "space-sm", "value": "0.5rem", "usage": "Component inner padding (vertical)." },
      { "name": "space-md", "value": "1rem", "usage": "Paragraph spacing, component inner padding (horizontal)." },
      { "name": "space-lg", "value": "1.5rem", "usage": "Card padding, block margins." },
      { "name": "space-xl", "value": "2rem", "usage": "Section padding, stat block margins." },
      { "name": "space-xxl", "value": "3rem", "usage": "Space above headings, between major sections." }
    ]
  },
  "radius": {
    "tokens": [
      { "name": "radius-0", "value": "0px", "usage": "Default. Art deco corners are square." },
      { "name": "radius-sm", "value": "4px", "usage": "Site cards, code, tables, refresh cost tags." },
      { "name": "radius-round", "value": "50%", "usage": "Fate dice faces, consequence shift circles, seals, countdown dials." }
    ]
  }
}
```

- [ ] **Step 2: Write the failing unit test**

Create `tests/design/unit/tokens_test.rb`:

```ruby
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
```

- [ ] **Step 3: Run the test to verify it fails**

Run: `ruby tests/design/unit/tokens_test.rb`
Expected: LoadError, `cannot load such file -- .../_plugins/design_tokens`

- [ ] **Step 4: Write the plugin**

Create `_plugins/design_tokens.rb`:

```ruby
# frozen_string_literal: true

require "json"

# Turns design/tokens.json (claude.ai Design System list format) into CSS
# custom properties. The first theme goes on :root; every other theme gets a
# [data-theme] block, and PRINT_THEME is also applied under @media print.
module DesignTokens
  PRINT_THEME = "parchment"
  ALIAS = /\A\{([A-Za-z0-9][A-Za-z0-9_.-]*)\}\z/

  module_function

  def theme_ids(tokens)
    tokens.fetch("color").fetch("themes").map { |t| t.fetch("id") }
  end

  # A plain string value belongs to every theme; a missing theme inherits the first theme.
  def color_value(token, theme, first_theme)
    value = token.fetch("value")
    return value if value.is_a?(String)

    value.fetch(theme) { value.fetch(first_theme) }
  end

  def css_value(value)
    match = ALIAS.match(value)
    match ? "var(--#{match[1]})" : value
  end

  def color_pairs(tokens, theme)
    first = theme_ids(tokens).first
    tokens["color"]["tokens"].map { |t| [t["name"], css_value(color_value(t, theme, first))] }
  end

  def base_pairs(tokens)
    type = tokens.fetch("type")
    pairs = type.fetch("families").map { |key, stack| ["font-#{key}", stack] }
    type.fetch("groups").each do |group|
      group.fetch("styles").each do |style|
        name = style.fetch("name")
        pairs << ["text-#{name}", style.fetch("fontSize")]
        pairs << ["leading-#{name}", style.fetch("lineHeight").to_s]
        pairs << ["weight-#{name}", style.fetch("fontWeight").to_s]
      end
    end
    %w[spacing radius].each do |family|
      tokens.fetch(family).fetch("tokens").each { |t| pairs << [t["name"], t["value"]] }
    end
    pairs
  end

  def declarations(pairs, indent)
    pairs.map { |name, value| "#{indent}--#{name}: #{value};" }.join("\n")
  end

  def to_css(tokens)
    primary, *others = theme_ids(tokens)
    css = +"/* Generated from design/tokens.json by _plugins/design_tokens.rb. Do not edit. */\n"
    css << ":root {\n#{declarations(color_pairs(tokens, primary) + base_pairs(tokens), '  ')}\n}\n"
    others.each do |theme|
      css << "\n[data-theme=\"#{theme}\"] {\n#{declarations(color_pairs(tokens, theme), '  ')}\n}\n"
    end
    if others.include?(PRINT_THEME)
      css << "\n@media print {\n  :root {\n#{declarations(color_pairs(tokens, PRINT_THEME), '    ')}\n  }\n}\n"
    end
    css
  end
end

if defined?(Jekyll)
  module DesignTokens
    # Adds /assets/css/tokens.css to the site on every build.
    class Generator < Jekyll::Generator
      safe true
      priority :high

      def generate(site)
        source = File.join(site.source, "design", "tokens.json")
        page = Jekyll::PageWithoutAFile.new(site, site.source, "assets/css", "tokens.css")
        page.content = DesignTokens.to_css(JSON.parse(File.read(source)))
        page.data["layout"] = nil
        site.pages << page
      end
    end
  end
end
```

- [ ] **Step 5: Run the unit test to verify it passes**

Run: `ruby tests/design/unit/tokens_test.rb`
Expected: `7 runs, ... 0 failures, 0 errors`

- [ ] **Step 6: Exclude design sources from the site**

In `_config.yml`, add two entries to the end of the `exclude:` list:

```yaml
  - tests
  - design
  - script
```

(`tests` is already the last entry; add `design` and `script` after it.)

- [ ] **Step 7: Write the site test and the design test runner**

Create `tests/design/site_test.rb`:

```ruby
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
```

Create `tests/design.sh`:

```bash
#!/usr/bin/env bash
# Design system tests: tokens, built site, component includes, raw color audit

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/lib/helpers.sh"

echo "=== Design System Tests ==="

WORK_DIR="$(mktemp -d)"
trap 'rm -rf "$WORK_DIR"' EXIT

section "Unit tests"
for test_file in "$SCRIPT_DIR"/design/unit/*_test.rb; do
  name="$(basename "$test_file" .rb)"
  if ruby "$test_file"; then
    pass "$name"
  else
    fail "$name" "see minitest output above"
  fi
done

section "Site build"
if (cd "$PROJECT_ROOT" && bundle exec jekyll build --quiet -d "$WORK_DIR/site"); then
  pass "jekyll build"
  if SITE_DIR="$WORK_DIR/site" ruby "$SCRIPT_DIR/design/site_test.rb"; then
    pass "site_test"
  else
    fail "site_test" "see minitest output above"
  fi
else
  fail "jekyll build" "bundle exec jekyll build failed"
fi

summary
```

Run: `chmod +x tests/design.sh`

- [ ] **Step 8: Hook design tests into the suite**

In `tests/run.sh`, replace:

```bash
# Always run lint tests
bash "$SCRIPT_DIR/lint.sh"
lint_exit=$?

set -e

if [ "$LINT_ONLY" = true ]; then
  exit $lint_exit
fi
```

with:

```bash
# Always run lint and design tests
bash "$SCRIPT_DIR/lint.sh"
lint_exit=$?

echo ""
bash "$SCRIPT_DIR/design.sh"
design_exit=$?

set -e

if [ "$LINT_ONLY" = true ]; then
  if [ $lint_exit -ne 0 ] || [ $design_exit -ne 0 ]; then
    exit 1
  fi
  exit 0
fi
```

and replace the final combined exit:

```bash
if [ $lint_exit -ne 0 ] || [ $smoke_exit -ne 0 ]; then
```

with:

```bash
if [ $lint_exit -ne 0 ] || [ $design_exit -ne 0 ] || [ $smoke_exit -ne 0 ]; then
```

- [ ] **Step 9: Run the design suite**

Run: `bash tests/design.sh`
Expected: `[PASS] tokens_test`, `[PASS] jekyll build`, `[PASS] site_test`, `=== Results: 3/3 passed, 0 failed, 0 skipped ===`

- [ ] **Step 10: Commit and push**

```bash
git add design/tokens.json _plugins/design_tokens.rb tests/design.sh tests/design tests/run.sh _config.yml
git commit -m "Add design tokens and generator plugin

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```

---

### Task 2: Move the site onto tokens

**Files:**
- Modify: `assets/css/style.css` (whole file: `:root`, every `var()` name, font sizes, print block)
- Modify: `_layouts/default.html:8` (stylesheet links)
- Modify: `assets/js/main.js:1-3` (theme preview)
- Modify: `tests/design/site_test.rb`, `tests/design.sh`

**Interfaces:**
- Consumes: all custom properties from Task 1.
- Produces: `default.html` loads `tokens.css`, then `style.css`, then `components.css` (the link is added here; the file arrives in Task 3). `<html data-theme="parchment">` when the URL has `?theme=parchment`.

- [ ] **Step 1: Write the failing tests**

Append to the `SiteTest` class in `tests/design/site_test.rb`:

```ruby
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
```

Add a raw color audit section to `tests/design.sh`, just before `summary`:

```bash
section "No raw hex colors"
for css in style components handouts; do
  file="$PROJECT_ROOT/assets/css/$css.css"
  if [ ! -f "$file" ]; then
    skip "$css.css" "not created yet"
    continue
  fi
  if hits=$(grep -nE '#[0-9a-fA-F]{3,8}([^0-9a-zA-Z_-]|$)' "$file"); then
    fail "$css.css has no raw hex" "$hits"
  else
    pass "$css.css has no raw hex"
  fi
done
```

- [ ] **Step 2: Run to verify failure**

Run: `bash tests/design.sh`
Expected: `[FAIL] site_test` (old names, rem font sizes, missing links) and `[FAIL] style.css has no raw hex`

- [ ] **Step 3: Replace the `:root` block**

In `assets/css/style.css`, replace lines 3 to 35 (the whole `:root { ... }` block from `:root {` through the closing `}` after `--nav-height: 60px;`) with:

```css
/* Colors, type, spacing and radius come from tokens.css, generated from design/tokens.json */
:root {
  /* Layout */
  --max-width: 900px;
  --nav-height: 60px;
}
```

- [ ] **Step 4: Rename token references**

Run this once from the repo root (BSD sed on macOS):

```bash
sed -i '' \
  -e 's/var(--bg-dark)/var(--surface-0)/g' \
  -e 's/var(--bg-medium)/var(--surface-1)/g' \
  -e 's/var(--bg-light)/var(--surface-2)/g' \
  -e 's/var(--text-primary)/var(--ink)/g' \
  -e 's/var(--text-secondary)/var(--ink-soft)/g' \
  -e 's/var(--text-muted)/var(--ink-muted)/g' \
  -e 's/var(--accent-gold-light)/var(--gold-bright)/g' \
  -e 's/var(--accent-gold)/var(--gold)/g' \
  -e 's/var(--accent-blue-light)/var(--blue-bright)/g' \
  -e 's/var(--accent-blue)/var(--blue)/g' \
  -e 's/var(--accent-red)/var(--red)/g' \
  -e 's/var(--border-color)/var(--rule)/g' \
  -e 's/var(--shadow-color)/var(--shadow)/g' \
  -e 's/var(--spacing-\([a-z]*\))/var(--space-\1)/g' \
  -e "s/font-family: 'Fira Code', 'Consolas', monospace;/font-family: var(--font-mono);/" \
  -e 's/border-radius: 4px;/border-radius: var(--radius-sm);/g' \
  -e 's/border-radius: 0 4px 4px 0;/border-radius: 0 var(--radius-sm) var(--radius-sm) 0;/' \
  assets/css/style.css
```

Then check: `grep -nE 'var\(--(bg|text-(primary|secondary|muted)|accent|border-color|shadow-color|spacing)' assets/css/style.css` prints nothing.

- [ ] **Step 5: Snap font sizes to the scale**

Edit each declaration below (selector shown so each is unique). `body { font-size: 16px; }` and `code { font-size: 0.9em; }` stay as they are.

| selector (context) | old | new |
|---|---|---|
| `.nav-links a` | `font-size: 0.85rem;` | `font-size: var(--text-small);` |
| `.hero h1` | `font-size: 3.2rem;` | `font-size: var(--text-display);` |
| `.hero em` | `font-size: 1.15rem;` | `font-size: var(--text-h4);` |
| `.guide-header h1` | `font-size: 2.5rem;` | `font-size: var(--text-title);` |
| `.guide-description` | `font-size: 1.1rem;` | `font-size: var(--text-h4);` |
| `.toc h2` | `font-size: 1.2rem;` | `font-size: var(--text-h4);` |
| `.toc-sublist` | `font-size: 0.9rem;` | `font-size: var(--text-small);` |
| `h1 { ... }` | `font-size: 2rem;` | `font-size: var(--text-h1);` |
| `h2 { ... }` | `font-size: 1.6rem;` | `font-size: var(--text-h2);` |
| `h3 { ... }` (line with `blue-bright`) | `font-size: 1.3rem;` | `font-size: var(--text-h3);` |
| `h4 { ... }` | `font-size: 1.1rem;` | `font-size: var(--text-h4);` |
| `h5 { ... }` | `font-size: 1rem;` | `font-size: var(--text-body);` |
| `th` | `font-size: 0.85rem;` | `font-size: var(--text-small);` |
| `.action p` | `font-size: 0.95rem;` | `font-size: var(--text-small);` |
| `.site-footer p` | `font-size: 0.85rem;` | `font-size: var(--text-caption);` |
| mobile `.nav-links a` | `font-size: 0.9rem;` | `font-size: var(--text-small);` |
| mobile `.hero h1` | `font-size: 2.2rem;` | `font-size: var(--text-h1);` |
| mobile `.guide-header h1` | `font-size: 1.4rem;` | `font-size: var(--text-h3);` |
| mobile `.guide-header .guide-description` | `font-size: 0.9rem;` | `font-size: var(--text-small);` |
| mobile `h2 { ... }` | `font-size: 1.4rem;` | `font-size: var(--text-h3);` |
| mobile `h3 { ... }` | `font-size: 1.2rem;` | `font-size: var(--text-h4);` |
| mobile `table` | `font-size: 0.9rem;` | `font-size: var(--text-small);` |
| `.search-toggle` | `font-size: 1.2rem;` | `font-size: var(--text-h4);` |
| `.search-input` | `font-size: 0.9rem;` | `font-size: var(--text-small);` |
| `.search-results a` | `font-size: 0.85rem;` | `font-size: var(--text-small);` |
| `.search-results .search-snippet` | `font-size: 0.8rem;` | `font-size: var(--text-caption);` |
| `.back-to-top` | `font-size: 1.2rem;` | `font-size: var(--text-h4);` |

Check: `grep -n 'font-size: [0-9.]*rem' assets/css/style.css` prints nothing.

- [ ] **Step 6: Theme the icons and replace the print overrides**

In `assets/css/style.css`, after the `.fate-dice p { margin: 0; }` rule, add:

```css
/* Icons are dark multi-tone art: inverted on noir, shown as drawn on parchment */
[data-theme="parchment"] .action-icon,
[data-theme="parchment"] .fate-die-icon {
  filter: none;
}
```

In the `@media print` block, delete these two rules (parchment tokens now color print):

```css
  body {
    background: white;
    color: black;
  }
```

```css
  blockquote {
    border-left-color: #333;
    background: #f5f5f5;
  }
```

and add inside the same `@media print` block:

```css
  .action-icon,
  .fate-die-icon {
    filter: none;
  }
```

- [ ] **Step 7: Link the stylesheets**

In `_layouts/default.html`, replace:

```html
  <link rel="stylesheet" href="{{ '/assets/css/style.css' | relative_url }}">
```

with:

```html
  <link rel="stylesheet" href="{{ '/assets/css/tokens.css' | relative_url }}">
  <link rel="stylesheet" href="{{ '/assets/css/style.css' | relative_url }}">
  <link rel="stylesheet" href="{{ '/assets/css/components.css' | relative_url }}">
```

Create an empty-for-now `assets/css/components.css` so the link resolves:

```css
/* Fate of Eberron game components. Colors, type and spacing come from tokens.css. */
```

- [ ] **Step 8: Add the theme preview switch**

In `assets/js/main.js`, insert after line 1 (`// Fate of Eberron - UI interactions`) and its blank line:

```js
// Theme preview: ?theme=parchment shows the print theme on screen. Any other value is ignored.
(function () {
  var theme = new URLSearchParams(window.location.search).get('theme');
  if (theme === 'parchment') {
    document.documentElement.setAttribute('data-theme', 'parchment');
  }
})();

```

- [ ] **Step 9: Run tests**

Run: `bash tests/design.sh`
Expected: all PASS; `components.css` and `style.css` report no raw hex; `handouts.css` SKIP.

- [ ] **Step 10: Visual check against the live site**

Run `bundle exec jekyll serve` in the background. In a browser compare these pages at desktop width and at 375px width with the live site:
- `http://localhost:4000/Fate-of-Eberron/` vs https://ryansinger.github.io/Fate-of-Eberron/
- `/players-guide/` (actions grid, fate dice, tables, blockquotes)
- `/npcs/`

Expected differences only: footer text and TOC sublinks slightly lighter, footer text 0.05rem smaller, `h4` and lead text 0.1rem larger, mobile hero title 0.2rem smaller. Anything else is a bug.

Then open `/players-guide/?theme=parchment`: cream background, dark text, icons not inverted, links dark teal. Open `/players-guide/?theme=evil`: noir, unchanged. Print preview `/players-guide/`: parchment colors (background colors may be dropped by the browser; text must be dark).

- [ ] **Step 11: Commit and push**

```bash
git add assets/css/style.css assets/css/components.css _layouts/default.html assets/js/main.js tests/design/site_test.rb tests/design.sh
git commit -m "Move site styles onto design tokens, fix muted text contrast

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```

---

### Task 3: Character components and the sample page

**Files:**
- Modify: `assets/css/components.css`
- Create: `_includes/components/track.html`, `_includes/components/consequences.html`, `_includes/components/pyramid.html`
- Create: `design-sample.md`
- Modify: `search.json:5` (honor `search: false`)
- Create: `tests/design/fixtures/_config.yml`, `tests/design/fixtures/index.md`, `tests/design/includes_test.rb`
- Modify: `tests/design.sh`, `tests/design/site_test.rb`

**Interfaces:**
- Consumes: tokens from Task 1.
- Produces classes: `.aspect` (attrs `data-label`, `data-invokes` 1 to 3), `.aspect--dragonmark`, `.aspect__sigil`, `.stunt` (attrs `data-source`, `data-cost`), `.stunt--house`, `.track`, `.track--clock`, `.track__label`, `.track__dial`, `.track__box`, `.consequences`, `.consequence`, `.consequence--<slot>`, `.consequence__label`, `.consequence__shift`, `.consequence__line`, `.pyramid`, `.pyramid__row`, `.pyramid__rung`, `.pyramid__slot`, `.ds-sample`.
- Produces includes: `components/track.html` (`label` default `"Stress"`, `boxes` default 3 clamped 1 to 12, `style="clock"`), `components/consequences.html` (`slots` default `"mild,moderate,severe"`), `components/pyramid.html` (`skills` comma list).
- Produces: `design-sample.md` with one `<section class="ds-sample" data-component="Name" data-group="Group" data-height="N" markdown="1">` per component. Task 8 depends on this exact attribute set.

- [ ] **Step 1: Write the fixture page and failing include tests**

Create `tests/design/fixtures/_config.yml`:

```yaml
markdown: kramdown
kramdown:
  input: GFM
  hard_wrap: false
```

Create `tests/design/fixtures/index.md`:

```markdown
---
---

<section id="track-default">{% include components/track.html %}</section>

<section id="track-clock">{% include components/track.html label="Countdown" boxes=6 style="clock" %}</section>

<section id="track-zero">{% include components/track.html boxes=0 %}</section>

<section id="track-text">{% include components/track.html boxes="abc" %}</section>

<section id="track-huge">{% include components/track.html boxes=50 %}</section>

<section id="cons-default">{% include components/consequences.html %}</section>

<section id="cons-upper">{% include components/consequences.html slots="Mild, Severe" %}</section>

<section id="cons-unknown">{% include components/consequences.html slots="mild,extreme" %}</section>

<section id="pyramid-empty">{% include components/pyramid.html %}</section>

<section id="pyramid-skills">{% include components/pyramid.html skills="Crafts,Lore,Investigate,Notice,Will,Rapport,Resources,Contacts,Empathy,Athletics,Stealth" %}</section>
```

Create `tests/design/includes_test.rb`:

```ruby
# frozen_string_literal: true

require "minitest/autorun"

# Renders _includes/components through a fixture site. Run by tests/design.sh with FIXTURE_SITE set.
class IncludesTest < Minitest::Test
  HTML = File.read(File.join(ENV.fetch("FIXTURE_SITE"), "index.html"))

  def fragment(id)
    HTML[%r{<section id="#{id}">(.*?)</section>}m, 1] or flunk("fixture section #{id} missing")
  end

  def count(id, needle)
    fragment(id).scan(needle).size
  end

  def test_track_defaults_to_three_stress_boxes
    assert_equal 3, count("track-default", 'class="track__box"')
    assert_includes fragment("track-default"), '<span class="track__label">Stress</span>'
  end

  def test_clock_track_has_dial_and_segment_count
    html = fragment("track-clock")
    assert_includes html, "track--clock"
    assert_includes html, 'class="track__dial"'
    assert_includes html, "--segments: 6"
    assert_equal 6, count("track-clock", 'class="track__box"')
  end

  def test_track_box_count_is_clamped
    assert_equal 1, count("track-zero", 'class="track__box"')
    assert_equal 1, count("track-text", 'class="track__box"')
    assert_equal 12, count("track-huge", 'class="track__box"')
  end

  def test_consequences_show_shift_values
    html = fragment("cons-default")
    %w[mild moderate severe].each { |s| assert_includes html, "consequence--#{s}" }
    assert_equal %w[2 4 6], html.scan(%r{<span class="consequence__shift">(\d)</span>}).flatten
  end

  def test_consequence_slots_ignore_case_and_spaces
    html = fragment("cons-upper")
    assert_includes html, "consequence--mild"
    assert_includes html, "consequence--severe"
    assert_equal %w[2 6], html.scan(%r{<span class="consequence__shift">(\d)</span>}).flatten
  end

  def test_unknown_consequence_slot_has_no_shift
    html = fragment("cons-unknown")
    assert_includes html, "consequence--extreme"
    assert_equal %w[2], html.scan(%r{<span class="consequence__shift">(\d)</span>}).flatten
  end

  def test_pyramid_has_ten_slots_in_four_rungs
    assert_equal 4, count("pyramid-empty", 'class="pyramid__row"')
    assert_equal 10, count("pyramid-empty", 'class="pyramid__slot"')
    assert_includes fragment("pyramid-empty"), "Great (+4)"
  end

  def test_pyramid_fills_top_down_and_drops_extras
    html = fragment("pyramid-skills")
    slots = html.scan(%r{<span class="pyramid__slot">([^<]*)</span>}).flatten
    assert_equal 10, slots.size
    assert_equal "Crafts", slots.first
    assert_equal "Athletics", slots.last
    refute_includes html, "Stealth"
  end
end
```

Add an includes section to `tests/design.sh`, just before `section "No raw hex colors"`:

```bash
section "Component includes"
mkdir -p "$WORK_DIR/fixture-src"
cp -R "$PROJECT_ROOT/_includes" "$WORK_DIR/fixture-src/_includes"
cp "$SCRIPT_DIR/design/fixtures/_config.yml" "$SCRIPT_DIR/design/fixtures/index.md" "$WORK_DIR/fixture-src/"
if (cd "$PROJECT_ROOT" && bundle exec jekyll build --quiet -s "$WORK_DIR/fixture-src" -d "$WORK_DIR/fixture-site"); then
  if FIXTURE_SITE="$WORK_DIR/fixture-site" ruby "$SCRIPT_DIR/design/includes_test.rb"; then
    pass "includes_test"
  else
    fail "includes_test" "see minitest output above"
  fi
else
  fail "fixture build" "jekyll could not render tests/design/fixtures"
fi
```

Append to `SiteTest` in `tests/design/site_test.rb`:

```ruby
  def test_sample_page_has_character_sections
    html = read("design-sample.html")
    %w[Aspect Dragonmark Stunt Pyramid Track Consequences].each do |name|
      assert_includes html, %(data-component="#{name}"), "missing sample section #{name}"
    end
  end

  def test_sample_page_is_not_in_search
    refute_includes read("search.json"), "Design System Sample"
  end
```

- [ ] **Step 2: Run to verify failure**

Run: `bash tests/design.sh`
Expected: `[FAIL] fixture build` (missing `components/track.html`) and `[FAIL] site_test` (no `design-sample.html`)

- [ ] **Step 3: Write the includes**

Create `_includes/components/track.html`:

```liquid
{%- comment -%}
  Track: a row of boxes for stress, refresh or countdowns.
  label (default "Stress"), boxes (default 3, clamped 1 to 12), style="clock" adds a segmented dial.
{%- endcomment -%}
{%- assign boxes = include.boxes | default: 3 | plus: 0 -%}
{%- if boxes < 1 -%}{%- assign boxes = 1 -%}{%- endif -%}
{%- if boxes > 12 -%}{%- assign boxes = 12 -%}{%- endif -%}
{%- assign label = include.label | default: "Stress" -%}
<span class="track{% if include.style == 'clock' %} track--clock{% endif %}" role="group" aria-label="{{ label }}" style="--segments: {{ boxes }}"><span class="track__label">{{ label }}</span>{% if include.style == 'clock' %}<span class="track__dial" aria-hidden="true"></span>{% endif %}{% for i in (1..boxes) %}<label class="track__box"><input type="checkbox" aria-label="{{ label }} {{ i }}"></label>{% endfor %}</span>
```

Create `_includes/components/consequences.html`:

```liquid
{%- comment -%}
  Consequence slots with shift values: mild 2, moderate 4, severe 6.
  slots (default "mild,moderate,severe"), any case, spaces allowed. Unknown slots get no value.
{%- endcomment -%}
{%- assign slots = include.slots | default: "mild,moderate,severe" | downcase | split: "," -%}
<span class="consequences">{% for raw in slots %}{% assign slot = raw | strip %}{% assign shift = "" %}{% case slot %}{% when "mild" %}{% assign shift = "2" %}{% when "moderate" %}{% assign shift = "4" %}{% when "severe" %}{% assign shift = "6" %}{% endcase %}<span class="consequence consequence--{{ slot }}"><span class="consequence__label">{{ slot | capitalize }}</span>{% if shift != "" %}<span class="consequence__shift">{{ shift }}</span>{% endif %}<span class="consequence__line"></span></span>{% endfor %}</span>
```

Create `_includes/components/pyramid.html`:

```liquid
{%- comment -%}
  Skill pyramid: Great (+4) x1, Good (+3) x2, Fair (+2) x3, Average (+1) x4.
  skills: comma list filled top to bottom; empty slots are write lines; extras past ten are dropped.
{%- endcomment -%}
{%- assign skills = include.skills | default: "" | split: "," -%}
{%- assign rungs = "Great (+4)|Good (+3)|Fair (+2)|Average (+1)" | split: "|" -%}
{%- assign n = 0 -%}
<div class="pyramid">{% for rung in rungs %}{% assign slots = forloop.index %}<div class="pyramid__row"><span class="pyramid__rung">{{ rung }}</span>{% for s in (1..slots) %}{% assign skill = skills[n] | strip %}<span class="pyramid__slot">{{ skill }}</span>{% assign n = n | plus: 1 %}{% endfor %}</div>{% endfor %}</div>
```

- [ ] **Step 4: Write the component styles**

Replace `assets/css/components.css` with:

```css
/* Fate of Eberron game components. Colors, type and spacing come from tokens.css. */

/* ================================
   SAMPLE PAGE
   ================================ */
.ds-sample {
  margin: var(--space-lg) 0 var(--space-xxl);
}

/* ================================
   ASPECT
   ================================ */
.aspect {
  position: relative;
  margin: var(--space-md) 0;
  padding: var(--space-sm) var(--space-md);
  background: var(--surface-1);
  border: 1px solid var(--rule);
  border-radius: var(--radius-0);
}

.aspect::before {
  content: attr(data-label);
  display: block;
  font-family: var(--font-heading);
  font-size: var(--text-caption);
  line-height: var(--leading-caption);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--ink-soft);
}

.aspect p {
  margin: 0;
  font-size: var(--text-h4);
  line-height: var(--leading-h4);
  color: var(--ink);
}

.aspect em {
  color: inherit;
}

/* Free invoke pips */
.aspect[data-invokes]::after {
  position: absolute;
  top: var(--space-sm);
  right: var(--space-md);
  font-size: var(--text-caption);
  letter-spacing: 0.2em;
  color: var(--gold);
}

.aspect[data-invokes="1"]::after { content: "\25C6"; }
.aspect[data-invokes="2"]::after { content: "\25C6\25C6"; }
.aspect[data-invokes="3"]::after { content: "\25C6\25C6\25C6"; }

/* Dragonmark: gold filigree corners and a faint Siberys glow */
.aspect--dragonmark {
  border-color: var(--gold);
  background:
    linear-gradient(var(--gold-bright), var(--gold-bright)) top left / 16px 2px no-repeat,
    linear-gradient(var(--gold-bright), var(--gold-bright)) top left / 2px 16px no-repeat,
    linear-gradient(var(--gold-bright), var(--gold-bright)) bottom right / 16px 2px no-repeat,
    linear-gradient(var(--gold-bright), var(--gold-bright)) bottom right / 2px 16px no-repeat,
    var(--surface-1);
  box-shadow: inset 0 0 18px -10px var(--gold-bright);
}

.aspect--dragonmark::before {
  color: var(--gold);
}

.aspect__sigil {
  float: right;
  width: 48px;
  height: 48px;
  margin: 0 0 var(--space-sm) var(--space-md);
  border: 0;
  box-shadow: none;
}

/* ================================
   STUNT
   ================================ */
.stunt {
  position: relative;
  margin: var(--space-md) 0;
  padding: var(--space-sm) var(--space-md);
  background: var(--surface-1);
  border-top: 2px solid var(--gold);
  font-size: var(--text-small);
  line-height: var(--leading-small);
}

.stunt::before {
  content: attr(data-source);
  display: block;
  font-family: var(--font-heading);
  font-size: var(--text-caption);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--ink-soft);
}

.stunt[data-cost]::after {
  content: attr(data-cost) " refresh";
  position: absolute;
  top: var(--space-sm);
  right: var(--space-md);
  padding: 0 var(--space-xs);
  border: 1px solid var(--gold);
  border-radius: var(--radius-sm);
  font-size: var(--text-caption);
  color: var(--gold);
}

.stunt p {
  margin: 0 0 var(--space-xs);
}

.stunt p:last-child {
  margin-bottom: 0;
}

.stunt strong {
  font-family: var(--font-heading);
  color: var(--gold);
}

.stunt--house {
  border-top-color: var(--gold-bright);
  background:
    linear-gradient(var(--gold-bright), var(--gold-bright)) top right / 16px 2px no-repeat,
    linear-gradient(var(--gold-bright), var(--gold-bright)) top right / 2px 16px no-repeat,
    var(--surface-1);
}

.stunt--house::before {
  content: "House exclusive";
  color: var(--gold);
}

/* ================================
   TRACK (stress, refresh, countdowns)
   ================================ */
.track {
  display: inline-flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--space-xs);
  vertical-align: middle;
}

.track__label {
  margin-right: var(--space-xs);
  font-family: var(--font-heading);
  font-size: var(--text-caption);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--ink-soft);
}

.track__box {
  display: inline-flex;
  width: 1.25rem;
  height: 1.25rem;
  cursor: pointer;
}

.track__box input {
  -webkit-appearance: none;
  appearance: none;
  width: 100%;
  height: 100%;
  margin: 0;
  border: 2px solid var(--ink-soft);
  border-radius: var(--radius-0);
  background: transparent;
  cursor: pointer;
}

.track__box input:checked {
  border-color: var(--gold);
  background: var(--gold);
  box-shadow: inset 0 0 0 3px var(--surface-1);
}

.track__box input:focus-visible {
  outline: 2px solid var(--blue-bright);
  outline-offset: 2px;
}

.track__dial {
  width: 2.5rem;
  height: 2.5rem;
  margin-right: var(--space-sm);
  border: 2px solid var(--ink-soft);
  border-radius: var(--radius-round);
  background: repeating-conic-gradient(var(--ink-soft) 0deg 2deg, transparent 2deg calc(360deg / var(--segments)));
}

/* ================================
   CONSEQUENCES
   ================================ */
.consequences {
  display: inline-flex;
  flex-wrap: wrap;
  gap: var(--space-sm) var(--space-md);
  vertical-align: middle;
}

.consequence {
  display: inline-flex;
  flex: 1 1 10rem;
  align-items: center;
  gap: var(--space-xs);
  min-width: 10rem;
}

.consequence__label {
  font-family: var(--font-heading);
  font-size: var(--text-caption);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--red-text);
}

.consequence__shift {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 1.4rem;
  height: 1.4rem;
  border: 2px solid var(--red-text);
  border-radius: var(--radius-round);
  font-size: var(--text-caption);
  font-weight: 700;
  color: var(--red-text);
}

.consequence__line {
  flex: 1;
  min-width: 4rem;
  height: 1.2em;
  border-bottom: 1px solid var(--ink-soft);
}

/* ================================
   SKILL PYRAMID
   ================================ */
.pyramid {
  display: grid;
  gap: var(--space-xs);
  margin: var(--space-lg) 0;
}

.pyramid__row {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--space-xs);
}

.pyramid__rung {
  flex: 0 0 7.5rem;
  font-family: var(--font-heading);
  font-size: var(--text-small);
  color: var(--gold);
}

.pyramid__slot {
  flex: 1 1 6rem;
  min-height: 2rem;
  padding: var(--space-xs) var(--space-sm);
  background: var(--surface-1);
  border-bottom: 1px solid var(--ink-soft);
  font-size: var(--text-small);
}
```

- [ ] **Step 5: Write the sample page**

Create `design-sample.md` at the repo root:

```markdown
---
title: Design System Sample
description: Every Fate of Eberron component in one place. Add ?theme=parchment to the URL to see the print theme.
search: false
handouts: true
---

This page renders every component in the design system. It is not linked from the site. The claude.ai design system cuts its component previews from the `ds-sample` sections below, so keep exactly one section per component and keep the `data-component` names matching the folders in `design/components/`.

## Aspect

<section class="ds-sample" data-component="Aspect" data-group="Character" data-height="220" markdown="1">
<div class="aspect" data-label="High Concept" data-invokes="1" markdown="1">
*Cyran Artificer Who Lost Everything*
</div>
<div class="aspect" data-label="Motivation" markdown="1">
*Somebody Has to Answer for the Mourning*
</div>
</section>

## Dragonmark

<section class="ds-sample" data-component="Dragonmark" data-group="Character" data-height="300" markdown="1">
<div class="aspect aspect--dragonmark" data-label="Mark of Finding · House Tharashk" markdown="1">
*The Mark Pulls Me Toward What Others Hide*
</div>
<div class="stunt stunt--house" markdown="1">
**Bloodhound's Certainty.** Once per scene, declare that you know the direction of a person or object you have touched. No roll needed.
</div>
</section>

## Stunt

<section class="ds-sample" data-component="Stunt" data-group="Character" data-height="220" markdown="1">
<div class="stunt" data-source="Archetype" markdown="1">
**Tinker's Eye.** +2 to Crafts when you create an advantage by spotting the weak point in a construct or device.
</div>
<div class="stunt" data-source="Species" data-cost="1" markdown="1">
**Integrated Tool.** Use Physique instead of Crafts when the job needs force more than finesse.
</div>
</section>

## Skill pyramid

<section class="ds-sample" data-component="Pyramid" data-group="Character" data-height="220" markdown="1">
{% include components/pyramid.html skills="Crafts,Lore,Investigate,Notice,Will,Rapport" %}
</section>

## Track

<section class="ds-sample" data-component="Track" data-group="Character" data-height="160" markdown="1">
{% include components/track.html label="Physical" boxes=3 %}

{% include components/track.html label="Mental" boxes=3 %}

{% include components/track.html label="Ritual" boxes=6 style="clock" %}
</section>

## Consequences

<section class="ds-sample" data-component="Consequences" data-group="Character" data-height="120" markdown="1">
{% include components/consequences.html %}
</section>
```

- [ ] **Step 6: Keep the sample out of search**

In `search.json`, replace:

```liquid
  {% assign pages = site.pages | where_exp: "p", "p.title and p.url != '/'" %}
```

with:

```liquid
  {% assign pages = site.pages | where_exp: "p", "p.title and p.url != '/' and p.search != false" %}
```

- [ ] **Step 7: Run tests**

Run: `bash tests/design.sh`
Expected: all PASS, including `includes_test` and `site_test`.

- [ ] **Step 8: Visual check**

With `bundle exec jekyll serve` running, open `http://localhost:4000/Fate-of-Eberron/design-sample` and the same with `?theme=parchment`, at desktop and 375px widths. Check: aspect labels readable, invoke pip at top right, dragonmark corners visible, stunt refresh tag does not overlap the source label, stress boxes clickable and fill gold, clock dial shows 6 segments, consequence circles show 2, 4, 6, pyramid rows wrap without horizontal scroll. Print preview shows boxes as empty squares.

- [ ] **Step 9: Commit and push**

```bash
git add assets/css/components.css _includes/components design-sample.md search.json tests/design tests/design.sh
git commit -m "Add character components and design sample page

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```

---

### Task 4: Stat block, tier badge and rules reference

**Files:**
- Modify: `assets/css/components.css` (append)
- Create: `_includes/components/tier.html`, `_includes/components/ladder.html`
- Modify: `design-sample.md` (append), `tests/design/fixtures/index.md` (append), `tests/design/includes_test.rb`, `tests/design/site_test.rb`

**Interfaces:**
- Consumes: `.track`, `.consequences` from Task 3.
- Produces classes: `.statblock`, `.statblock--example`, `.tier`, `.tier--<tier>`, `.tier__role`, `.tier__badge`, `.tier__note`, `.ladder`, `.ladder__step`, `.ladder__step--highlight`, `.ladder__value`, `.ladder__name`, `.outcomes`, `.die`, `.die--plus`, `.die--minus`, `.die--blank`.
- Produces includes: `components/tier.html` (`role`, `tier`, optional `note`), `components/ladder.html` (optional `highlight`, accepts `"4"` or `"+4"`). Task 5's migration emits exactly `{% include components/tier.html role="X" tier="Y" note="Z" %}`.

- [ ] **Step 1: Write failing tests**

Append to `tests/design/fixtures/index.md`:

```markdown

<section id="tier-note">{% include components/tier.html role="Muscle" tier="Filler" note="4 members" %}</section>

<section id="tier-unknown">{% include components/tier.html tier="Minion" %}</section>

<section id="ladder-plus">{% include components/ladder.html highlight="+4" %}</section>

<section id="ladder-none">{% include components/ladder.html %}</section>
```

Append to `IncludesTest`:

```ruby
  def test_tier_badge_with_role_and_note
    html = fragment("tier-note")
    assert_includes html, "tier--filler"
    assert_includes html, '<span class="tier__role">Muscle</span>'
    assert_includes html, '<span class="tier__badge">Filler</span>'
    assert_includes html, '<span class="tier__note">4 members</span>'
  end

  def test_unknown_tier_still_renders_badge
    html = fragment("tier-unknown")
    assert_includes html, "tier--minion"
    assert_includes html, '<span class="tier__badge">Minion</span>'
    refute_includes html, "tier__role"
  end

  def test_ladder_has_eleven_steps_and_accepts_plus_sign
    assert_equal 11, count("ladder-plus", '<li class="ladder__step')
    assert_equal 1, count("ladder-plus", "ladder__step--highlight")
    highlighted = fragment("ladder-plus")[%r{ladder__step--highlight">(.*?)</li>}m, 1]
    assert_includes highlighted, "Great"
    assert_includes fragment("ladder-plus"), '<span class="ladder__value">-2</span>'
    assert_includes fragment("ladder-plus"), '<span class="ladder__value">+8</span>'
  end

  def test_ladder_without_highlight
    refute_includes fragment("ladder-none"), "ladder__step--highlight"
  end
```

Append to `SiteTest`:

```ruby
  def test_sample_page_has_reference_sections
    html = read("design-sample.html")
    %w[Statblock Tier Ladder Outcomes Die Actions].each do |name|
      assert_includes html, %(data-component="#{name}"), "missing sample section #{name}"
    end
  end
```

- [ ] **Step 2: Run to verify failure**

Run: `bash tests/design.sh`
Expected: `[FAIL] fixture build` (missing `components/tier.html`) and `[FAIL] site_test`

- [ ] **Step 3: Write the includes**

Create `_includes/components/tier.html`:

```liquid
{%- comment -%}
  Stat block header line: role (optional), tier (Threat, Filler, Hitter, Boss, Obstacle), note (optional).
  Tiers are told apart by label and glyph, never by color alone.
{%- endcomment -%}
{%- assign tier = include.tier | strip -%}
{%- assign key = tier | downcase -%}
<span class="tier tier--{{ key }}">{% if include.role %}<span class="tier__role">{{ include.role }}</span>{% endif %}<span class="tier__badge">{{ tier }}</span>{% if include.note %}<span class="tier__note">{{ include.note }}</span>{% endif %}</span>
```

Create `_includes/components/ladder.html`:

```liquid
{%- comment -%}
  The Fate ladder, Legendary (+8) to Terrible (-2). highlight="4" or "+4" marks one step.
{%- endcomment -%}
{%- assign steps = "8:Legendary,7:Epic,6:Fantastic,5:Superb,4:Great,3:Good,2:Fair,1:Average,0:Mediocre,-1:Poor,-2:Terrible" | split: "," -%}
{%- assign highlight = include.highlight | append: "" | remove: "+" | strip -%}
<ol class="ladder">{% for step in steps %}{% assign parts = step | split: ":" %}{% assign value = parts[0] %}<li class="ladder__step{% if value == highlight %} ladder__step--highlight{% endif %}"><span class="ladder__value">{% if value contains "-" %}{{ value }}{% else %}+{{ value }}{% endif %}</span><span class="ladder__name">{{ parts[1] }}</span></li>{% endfor %}</ol>
```

- [ ] **Step 4: Append the styles**

Append to `assets/css/components.css`:

```css

/* ================================
   STAT BLOCK
   ================================ */
.statblock {
  position: relative;
  margin: var(--space-xl) 0;
  padding: var(--space-lg);
  background: var(--surface-1);
  border: 1px solid var(--rule);
  border-top: 3px solid var(--gold);
}

.statblock > h3:first-child,
.statblock > h4:first-child {
  margin-top: 0;
  font-size: var(--text-h3);
  color: var(--gold);
}

/* Compact stat lines are written one per source line */
.statblock p {
  white-space: pre-line;
}

.statblock p:last-child,
.statblock ul:last-child {
  margin-bottom: 0;
}

.statblock strong {
  color: var(--gold);
}

.statblock .track,
.statblock .consequences {
  display: flex;
  margin: var(--space-xs) 0;
}

.statblock--example {
  border-top-width: 1px;
  border-left: 3px solid var(--gold);
}

/* ================================
   TIER BADGE
   ================================ */
.tier {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: var(--space-sm);
  margin: 0 0 var(--space-md);
  font-size: var(--text-small);
}

.tier__role {
  font-style: italic;
  color: var(--ink-soft);
}

.tier__badge {
  display: inline-flex;
  align-items: center;
  gap: var(--space-xs);
  padding: 0 var(--space-sm);
  border: 1px solid var(--gold);
  font-family: var(--font-heading);
  font-size: var(--text-caption);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  color: var(--gold);
}

.tier__badge::before { content: "\25CF"; }
.tier--threat .tier__badge::before { content: "\25B2"; }
.tier--filler .tier__badge::before { content: "\25A0"; }
.tier--hitter .tier__badge::before { content: "\25C6"; }
.tier--boss .tier__badge::before { content: "\2605"; }
.tier--obstacle .tier__badge::before { content: "\25AC"; }

.tier--boss .tier__badge {
  background: var(--gold);
  color: var(--surface-0);
}

.tier__note {
  font-size: var(--text-caption);
  color: var(--ink-muted);
}

/* ================================
   LADDER
   ================================ */
.ladder {
  max-width: 22rem;
  margin: var(--space-lg) 0;
  padding: 0;
  list-style: none;
  background: var(--surface-1);
  border: 1px solid var(--rule);
}

.ladder__step {
  display: flex;
  justify-content: space-between;
  gap: var(--space-md);
  margin: 0;
  padding: var(--space-xs) var(--space-md);
  border-bottom: 1px solid var(--rule);
  font-size: var(--text-small);
}

.ladder__step:last-child {
  border-bottom: 0;
}

.ladder__value {
  min-width: 2.5rem;
  font-family: var(--font-mono);
  color: var(--gold);
}

.ladder__name {
  font-family: var(--font-heading);
  color: var(--ink);
}

.ladder__step--highlight {
  background: var(--surface-2);
  box-shadow: inset 3px 0 0 var(--gold);
}

.ladder__step--highlight .ladder__name {
  color: var(--gold-bright);
}

/* ================================
   OUTCOMES
   ================================ */
.outcomes ul {
  display: grid;
  gap: var(--space-sm);
  margin: var(--space-lg) 0;
  padding: 0;
  list-style: none;
}

@media (min-width: 600px) {
  .outcomes ul {
    grid-template-columns: repeat(4, 1fr);
  }
}

.outcomes li {
  margin: 0;
  padding: var(--space-md);
  background: var(--surface-1);
  border-top: 3px solid var(--rule);
  font-size: var(--text-small);
}

.outcomes li:nth-child(1) { border-top-color: var(--red); }
.outcomes li:nth-child(2) { border-top-color: var(--ink-soft); }
.outcomes li:nth-child(3) { border-top-color: var(--gold); }
.outcomes li:nth-child(4) { border-top-color: var(--gold-bright); }

.outcomes strong {
  display: block;
  font-family: var(--font-heading);
  color: var(--gold);
}

/* ================================
   FATE DIE GLYPHS
   ================================ */
.die {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 1.4em;
  height: 1.4em;
  border: 1px solid var(--ink-soft);
  border-radius: var(--radius-sm);
  vertical-align: -0.2em;
  font-family: var(--font-mono);
  font-weight: 700;
  color: var(--ink);
}

.die--plus::before { content: "+"; color: var(--gold); }
.die--minus::before { content: "\2212"; color: var(--red-text); }
.die--blank::before { content: "\00a0"; }
```

- [ ] **Step 5: Append the sample sections**

Append to `design-sample.md`:

```markdown

## Stat block

<section class="ds-sample" data-component="Statblock" data-group="Adversaries" data-height="460" markdown="1">
<div class="statblock" markdown="1">

### Hallia Boromar (she/her)

{% include components/tier.html role="Rival" tier="Hitter" %}

Saidan's niece and likely successor. She smiles too easily and means it too rarely.

**Aspects:**
- *Boromar Heir with Modern Ambitions*
- *Underestimated by Everyone Who Should Know Better*

**Skills:**
- Deceive Great (+4)
- Rapport Good (+3), Contacts Good (+3)

**Stunt:** **Better Offer**: +2 to Rapport when proposing a deal that undercuts a rival's arrangement.

{% include components/track.html label="Stress" boxes=3 %}
{% include components/consequences.html slots="mild,moderate" %}

</div>
</section>

## Tier badges

<section class="ds-sample" data-component="Tier" data-group="Adversaries" data-height="180" markdown="1">
{% include components/tier.html role="Lookout" tier="Threat" %}
{% include components/tier.html role="Muscle" tier="Filler" note="4 members" %}
{% include components/tier.html role="Enforcer" tier="Hitter" %}
{% include components/tier.html role="Leader" tier="Boss" %}
{% include components/tier.html role="Ward" tier="Obstacle" %}
</section>

## Ladder

<section class="ds-sample" data-component="Ladder" data-group="Rules" data-height="420" markdown="1">
{% include components/ladder.html highlight="4" %}
</section>

## Outcomes

<section class="ds-sample" data-component="Outcomes" data-group="Rules" data-height="200" markdown="1">
<div class="outcomes" markdown="1">
- **Fail** You don't get what you want, or you get it at a serious cost.
- **Tie** You get it at a minor cost, or a lesser version.
- **Succeed** You get what you want.
- **Succeed with Style** You get it plus a boost.
</div>
</section>

## Fate dice

<section class="ds-sample" data-component="Die" data-group="Rules" data-height="100" markdown="1">
A roll of <span class="die die--plus" role="img" aria-label="plus"></span> <span class="die die--plus" role="img" aria-label="plus"></span> <span class="die die--blank" role="img" aria-label="blank"></span> <span class="die die--minus" role="img" aria-label="minus"></span> is +1.
</section>

## Actions

<section class="ds-sample" data-component="Actions" data-group="Rules" data-height="420" markdown="1">
<div class="action-grid">
<div class="action"><img src="{{ '/images/icons/overcome.svg' | relative_url }}" alt="Overcome" class="action-icon"><p><strong>Overcome</strong> Get past an obstacle.</p></div>
<div class="action"><img src="{{ '/images/icons/create-advantage.svg' | relative_url }}" alt="Create an Advantage" class="action-icon"><p><strong>Create an Advantage</strong> Make or discover an aspect.</p></div>
<div class="action"><img src="{{ '/images/icons/attack.svg' | relative_url }}" alt="Attack" class="action-icon"><p><strong>Attack</strong> Harm someone.</p></div>
<div class="action"><img src="{{ '/images/icons/defend.svg' | relative_url }}" alt="Defend" class="action-icon"><p><strong>Defend</strong> Stop harm or an advantage.</p></div>
</div>
</section>
```

- [ ] **Step 6: Run tests**

Run: `bash tests/design.sh`
Expected: all PASS.

- [ ] **Step 7: Visual check**

Open `/design-sample` in noir and `?theme=parchment` at desktop and 375px. Check: stat block heading gold, tier line under it, stress and consequences on their own lines, boss badge filled gold with dark text, ladder Great row highlighted, outcomes four across on desktop and stacked on mobile, die faces aligned with text, action icons inverted on noir and drawn dark on parchment.

- [ ] **Step 8: Commit and push**

```bash
git add assets/css/components.css _includes/components design-sample.md tests/design
git commit -m "Add stat block, tier badge, ladder, outcomes and die components

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```

---

### Task 5: Migrate stat blocks in npcs.md and gm-guide.md

**Files:**
- Create then delete: `script/migrate_statblocks.rb`, `tests/design/unit/migrate_statblocks_test.rb`
- Modify: `npcs.md`, `gm-guide.md`
- Modify: `tests/design/site_test.rb`

**Interfaces:**
- Consumes: includes `components/track.html`, `components/consequences.html`, `components/tier.html`; classes `.statblock`, `.statblock--example`.
- Produces: no new interfaces. After this task `npcs.md` has no `[ ]` and `gm-guide.md` has `[ ]` only in the two Quick Reference table rows.

- [ ] **Step 1: Write the failing migration tests**

Create `tests/design/unit/migrate_statblocks_test.rb`:

```ruby
# frozen_string_literal: true

require "minitest/autorun"
require_relative "../../../script/migrate_statblocks"

class MigrateStatblocksTest < Minitest::Test
  M = MigrateStatblocks

  def test_bold_stress_line
    assert_equal '{% include components/track.html label="Stress" boxes=4 %}',
                 M.convert_line("**Stress:** [ ] [ ] [ ] [ ]")
  end

  def test_prefixes_are_kept
    assert_equal '> {% include components/track.html label="Stress" boxes=3 %}', M.convert_line("> Stress: [ ] [ ] [ ]")
    assert_equal '- {% include components/consequences.html slots="mild,moderate" %}',
                 M.convert_line("- Consequences: Mild [ ] | Moderate [ ]")
  end

  def test_consequence_variants
    assert_equal '{% include components/consequences.html slots="mild,moderate,severe" %}',
                 M.convert_line("**Consequences:** Mild [ ] | Moderate [ ] | Severe [ ]")
    assert_equal '{% include components/consequences.html slots="moderate" %}', M.convert_line("Consequence: Moderate [ ]")
  end

  def test_bare_boxes_become_a_countdown_clock
    assert_equal '{% include components/track.html label="Countdown" boxes=3 style="clock" %}', M.convert_line("[ ] [ ] [ ]")
    assert_equal '> {% include components/track.html label="Countdown" boxes=5 style="clock" %}',
                 M.convert_line("> [ ] [ ] [ ] [ ] [ ]")
  end

  def test_table_rows_and_prose_are_untouched
    ["| Physical | [ ]1 [ ]2 [ ]3 |", "**Stress**: Absorb shifts equal to box value.", "- Stress track (two or three boxes)"].each do |line|
      assert_equal line, M.convert_line(line)
    end
  end

  def test_role_line_becomes_tier_include
    assert_equal '{% include components/tier.html role="Leader" tier="Boss" %}', M.convert_line("**Role:** Leader | **Tier:** Boss")
    assert_equal '{% include components/tier.html role="Muscle" tier="Filler" note="4 members" %}',
                 M.convert_line("**Role:** Muscle | **Tier:** Filler (4 members)")
  end

  NPC = <<~MD
    ## Boromar Clan

    ### Hallia Boromar (she/her)

    **Role:** Rival | **Tier:** Hitter

    Prose.

    **Stress:** [ ] [ ] [ ]
    **Consequences:** Mild [ ] | Moderate [ ]

    ---

    ### Not An Adversary

    Just prose.
  MD

  def test_npc_sections_are_wrapped_up_to_the_rule
    out = M.migrate(NPC, 3)
    expected = <<~MD
      ## Boromar Clan

      <div class="statblock" markdown="1">

      ### Hallia Boromar (she/her)

      {% include components/tier.html role="Rival" tier="Hitter" %}

      Prose.

      {% include components/track.html label="Stress" boxes=3 %}
      {% include components/consequences.html slots="mild,moderate" %}

      </div>

      ---

      ### Not An Adversary

      Just prose.
    MD
    assert_equal expected, out
  end

  GUIDE = <<~MD
    #### Hitters

    Hitters deal damage.

    > **Example: House Deneith Blademark**
    > *Professional Mercenary*
    > Stress: [ ] [ ] [ ]

    #### Daask Enforcer
    *Monster in the City*
    Stress: [ ] [ ] [ ]
    Consequence: Moderate [ ]

    ### Obstacles
  MD

  def test_examples_are_unquoted_and_explanations_are_not_wrapped
    out = M.migrate(GUIDE, 4)
    expected = <<~MD
      #### Hitters

      Hitters deal damage.

      <div class="statblock statblock--example" markdown="1">

      **Example: House Deneith Blademark**
      *Professional Mercenary*
      {% include components/track.html label="Stress" boxes=3 %}

      </div>

      <div class="statblock" markdown="1">

      #### Daask Enforcer
      *Monster in the City*
      {% include components/track.html label="Stress" boxes=3 %}
      {% include components/consequences.html slots="moderate" %}

      </div>

      ### Obstacles
    MD
    assert_equal expected, out
  end

  def test_migration_is_idempotent
    [[NPC, 3], [GUIDE, 4]].each do |text, level|
      once = M.migrate(text, level)
      assert_equal once, M.migrate(once, level)
    end
  end
end
```

- [ ] **Step 2: Run to verify failure**

Run: `ruby tests/design/unit/migrate_statblocks_test.rb`
Expected: LoadError for `script/migrate_statblocks`

- [ ] **Step 3: Write the migration script**

Create `script/migrate_statblocks.rb`:

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

# One-time migration: turns markdown stat lines in npcs.md and gm-guide.md into
# component includes and wraps adversary sections in .statblock divs.
# Usage: ruby script/migrate_statblocks.rb
module MigrateStatblocks
  BOXES = /\[ \](?:\s*\[ \])*/
  PREFIX = /(?<prefix>(?:> |- )?)/
  STRESS = /\A#{PREFIX}(?:\*\*Stress:\*\*|Stress:)\s*(?<boxes>#{BOXES})\s*\z/
  BARE = /\A#{PREFIX}(?<boxes>#{BOXES})\s*\z/
  SLOT = /(?:Mild|Moderate|Severe) \[ \]/
  CONSEQUENCES = /\A#{PREFIX}(?:\*\*Consequences?:\*\*|Consequences?:)\s*(?<slots>#{SLOT}(?:\s*\|\s*#{SLOT})*)\s*\z/
  ROLE = /\A\*\*Role:\*\* (?<role>.+?) \| \*\*Tier:\*\* (?<tier>\w+)(?: \((?<note>[^)]+)\))?\s*\z/
  INCLUDE = "{% include components/"
  OPEN = '<div class="statblock" markdown="1">'
  OPEN_EXAMPLE = '<div class="statblock statblock--example" markdown="1">'
  CLOSE = "</div>"

  module_function

  def count_boxes(boxes)
    boxes.scan("[ ]").size
  end

  def convert_line(line)
    if (m = STRESS.match(line))
      %(#{m[:prefix]}{% include components/track.html label="Stress" boxes=#{count_boxes(m[:boxes])} %})
    elsif (m = CONSEQUENCES.match(line))
      slots = m[:slots].scan(/Mild|Moderate|Severe/).map(&:downcase).join(",")
      %(#{m[:prefix]}{% include components/consequences.html slots="#{slots}" %})
    elsif (m = BARE.match(line))
      %(#{m[:prefix]}{% include components/track.html label="Countdown" boxes=#{count_boxes(m[:boxes])} style="clock" %})
    elsif (m = ROLE.match(line))
      note = m[:note] ? %( note="#{m[:note]}") : ""
      %({% include components/tier.html role="#{m[:role]}" tier="#{m[:tier]}"#{note} %})
    else
      line
    end
  end

  # A blockquote holding a component include becomes an example stat block.
  def unquote_examples(lines)
    out = []
    i = 0
    while i < lines.size
      unless lines[i].start_with?(">")
        out << lines[i]
        i += 1
        next
      end
      j = i
      j += 1 while j < lines.size && lines[j].start_with?(">")
      block = lines[i...j]
      if block.any? { |l| l.include?(INCLUDE) }
        out << OPEN_EXAMPLE << ""
        out.concat(block.map { |l| l.sub(/\A> ?/, "") })
        out << "" << CLOSE
      else
        out.concat(block)
      end
      i = j
    end
    out
  end

  # True when the section has an include that is not already inside an example div.
  def bare_include?(section)
    inside = false
    section.any? do |line|
      if line == OPEN_EXAMPLE
        inside = true
        false
      elsif line == CLOSE
        inside = false
        false
      else
        !inside && line.include?(INCLUDE)
      end
    end
  end

  def already_wrapped?(out)
    last = out.reverse.find { |l| !l.strip.empty? }
    last == OPEN
  end

  # Wraps each heading section at `level` that holds a bare component include.
  def wrap_sections(lines, level)
    heading = /\A#{'#' * level} /
    stop = /\A(?:-{3,}\s*\z|\#{1,#{level}} )/
    out = []
    i = 0
    while i < lines.size
      unless heading.match?(lines[i]) && !already_wrapped?(out)
        out << lines[i]
        i += 1
        next
      end
      j = i + 1
      j += 1 while j < lines.size && !stop.match?(lines[j])
      section = lines[i...j]
      if bare_include?(section)
        body_end = section.rindex { |l| !l.strip.empty? }
        out << OPEN << ""
        out.concat(section[0..body_end])
        out << "" << CLOSE
        out.concat(section[(body_end + 1)..])
      else
        out.concat(section)
      end
      i = j
    end
    out
  end

  def migrate(text, level)
    lines = text.split("\n", -1).map { |l| convert_line(l) }
    wrap_sections(unquote_examples(lines), level).join("\n")
  end
end

if $PROGRAM_NAME == __FILE__
  { "npcs.md" => 3, "gm-guide.md" => 4 }.each do |file, level|
    path = File.expand_path("../#{file}", __dir__)
    File.write(path, MigrateStatblocks.migrate(File.read(path), level))
  end
end
```

Note on `test_npc_sections_are_wrapped_up_to_the_rule`: the wrapped section ends before the blank line that precedes `---`; that blank line stays after `</div>`.

- [ ] **Step 4: Run to verify the unit tests pass**

Run: `ruby tests/design/unit/migrate_statblocks_test.rb`
Expected: `9 runs, ... 0 failures, 0 errors`

- [ ] **Step 5: Add the site assertions**

Append to `SiteTest`:

```ruby
  def test_npc_stat_blocks_are_components
    html = read("npcs.html")
    assert_equal 36, html.scan('class="statblock"').size
    refute_includes html, "[ ]"
    assert_equal 30, html.scan('<span class="track"').size
  end

  def test_gm_guide_stat_lines_are_components
    html = read("gm-guide.html")
    assert_equal 18, html.scan('class="statblock"').size, "Filler, Hitter, Boss and countdown templates"
    assert_equal 6, html.scan('class="statblock statblock--example"').size, "worked examples"
    assert_equal 2, html.scan("[ ]1").size, "Quick Reference table rows must stay"
    refute_match(/\[ \] \[ \]/, html)
  end
```

These counts come from a dry run of the script on the current files: 36 NPC sections, 30 NPC stress tracks, 18 GM guide templates (4 Fillers, 7 Hitters, 4 Bosses, 3 countdowns) and 6 worked examples. The two Threat templates have no boxes and stay unwrapped.

- [ ] **Step 6: Run the migration**

Run: `ruby script/migrate_statblocks.rb`

Then verify the diff touched only stat lines and wrappers:

```bash
git diff --stat npcs.md gm-guide.md
git diff -U0 npcs.md gm-guide.md | grep '^-[^-]' | grep -vE 'Stress|Consequence|\*\*Role:\*\*|^-> |^-\[ \]|^-$'
```

Expected: the second command prints nothing (every removed line was a stat line, a quoted example line, a bare box line or a blank line). Then:

```bash
grep -c '\[ \]' npcs.md gm-guide.md
```

Expected: `npcs.md:0`, `gm-guide.md:2`.

- [ ] **Step 7: Run tests**

Run: `bash tests/design.sh`
Expected: all PASS.

- [ ] **Step 8: Visual check**

Open `/npcs/` and `/gm-guide/` (sections Adversaries, Quick Antagonist Templates, Countdowns) in noir and parchment at desktop and 375px. Check every stat block has a gold top border, tier badges render, filler notes show, compact blocks keep one stat per line, countdown examples show dials, the Quick Reference table is unchanged, and the TOC still lists every h2.

- [ ] **Step 9: Commit the migration**

```bash
git add npcs.md gm-guide.md script/migrate_statblocks.rb tests/design/unit/migrate_statblocks_test.rb tests/design/site_test.rb
git commit -m "Convert NPC and GM guide stat blocks to components

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```

- [ ] **Step 10: Remove the one-time script**

```bash
git rm script/migrate_statblocks.rb tests/design/unit/migrate_statblocks_test.rb
bash tests/design.sh
git commit -m "Remove one-time stat block migration script

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```

Expected: `tests/design.sh` still all PASS (the site assertions keep guarding the result).

---

### Task 6: In-world handouts

**Files:**
- Create: `assets/css/handouts.css`
- Create: `_includes/components/seal.html`, `_includes/components/word-count.html`
- Modify: `_layouts/default.html` (conditional fonts and stylesheet)
- Modify: `design-sample.md` (append), `tests/design/fixtures/index.md` (append), `tests/design/includes_test.rb`, `tests/design/site_test.rb`

**Interfaces:**
- Consumes: paper, ink-print, wax tokens and font families from Task 1.
- Produces classes: `.handout`, `.handout--chronicle`, `.handout--letter`, `.handout--sending`, `.handout--wanted`, `.handout__masthead`, `.handout__dateline`, `.handout__columns`, `.handout__letterhead`, `.handout__footer`, `.handout__signature`, `.handout__stamp`, `.handout__wanted`, `.handout__name`, `.handout__portrait`, `.handout__reward`, `.handout__authority`, `.seal`, `.seal__house`, `.word-count`, `.word-count--over`, `.word-count__tick`, `.word-count__tick--used`, `.word-count__total`.
- Produces includes: `components/seal.html` (`house`), `components/word-count.html` (`words`, limit 25).
- Produces: front matter flag `handouts: true` loads handout fonts and `handouts.css`.

- [ ] **Step 1: Write failing tests**

Append to `tests/design/fixtures/index.md`:

```markdown

<section id="seal-house">{% include components/seal.html house="Sivis" %}</section>

<section id="seal-empty">{% include components/seal.html %}</section>

<section id="words-some">{% include components/word-count.html words=18 %}</section>

<section id="words-over">{% include components/word-count.html words=30 %}</section>
```

Append to `IncludesTest`:

```ruby
  def test_seal_names_the_house
    assert_includes fragment("seal-house"), '<span class="seal__house">Sivis</span>'
    assert_includes fragment("seal-house"), 'aria-label="Seal of House Sivis"'
    assert_includes fragment("seal-empty"), '<span class="seal__house">Unsealed</span>'
  end

  def test_word_count_fills_used_ticks
    assert_equal 25, count("words-some", '<span class="word-count__tick')
    assert_equal 18, count("words-some", "word-count__tick--used")
    refute_includes fragment("words-some"), "word-count--over"
  end

  def test_word_count_over_limit_is_flagged_and_capped
    assert_includes fragment("words-over"), "word-count--over"
    assert_equal 25, count("words-over", "word-count__tick--used")
    assert_includes fragment("words-over"), "30/25"
  end
```

Append to `SiteTest`:

```ruby
  def test_sample_page_has_handout_sections_and_fonts
    html = read("design-sample.html")
    %w[Chronicle Letter Sending Wanted].each do |name|
      assert_includes html, %(data-component="#{name}"), "missing sample section #{name}"
    end
    assert_includes html, "assets/css/handouts.css"
    assert_includes html, "UnifrakturMaguntia"
  end

  def test_handout_assets_load_only_where_flagged
    html = read("index.html")
    refute_includes html, "handouts.css"
    refute_includes html, "UnifrakturMaguntia"
  end
```

- [ ] **Step 2: Run to verify failure**

Run: `bash tests/design.sh`
Expected: `[FAIL] fixture build` (missing `components/seal.html`) and `[FAIL] site_test`

- [ ] **Step 3: Write the includes**

Create `_includes/components/seal.html`:

```liquid
{%- comment -%} Wax seal slot for letters and stamps. house: the house name shown on the seal. {%- endcomment -%}
{%- assign house = include.house | default: "Unsealed" -%}
<span class="seal" role="img" aria-label="Seal of House {{ house }}"><span class="seal__house">{{ house }}</span></span>
```

Create `_includes/components/word-count.html`:

```liquid
{%- comment -%}
  Sending word counter: 25 ticks, the spell's limit. words: how many the message uses.
  Over 25 fills every tick and flags the total.
{%- endcomment -%}
{%- assign words = include.words | default: 0 | plus: 0 -%}
{%- assign limit = 25 -%}
<span class="word-count{% if words > limit %} word-count--over{% endif %}" aria-label="{{ words }} of {{ limit }} words">{% for i in (1..limit) %}<span class="word-count__tick{% if i <= words %} word-count__tick--used{% endif %}"></span>{% endfor %}<span class="word-count__total">{{ words }}/{{ limit }}</span></span>
```

- [ ] **Step 4: Load handout assets conditionally**

In `_layouts/default.html`, after the existing Google Fonts `<link href="https://fonts.googleapis.com/css2?family=Cinzel...` line, add:

```liquid
  {% if page.handouts %}
  <link href="https://fonts.googleapis.com/css2?family=UnifrakturMaguntia&family=Old+Standard+TT:ital,wght@0,400;0,700;1,400&family=Cormorant+Garamond:ital,wght@0,400;0,600;1,400&family=Courier+Prime&family=Playfair+Display+SC:wght@700;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="{{ '/assets/css/handouts.css' | relative_url }}">
  {% endif %}
```

- [ ] **Step 5: Write the handout styles**

Create `assets/css/handouts.css`:

```css
/* In-world handouts. Always on paper tones, in either theme. Loaded only on pages with handouts: true. */

@page {
  size: letter;
  margin: 0.75in;
}

.handout {
  max-width: 7in;
  margin: var(--space-xl) auto;
  padding: var(--space-xl);
  color: var(--ink-print);
  box-shadow: 0 6px 24px var(--shadow);
  -webkit-print-color-adjust: exact;
  print-color-adjust: exact;
}

.handout p,
.handout li,
.handout strong {
  color: var(--ink-print);
}

.handout em {
  color: var(--ink-print-soft);
}

.handout h3,
.handout h4 {
  margin: var(--space-sm) 0;
  color: var(--ink-print);
}

.handout a {
  color: var(--ink-print);
  text-decoration: underline;
}

@media print {
  .handout {
    max-width: none;
    margin: 0;
    box-shadow: none;
    break-before: page;
  }
}

/* ================================
   KORRANBERG CHRONICLE
   ================================ */
.handout--chronicle {
  background: var(--paper-news);
  font-family: var(--font-news);
}

.handout--chronicle .handout__masthead {
  margin: 0;
  padding-bottom: var(--space-sm);
  border-bottom: 3px double var(--ink-print);
  font-family: var(--font-blackletter);
  font-size: var(--text-title);
  line-height: 1.1;
  text-align: center;
}

.handout--chronicle .handout__dateline {
  margin: 0 0 var(--space-md);
  padding: var(--space-xs) 0;
  border-bottom: 1px solid var(--ink-print);
  font-size: var(--text-caption);
  letter-spacing: 0.1em;
  text-align: center;
  text-transform: uppercase;
  color: var(--ink-print-soft);
}

.handout--chronicle h3 {
  font-family: var(--font-news);
  font-size: var(--text-h3);
  font-weight: 700;
  letter-spacing: 0;
  text-align: center;
}

.handout__columns {
  column-count: 3;
  column-gap: var(--space-lg);
  column-rule: 1px solid var(--ink-print-soft);
  font-size: var(--text-small);
  text-align: justify;
  hyphens: auto;
}

@media (max-width: 600px) {
  .handout__columns {
    column-count: 1;
  }
}

/* ================================
   HOUSE LETTERHEAD
   ================================ */
.handout--letter {
  background: var(--paper-letter);
  font-family: var(--font-letter);
  font-size: var(--text-h4);
}

.handout--letter .handout__letterhead {
  margin-bottom: var(--space-lg);
  padding-bottom: var(--space-sm);
  border-bottom: 1px solid var(--ink-print-soft);
  font-family: var(--font-heading);
  font-size: var(--text-h3);
  font-variant: small-caps;
  letter-spacing: 0.2em;
  text-align: center;
}

.handout__footer {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  gap: var(--space-lg);
  margin-top: var(--space-xl);
}

.handout__signature {
  font-style: italic;
}

.seal {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 5rem;
  height: 5rem;
  border-radius: var(--radius-round);
  background: var(--wax);
  box-shadow: inset 0 0 0 4px var(--wax), inset 0 0 0 6px var(--paper-letter);
  -webkit-print-color-adjust: exact;
  print-color-adjust: exact;
}

.seal__house {
  font-family: var(--font-heading);
  font-size: var(--text-caption);
  line-height: 1.1;
  letter-spacing: 0.1em;
  text-align: center;
  text-transform: uppercase;
  color: var(--paper-letter);
}

/* ================================
   SENDING MESSAGE SLIP
   ================================ */
.handout--sending {
  max-width: 4.5in;
  background: var(--paper-slip);
  border: 1px dashed var(--ink-print-soft);
  font-family: var(--font-typewriter);
  font-size: var(--text-small);
}

.handout--sending .handout__stamp {
  display: inline-block;
  padding: var(--space-xs) var(--space-sm);
  border: 2px solid var(--wax);
  font-family: var(--font-heading);
  font-size: var(--text-caption);
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--wax);
  transform: rotate(-2deg);
}

.word-count {
  display: flex;
  flex-wrap: wrap;
  align-items: center;
  gap: 3px;
  margin-top: var(--space-md);
}

.word-count__tick {
  width: 6px;
  height: 14px;
  border: 1px solid var(--ink-print-soft);
}

.word-count__tick--used {
  border-color: var(--ink-print);
  background: var(--ink-print);
}

.word-count__total {
  margin-left: var(--space-sm);
  font-size: var(--text-caption);
  color: var(--ink-print-soft);
}

.word-count--over .word-count__total {
  font-weight: 700;
  color: var(--wax);
}

/* ================================
   WANTED POSTER
   ================================ */
.handout--wanted {
  background: var(--paper-poster);
  border: 6px double var(--ink-print);
  font-family: var(--font-news);
  text-align: center;
}

.handout--wanted .handout__wanted {
  margin: 0;
  font-family: var(--font-poster);
  font-size: var(--text-display);
  font-weight: 900;
  line-height: 1;
  letter-spacing: 0.08em;
}

.handout--wanted .handout__name {
  margin: var(--space-sm) 0;
  font-family: var(--font-poster);
  font-size: var(--text-h2);
  font-weight: 700;
}

.handout__portrait {
  width: 60%;
  aspect-ratio: 4 / 5;
  margin: var(--space-md) auto;
  border: 2px solid var(--ink-print);
  background: var(--paper-news);
}

.handout--wanted .handout__reward {
  font-family: var(--font-poster);
  font-size: var(--text-h3);
  color: var(--wax);
}

.handout--wanted .handout__authority {
  font-size: var(--text-caption);
  letter-spacing: 0.15em;
  text-transform: uppercase;
  color: var(--ink-print-soft);
}
```

- [ ] **Step 6: Append the sample sections**

Append to `design-sample.md`:

```markdown

## Korranberg Chronicle

<section class="ds-sample" data-component="Chronicle" data-group="Handouts" data-height="520" markdown="1">
<div class="handout handout--chronicle" markdown="1">
<p class="handout__masthead">The Korranberg Chronicle</p>
<p class="handout__dateline">Sharn Edition · Zarantyr 14, 998 YK · Two Coppers</p>

### Lightning Rail Stalls Outside Starilaskur

<div class="handout__columns" markdown="1">
Passengers on the Orien line spent a cold night in the Brelish hills after the conductor stones failed without warning. House Orien declined to comment beyond a promise of refunds.

Witnesses describe a figure in a long coat walking the length of the train before the lights went out. The Sharn Watch has asked anyone with information to come forward.

The line reopened at dawn. Orien inspectors were seen removing a crate from the third car.
</div>
</div>
</section>

## House letterhead

<section class="ds-sample" data-component="Letter" data-group="Handouts" data-height="460" markdown="1">
<div class="handout handout--letter" markdown="1">
<p class="handout__letterhead">House Sivis · Office of the Speaker's Heir</p>

To the bearer,

Your inquiry regarding the Cyran manifests has been received. The documents you seek were sealed by order of the Speaker in 994 YK. I am prepared to discuss exceptions in person.

<div class="handout__footer" markdown="1">
<p class="handout__signature">Lady Sora Maenya d'Sivis</p>
{% include components/seal.html house="Sivis" %}
</div>
</div>
</section>

## Sending message slip

<section class="ds-sample" data-component="Sending" data-group="Handouts" data-height="300" markdown="1">
<div class="handout handout--sending" markdown="1">
<p class="handout__stamp">Sivis Message Station · Sharn</p>

CARGO NOT ON MANIFEST. DO NOT OPEN THIRD CAR. MEET AT DRAGONEYES BEFORE THE WATCH ARRIVES. TRUST NO ONE IN ORIEN COLORS. BURN THIS.

{% include components/word-count.html words=24 %}
</div>
</section>

## Wanted poster

<section class="ds-sample" data-component="Wanted" data-group="Handouts" data-height="620" markdown="1">
<div class="handout handout--wanted" markdown="1">
<p class="handout__wanted">Wanted</p>
<p class="handout__name">The Man in the Long Coat</p>
<div class="handout__portrait"></div>
<p class="handout__reward">Reward: 500 Galifars</p>
<p class="handout__authority">By order of the Sharn Watch</p>
</div>
</section>
```

- [ ] **Step 7: Run tests**

Run: `bash tests/design.sh`
Expected: all PASS; `handouts.css has no raw hex` PASS.

- [ ] **Step 8: Visual check**

Open `/design-sample` in noir and parchment at desktop and 375px. Check: all four handouts stay on paper tones on the noir page, masthead in blackletter, three columns on desktop and one on mobile, seal is a dark red circle with a light house name, the word counter shows 24 filled ticks, the wanted poster headline does not overflow at 375px. Print preview: each handout starts on a new page and keeps its paper tone.

- [ ] **Step 9: Commit and push**

```bash
git add assets/css/handouts.css _includes/components _layouts/default.html design-sample.md tests/design
git commit -m "Add in-world handouts: chronicle, letterhead, sending slip, wanted poster

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```

---

### Task 7: Brand book and component guidelines

**Files:**
- Create: `design/README.md`
- Create: `design/components/<Name>/README.md` for Aspect, Dragonmark, Stunt, Pyramid, Track, Consequences, Statblock, Tier, Ladder, Outcomes, Die, Actions, Chronicle, Letter, Sending, Wanted
- Modify: `tests/design/site_test.rb`

**Interfaces:**
- Consumes: every class and include name from Tasks 3, 4 and 6.
- Produces: one README per `data-component` name. Task 8's staging script fails if any sample section lacks one.

- [ ] **Step 1: Write the failing test**

Append to `SiteTest`:

```ruby
  ROOT = File.expand_path("../..", __dir__)

  def test_every_sample_section_has_a_readme
    names = read("design-sample.html").scan(/data-component="([A-Za-z]+)"/).flatten
    assert_equal 16, names.size
    names.each do |name|
      path = File.join(ROOT, "design/components", name, "README.md")
      assert File.exist?(path), "missing #{path}"
      refute_match(/[\u2013\u2014]/, File.read(path), "#{name} README contains a dash")
    end
    refute_match(/[\u2013\u2014]/, File.read(File.join(ROOT, "design/README.md")))
  end
```

- [ ] **Step 2: Run to verify failure**

Run: `bash tests/design.sh`
Expected: `[FAIL] site_test` with `missing .../design/components/Aspect/README.md`

- [ ] **Step 3: Write the brand book**

Create `design/README.md`:

````markdown
# Fate of Eberron Design System

Fate of Eberron is a fan adaptation of Fate Condensed for the Eberron setting: noir intrigue, magic as industry, and the long shadow of the Last War. This system covers the Jekyll site, printed table materials, and anything designed for the game on claude.ai.

## Voice

Plain, specific, a little hard boiled. Write "is", not "serves as". No em dashes or en dashes anywhere, including UI labels. No inflated words ("vibrant", "pivotal", "rich history"). Game terms keep their Fate capitalization: Overcome, Create an Advantage, Attack, Defend, Great (+4), Mild consequence. Examples use Eberron's own institutions (House Sivis, the Sharn Watch, the Korranberg Chronicle), never real ones.

## Themes

- **Noir** is the only screen theme: near black surfaces, warm off white ink, dragonshard gold accents, a cool blue second accent. It is the default and the first theme in `tokens.json`.
- **Parchment** is the print theme: cream paper, dark brown ink, gold darkened until it passes as text. It applies automatically when printing and on screen with `data-theme="parchment"` on `<html>` (the site sets this from `?theme=parchment`).
- **Handouts** ignore both and always render on their own paper tokens, because they stand in for physical objects.

## Color rules

- Surfaces stack `surface-0` (page), `surface-1` (cards, components), `surface-2` (insets, highlights).
- Text uses `ink`, `ink-soft` or `ink-muted`. In noir, `ink-muted` never sits on `surface-2`.
- `gold` is for headings, labels that matter, active states and dragonmark borders. `gold-bright` is for hover and `em`.
- `blue-bright` is for links, `h3`, code and focus rings. `blue` is a fill and border color.
- `red` fills and borders consequences and danger; `red-text` is the text version.
- `rule` is decorative only. Controls (stress boxes, write lines) use `ink-soft` borders so they pass 3:1.
- Meaning never rests on color alone: tiers carry a label and a glyph, outcomes carry a label.

## Type

Cinzel Decorative for the site title and hero only. Cinzel for headings and component labels (small caps feel: uppercase, 0.08em tracking, `--text-caption`). Open Sans for prose and rules text. Fira Code for numbers on the ladder. Sizes come from the nine `--text-*` steps; never set a raw rem size.

## Shape

Square corners by default (`radius-0`). Art deco detail comes from thin gold rules, corner brackets and diamonds, not rounded cards. `radius-round` is for dice, consequence circles, seals and countdown dials.

## Iconography

The four action icons and the fate die in the Icons group are multi-tone illustrations drawn dark on transparent. On noir they are inverted (`filter: invert(1) opacity(0.8)`); on parchment they are shown as drawn. Do not recolor them or trace simplified versions. There is no sigil art for the dragonmarks yet; leave `.aspect__sigil` empty rather than drawing a mark.

## Using the components

Every component is a CSS class (in `components.css`, or `handouts.css` for handouts). On the Jekyll site, prose components are written as markdown inside a wrapper, for example:

```html
<div class="aspect" data-label="High Concept" markdown="1">
*Cyran Artificer Who Lost Everything*
</div>
```

Repetitive markup comes from includes in `_includes/components/`: `track.html`, `consequences.html`, `pyramid.html`, `tier.html`, `ladder.html`, `seal.html`, `word-count.html`. Each component's guidelines say which applies. Outside Jekyll, copy the HTML from the component's preview.

## Source of truth

This system is published from the Fate of Eberron repository (`design/`, `assets/css/components.css`, `assets/css/handouts.css`). Edits made directly on claude.ai are overwritten by the next sync, so change the repository instead.
````

- [ ] **Step 4: Write the component guidelines**

Create each file below with exactly this content.

`design/components/Aspect/README.md`:

```markdown
# Aspect

A labelled box for one character aspect, with optional free invoke pips.

- Markup: `<div class="aspect" data-label="High Concept" markdown="1">` around the aspect text in italics.
- `data-label`: High Concept, Motivation, Background, Relationship or Free Aspect.
- `data-invokes`: 1, 2 or 3 shows that many gold diamonds at top right. Leave it off when there are none.
- The consumer provides the aspect text. Keep it a phrase, not a sentence.
```

`design/components/Dragonmark/README.md`:

```markdown
# Dragonmark

Variants of the aspect and stunt for a dragonmark and its house stunts, marked by gold filigree corners and a faint glow.

- Mark aspect: `<div class="aspect aspect--dragonmark" data-label="Mark of Finding · House Tharashk" markdown="1">`.
- House stunt: `<div class="stunt stunt--house" markdown="1">`; the tag reads "House exclusive" automatically.
- Optional sigil: `<img class="aspect__sigil" src="..." alt="">` as the first child. There is no sigil art yet; do not draw one.
- No per house colors. Every house uses gold.
```

`design/components/Stunt/README.md`:

```markdown
# Stunt

A stunt card: a source tag, a bold name and the rules text.

- Markup: `<div class="stunt" data-source="Archetype" markdown="1">` then `**Name.** Rules text.`
- `data-source`: Archetype, Background, Charter or Species.
- `data-cost="1"` shows a "1 refresh" tag at top right (species stunts and extra stunts).
- The consumer provides the rules text. Keep one trigger and one effect.
```

`design/components/Pyramid/README.md`:

```markdown
# Pyramid

The skill pyramid: one Great (+4), two Good (+3), three Fair (+2), four Average (+1).

- Jekyll: `{% include components/pyramid.html skills="Crafts,Lore,Investigate" %}`. Skills fill top to bottom; empty slots render as write lines for print; skills past ten are dropped.
- Outside Jekyll: copy the preview markup and fill the `pyramid__slot` spans.
```

`design/components/Track/README.md`:

```markdown
# Track

A row of boxes for stress, refresh or a countdown.

- Jekyll: `{% include components/track.html label="Physical" boxes=3 %}`. `boxes` is clamped to 1 through 12. Default label is Stress.
- Countdown: add `style="clock"` for a segmented dial beside the boxes.
- Boxes are real checkboxes on screen with no saved state, and empty squares on paper. They carry no numbers: in Fate Condensed each box absorbs one shift.
```

`design/components/Consequences/README.md`:

```markdown
# Consequences

Consequence slots, each with its shift value and a line to write the consequence on.

- Jekyll: `{% include components/consequences.html slots="mild,moderate" %}`. Default is all three. Values: mild 2, moderate 4, severe 6.
- Slot names ignore case and spaces. An unknown slot name renders without a value.
- Labels and circles use `red-text`.
```

`design/components/Statblock/README.md`:

```markdown
# Statblock

An adversary or NPC stat block: name heading, tier line, aspects, skills, stunts, tracks, consequences, then notes.

- Markup: `<div class="statblock" markdown="1">` around a `###` (or `####`) heading and markdown content. Leave a blank line after the opening tag and before `</div>`.
- First line under the heading: the tier include.
- Lines inside a paragraph keep their line breaks, so compact blocks can list one stat per line.
- `statblock--example` is the lighter variant for worked examples inside rules text.
```

`design/components/Tier/README.md`:

```markdown
# Tier

The role and Adversary Toolkit tier of an opponent, shown as a badge with a glyph.

- Jekyll: `{% include components/tier.html role="Enforcer" tier="Hitter" note="4 members" %}`. `role` and `note` are optional.
- Tiers: Threat (triangle), Filler (square), Hitter (diamond), Boss (star, filled badge), Obstacle (bar). Any other tier gets a dot.
```

`design/components/Ladder/README.md`:

```markdown
# Ladder

The Fate ladder from Legendary (+8) to Terrible (-2).

- Jekyll: `{% include components/ladder.html highlight="4" %}`. `highlight` accepts `4` or `+4`; leave it off for no highlight.
- Use it on reference pages and GM screens, not inside stat blocks.
```

`design/components/Outcomes/README.md`:

```markdown
# Outcomes

The four outcomes of a roll as a strip: fail, tie, succeed, succeed with style.

- Markup: `<div class="outcomes" markdown="1">` around a four item list, each item starting with the bolded outcome name.
- Four columns from 600px, stacked below. The colored top borders are decoration; the names carry the meaning.
```

`design/components/Die/README.md`:

```markdown
# Die

Inline fate die faces for rules text and roll examples.

- Markup: `<span class="die die--plus" role="img" aria-label="plus"></span>`, with `die--minus` and `die--blank`.
- Always include the `aria-label`; the face is drawn by CSS.
```

`design/components/Actions/README.md`:

```markdown
# Actions

The four actions grid with their illustrated icons.

- Markup: `<div class="action-grid">` holding four `<div class="action">`, each with `<img class="action-icon">` and a paragraph that starts with the bolded action name.
- Icons come from the Icons group. They are inverted on noir and shown as drawn on parchment; do not recolor them.
```

`design/components/Chronicle/README.md`:

```markdown
# Chronicle

A Korranberg Chronicle broadsheet clipping.

- Markup: `<div class="handout handout--chronicle" markdown="1">` with `<p class="handout__masthead">`, `<p class="handout__dateline">`, a `###` headline, and the story inside `<div class="handout__columns" markdown="1">`.
- Use `###` for headlines, never `##` (the site table of contents lists `##`).
- Dates use the Galifar calendar (Zarantyr 14, 998 YK).
```

`design/components/Letter/README.md`:

```markdown
# Letter

A letter on house letterhead with a wax seal.

- Markup: `<div class="handout handout--letter" markdown="1">` with `<p class="handout__letterhead">`, the body as markdown, then `<div class="handout__footer" markdown="1">` holding `<p class="handout__signature">` and the seal.
- Seal: `{% include components/seal.html house="Sivis" %}`.
```

`design/components/Sending/README.md`:

```markdown
# Sending

A Sivis message slip for a Sending spell, with the 25 word limit shown as ticks.

- Markup: `<div class="handout handout--sending" markdown="1">` with `<p class="handout__stamp">`, the message in capitals, then the counter.
- Counter: `{% include components/word-count.html words=24 %}`. Over 25 fills every tick and turns the total red.
```

`design/components/Wanted/README.md`:

```markdown
# Wanted

A wanted poster from a city authority.

- Markup: `<div class="handout handout--wanted" markdown="1">` with `<p class="handout__wanted">`, `<p class="handout__name">`, `<div class="handout__portrait"></div>` (put an `<img>` inside when there is art), `<p class="handout__reward">` and `<p class="handout__authority">`.
- Authorities are Eberron's: the Sharn Watch, the King's Citadel, a house enclave.
```

- [ ] **Step 5: Run tests**

Run: `bash tests/design.sh`
Expected: all PASS.

- [ ] **Step 6: Commit and push**

```bash
git add design/README.md design/components tests/design/site_test.rb
git commit -m "Add design system brand book and component guidelines

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```

---

### Task 8: Staging script and the design-sync skill

**Files:**
- Create: `script/stage_design_system.rb`
- Create: `tests/design/unit/stage_design_system_test.rb`
- Create: `.claude/skills/design-sync/SKILL.md`

**Interfaces:**
- Consumes: `design-sample.html` sections from Tasks 3, 4, 6 (`<section class="ds-sample" data-component=... data-group=... data-height=...>`), READMEs from Task 7.
- Produces: `StageDesignSystem.previews(html) -> Array<Hash{name:, group:, height:, body:}>`, `StageDesignSystem.preview_html(preview, base_url) -> String`, `StageDesignSystem.stage(site_dir, out_dir, root:, base_url:) -> Array<String>` (component names). CLI: `ruby script/stage_design_system.rb SITE_DIR OUT_DIR`.

- [ ] **Step 1: Write the failing tests**

Create `tests/design/unit/stage_design_system_test.rb`:

```ruby
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
  end

  def test_relative_site_urls_become_absolute
    html = S.preview_html({ name: "Actions", group: "Rules", height: 400, body: '<img src="/Fate-of-Eberron/images/icons/attack.svg">' },
                          "https://ryansinger.github.io")
    assert_includes html, 'src="https://ryansinger.github.io/Fate-of-Eberron/images/icons/attack.svg"'
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
```

- [ ] **Step 2: Run to verify failure**

Run: `ruby tests/design/unit/stage_design_system_test.rb`
Expected: LoadError for `script/stage_design_system`

- [ ] **Step 3: Write the staging script**

Create `script/stage_design_system.rb`:

```ruby
#!/usr/bin/env ruby
# frozen_string_literal: true

# Stages the claude.ai Design System project/ folder from the repository and a built site.
# Usage: ruby script/stage_design_system.rb SITE_DIR OUT_DIR
require "fileutils"

module StageDesignSystem
  ROOT = File.expand_path("..", __dir__)
  BASE_URL = "https://ryansinger.github.io"
  DEFAULT_HEIGHT = 240
  SECTION = %r{<section class="ds-sample"([^>]*)>(.*?)</section>}m
  FONTS = "https://fonts.googleapis.com/css2?family=Cinzel:wght@400;600;700&family=Cinzel+Decorative:wght@400;700" \
          "&family=Open+Sans:wght@400;600;700&family=Fira+Code&family=UnifrakturMaguntia" \
          "&family=Old+Standard+TT:ital,wght@0,400;0,700;1,400&family=Cormorant+Garamond:ital,wght@0,400;0,600;1,400" \
          "&family=Courier+Prime&family=Playfair+Display+SC:wght@700;900&display=swap"

  module_function

  def attribute(attrs, name)
    attrs[/\b#{name}="([^"]*)"/, 1]
  end

  def previews(sample_html)
    sample_html.scan(SECTION).map do |attrs, body|
      {
        name: attribute(attrs, "data-component"),
        group: attribute(attrs, "data-group") || "Components",
        height: (attribute(attrs, "data-height") || DEFAULT_HEIGHT).to_i,
        body: body.strip
      }
    end
  end

  def preview_html(preview, base_url)
    body = preview[:body].gsub(/(src|href)="\//, "\\1=\"#{base_url}/")
    <<~HTML
      <!-- @dsCard group="#{preview[:group]}" height=#{preview[:height]} -->
      <!doctype html>
      <html lang="en">
      <head>
      <meta charset="utf-8">
      <link rel="stylesheet" href="#{FONTS}">
      </head>
      <body>
      #{body}
      </body>
      </html>
    HTML
  end

  def stage(site_dir, out_dir, root: ROOT, base_url: BASE_URL)
    list = previews(File.read(File.join(site_dir, "design-sample.html")))
    raise "no ds-sample sections found in design-sample.html" if list.empty?

    missing = list.map { |p| p[:name] }.reject { |n| File.exist?(File.join(root, "design/components", n, "README.md")) }
    raise "components without design/components/<Name>/README.md: #{missing.join(', ')}" unless missing.empty?

    project = File.join(out_dir, "project")
    FileUtils.mkdir_p(File.join(project, "components"))
    FileUtils.cp(File.join(root, "design/tokens.json"), project)
    FileUtils.cp(File.join(root, "design/README.md"), project)
    list.each do |preview|
      dir = File.join(project, "components", preview[:name])
      FileUtils.mkdir_p(dir)
      FileUtils.cp(File.join(root, "design/components", preview[:name], "README.md"), dir)
      File.write(File.join(dir, "preview.html"), preview_html(preview, base_url))
    end
    css = %w[components handouts].map { |f| File.read(File.join(root, "assets/css/#{f}.css")) }
    File.write(File.join(project, "components/bundle.css"), css.join("\n\n"))
    list.map { |p| p[:name] }
  end
end

if $PROGRAM_NAME == __FILE__
  site_dir, out_dir = ARGV
  abort "usage: ruby script/stage_design_system.rb SITE_DIR OUT_DIR" unless site_dir && out_dir
  names = StageDesignSystem.stage(site_dir, out_dir)
  puts "Staged #{names.size} components into #{File.join(out_dir, 'project')}: #{names.join(', ')}"
end
```

- [ ] **Step 4: Run to verify the tests pass**

Run: `ruby tests/design/unit/stage_design_system_test.rb`
Expected: `6 runs, ... 0 failures, 0 errors`

- [ ] **Step 5: Run the script against the real site**

```bash
STAGE="$(mktemp -d)"
bundle exec jekyll build --quiet -d "$STAGE/site"
ruby script/stage_design_system.rb "$STAGE/site" "$STAGE/out"
find "$STAGE/out/project" -type f | sort
```

Expected: `Staged 16 components`, and the file list shows `tokens.json`, `README.md`, `components/bundle.css`, and a `README.md` plus `preview.html` for each of the 16 components.

- [ ] **Step 6: Write the skill**

Create `.claude/skills/design-sync/SKILL.md`:

````markdown
---
name: design-sync
description: Use when design/tokens.json, design/README.md, design/components/, assets/css/components.css, assets/css/handouts.css or design-sample.md changed and the claude.ai Fate of Eberron design system needs republishing, or when the user asks to sync or publish the design system.
---

# Design Sync

Publishes the repository's design system to the claude.ai Design System artifact. The repository is the source of truth: anything edited directly on claude.ai is overwritten by this sync. Say that to the user before publishing.

The artifact URL is recorded in CLAUDE.md under "Design System".

## Steps

1. **Test first.** Run `bash tests/design.sh`. Stop on any failure.

2. **Stage.** Build and stage into the scratchpad:
   ```bash
   STAGE="<scratchpad>/design-sync"
   rm -rf "$STAGE" && mkdir -p "$STAGE"
   bundle exec jekyll build --quiet -d "$STAGE/site"
   ruby script/stage_design_system.rb "$STAGE/site" "$STAGE/out"
   ```

3. **Read the live system.** With the Artifact tool, `read` the artifact URL, then `read` with `path: "project/design-system.json"` and with `path: "artifact-type/reference/format.md"` and `path: "artifact-type/reference/cover.md"` if this session has not read them. Follow `format.md` for every file shape.

4. **Icons.** If the index's `assetGroups.Icons.files` lacks any of `overcome.svg`, `create-advantage.svg`, `attack.svg`, `defend.svg`, `fate-die.svg`, upload each missing one from `images/icons/` with `{action: "publish", url, file_path, asset: true}` and record `{"name", "blob", "size", "type": "image/svg+xml"}` from the result. Never re-upload icons that are already recorded.

5. **Cover.** Keep `project/components/Cover/preview.html` as it is unless the brand changed. To create or redo it, follow `cover.md` and write it into `$STAGE/out/project/components/Cover/`.

6. **Index.** Copy the index you read in step 3 to `$STAGE/out/project/design-system.json`. Keep every key and the marker. Set `title` to "Fate of Eberron", `namespace` to "FateOfEberron", `libraries` to `[]`, keep `groups` containing "Icons", and set `lastChange` to `{"by": "<user's name>", "at": "<now, ISO 8601>", "via": "Claude Code design-sync", "note": "<one line: what changed>"}`.

7. **Publish once.** One Artifact call with `url`, `root: "$STAGE/out"`, `file_path: "$STAGE/out/project/design-system.json"` and `files` mapping every other staged path (`"project/tokens.json": "project/tokens.json"`, and so on). Components that disappeared from the sample get `"project/components/<Name>/README.md": null` and `"project/components/<Name>/preview.html": null`.

8. **Report.** Give the user the artifact link and the list of components published. If the publish is refused because someone saved meanwhile, read the index again, redo step 6 once, and publish; if refused again, stop and tell the user.

## Rules

- Never write outside `project/` in the artifact.
- Never upload previews, tokens or READMEs as assets; only the icon SVGs.
- Never remove an asset someone added on claude.ai.
````

- [ ] **Step 7: Run the full suite**

Run: `bash tests/design.sh`
Expected: all PASS, including `stage_design_system_test`.

- [ ] **Step 8: Commit and push**

```bash
git add script/stage_design_system.rb tests/design/unit/stage_design_system_test.rb .claude/skills/design-sync/SKILL.md
git commit -m "Add design system staging script and design-sync skill

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```

---

### Task 9: Create and publish the claude.ai Design System

This task runs in a session with the Artifact tool. It has no automated test; the checks are the publish results and a look at the published page.

**Files:**
- Modify: `CLAUDE.md` (Design System section, Project Structure)

**Interfaces:**
- Consumes: `script/stage_design_system.rb`, `.claude/skills/design-sync/SKILL.md`.
- Produces: the artifact URL, recorded in CLAUDE.md.

- [ ] **Step 1: Create the artifact**

Artifact tool: `{action: "publish", type_url: "https://claude.ai/artifact/5M7UeXXcx16TP3vzVFNDzd", title: "Fate of Eberron", auto_open: "after_first_write"}` with no files. Note the returned `url`.

- [ ] **Step 2: Read the type references**

Artifact tool `read` on the new url with `path` for each of `SKILL.md`, `artifact-type/reference/format.md`, `artifact-type/reference/cover.md`, `artifact-type/reference/craft.md`. If `format.md` contradicts anything in `script/stage_design_system.rb` (preview header, bundle path, token shapes), fix the script and its test first, rerun `bash tests/design.sh`, and commit that fix before continuing.

- [ ] **Step 3: Stage and upload icons**

Run step 2 of the design-sync skill. Then upload the five SVGs in `images/icons/` as assets (step 4 of the skill), recording each result.

- [ ] **Step 4: Write the cover and the index**

Write `$STAGE/out/project/components/Cover/preview.html` following `cover.md`, using only tokens and the noir palette, with the title "Fate of Eberron" in Cinzel Decorative and gold. Write `$STAGE/out/project/design-system.json` as a new index:

```json
{
  "v": 3,
  "layout": "files",
  "createdOnFiles": { "v": 1, "at": "<now, ISO 8601>" },
  "title": "Fate of Eberron",
  "namespace": "FateOfEberron",
  "libraries": [],
  "sections": {},
  "groups": ["Icons"],
  "assetGroups": {
    "Icons": {
      "name": "Icons",
      "tile": "m",
      "order": ["overcome.svg", "create-advantage.svg", "attack.svg", "defend.svg", "fate-die.svg"],
      "files": {
        "overcome.svg": { "name": "overcome.svg", "blob": "<id from upload>", "size": 79764, "type": "image/svg+xml" },
        "create-advantage.svg": { "name": "create-advantage.svg", "blob": "<id from upload>", "size": 458540, "type": "image/svg+xml" },
        "attack.svg": { "name": "attack.svg", "blob": "<id from upload>", "size": 135034, "type": "image/svg+xml" },
        "defend.svg": { "name": "defend.svg", "blob": "<id from upload>", "size": 123705, "type": "image/svg+xml" },
        "fate-die.svg": { "name": "fate-die.svg", "blob": "<id from upload>", "size": 875470, "type": "image/svg+xml" }
      }
    }
  },
  "blobs": {},
  "docs": { "sections": [] },
  "lastChange": { "by": "Ryan Singer", "at": "<now>", "via": "Claude Code design-sync", "note": "First publish from the repository" }
}
```

The `<id from upload>` and `<now>` values are filled from the step 3 upload results and the current time; sizes are the byte counts shown (`wc -c images/icons/*.svg`).

- [ ] **Step 5: Publish**

Run step 7 of the design-sync skill (one call, index as `file_path`). Then open the artifact and check: the brand book renders, all 16 component cards show live previews in noir, the Icons group shows five tiles, the token page lists both themes.

- [ ] **Step 6: Record the URL in CLAUDE.md**

In `CLAUDE.md`, add after the "Flavor text TTS" paragraph:

```markdown
**Design System**: tokens and components live in `design/` (source of truth), `assets/css/components.css` and `assets/css/handouts.css`, published to claude.ai at <artifact url>. Read that system's README before designing any sheet, card, handout or page for this project. After changing any of those files, run the `design-sync` skill.
```

In the Project Structure tree in `CLAUDE.md`, add these lines in place:

```
├── design/               # Design system source: tokens.json, brand book, component guidelines
├── design-sample.md      # Hidden page rendering every component (source of claude.ai previews)
├── _plugins/             # design_tokens.rb: tokens.json to assets/css/tokens.css at build
├── script/               # stage_design_system.rb for design-sync
```

- [ ] **Step 7: Commit and push**

```bash
git add CLAUDE.md
git commit -m "Record design system artifact in CLAUDE.md

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>"
git push
```
