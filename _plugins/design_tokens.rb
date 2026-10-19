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
