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
