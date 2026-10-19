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
