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
