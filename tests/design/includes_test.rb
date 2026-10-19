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
end
