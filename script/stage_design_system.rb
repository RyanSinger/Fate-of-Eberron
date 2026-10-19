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

  BUNDLE_JS = %(/* @ds-bundle: {"format":4,"namespace":"FateOfEberron","components":[]} */\nwindow.FateOfEberron = {};\n)

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

  # Previews on claude.ai may load only the system's own files and uploads, so icons
  # that are uploaded assets (blobs: file name => blob id) point at /_blob/<id>.
  def preview_html(preview, base_url, blobs = {})
    body = preview[:body].gsub(/(src|href)="\//, "\\1=\"#{base_url}/")
    blobs.each do |file, id|
      body = body.gsub(%r{"#{Regexp.escape(base_url)}/[^"]*/images/icons/#{Regexp.escape(file)}"}, "\"/_blob/#{id}\"")
    end
    <<~HTML
      <!-- @dsCard group="#{preview[:group]}" height=#{preview[:height]} -->
      <!doctype html>
      <html lang="en">
      <head>
      <meta charset="utf-8">
      <link rel="stylesheet" href="#{FONTS}">
      <style>body { margin: 0; padding: var(--space-sm); color: var(--ink); font-family: var(--font-body); line-height: 1.6; }</style>
      </head>
      <body>
      #{body}
      </body>
      </html>
    HTML
  end

  def stage(site_dir, out_dir, root: ROOT, base_url: BASE_URL, blobs: {})
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
      File.write(File.join(dir, "preview.html"), preview_html(preview, base_url, blobs))
    end
    css = %w[components handouts].map { |f| File.read(File.join(root, "assets/css/#{f}.css")) }
    File.write(File.join(project, "components/bundle.css"), css.join("\n\n"))
    # claude.ai runs previews only when a bundle exists; the components here are plain HTML and CSS, so it is empty.
    File.write(File.join(project, "components/bundle.js"), BUNDLE_JS)
    list.map { |p| p[:name] }
  end
end

if $PROGRAM_NAME == __FILE__
  require "json"
  site_dir, out_dir, blobs_file = ARGV
  abort "usage: ruby script/stage_design_system.rb SITE_DIR OUT_DIR [ICON_BLOBS_JSON]" unless site_dir && out_dir
  blobs = blobs_file ? JSON.parse(File.read(blobs_file)) : {}
  names = StageDesignSystem.stage(site_dir, out_dir, blobs: blobs)
  puts "Staged #{names.size} components into #{File.join(out_dir, 'project')}: #{names.join(', ')}"
end
