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
