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
