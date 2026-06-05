# Phase 1: Inline Reference Material

## Overview

Phase 1 adds battle tested reference material and systems to the existing Fate of Eberron guides, drawing structural patterns from Umdaar (Rebel Broadcast Edition), Venture City, and the Book of Hanz. These changes go directly into `players-guide.md` and `gm-guide.md` where players and GMs need them.

This is the first of three phases:
- **Phase 1** (this spec): Inline reference material, character creation redesign, consequential magic, signature spells
- **Phase 2**: Toolkit document foundation (genre dials, compel/drama escalation, region/continent system)
- **Phase 3**: Toolkit content (case generator, NPC gallery, exploration rules)

### Sources

- **Umdaar: Planet of Swords, Super Science, and Sorcery** (Rebel Broadcast Edition, EHP0077, 2026). Specific references noted as (Umdaar p.XX).
- **Venture City** (Evil Hat Productions). Power/enhancement/special effect structure for signature spells.
- **Book of Hanz** (collected Fate advice). "Put a Scene On It" framing for difficulty setting.
- **Reddit post on Consequential Magic** (r/FATErpg, u/unknown). Consequence slots as spell effect framework.

---

## 1. Attack and Defend Skill Reference

**Location:** `players-guide.md`, replaces the existing "Which Skills Attack and Defend?" section and "Non-Violent Attacks" section.

**Pattern source:** Umdaar p.114-115.

**Design principle:** Only skills that work without stunt support appear in these tables. If it needs a stunt, it belongs in the stunt section, not the skill reference.

### Attacking

| Skill | Use For | Notes |
|-------|---------|-------|
| Fight | Melee combat, unarmed strikes | Targets in your zone only |
| Shoot | Ranged weapons, thrown objects | Adjacent zones or further if line of sight is clear |
| Provoke | Intimidation, taunting, enraging | Deals mental stress. May not work on unfeeling or unthinking targets |
| Rapport | Persuasion, negotiation, de escalation | Deals mental stress. Less effective mid violence or against hostile targets with no prior connection |
| Deceive | Lies, manipulation, false promises | Deals mental stress. Fails once the truth is revealed |
| Drive | Ramming, vehicular attacks | May cause harm to your own vehicle |

### Defending

| Skill | Defend Against | Notes |
|-------|---------------|-------|
| Fight | Melee attacks | May not work against colossal foes or attacks you can't parry |
| Athletics | Any physical attack, melee or ranged | Dodging, diving, leaping clear |
| Will | Mental attacks, intimidation, fear | May not work against deception |
| Empathy | Deceive attacks, manipulation | Reading intent, sensing the lie |
| Notice | Traps, ambushes, surprises | Spotting danger before it hits |
| Physique | Poisons, environmental hazards, extreme conditions | Enduring rather than evading |
| Drive | Physical attacks while piloting | Evasive maneuvers, hard turns |

Include a brief closing note: the GM and table can grant other skills permission to attack or defend in specific circumstances. Stunts make that permission permanent.

---

## 2. Difficulty Setting Reference

**Location:** `gm-guide.md`, replaces the existing "Setting Difficulty and Opposition" section.

**Pattern source:** Umdaar p.126, Book of Hanz "Put a Scene On It."

### Layer 1: Should You Roll At All?

Before setting a difficulty, ask:
- What is this scene about?
- What's at stake?
- What could go wrong?
- What interesting thing is about to happen?

If there are no good answers, skip the roll. If the answers suggest drama, **put a scene on it.** Frame the time, place, and complications before anyone touches dice.

Example: A player wants to repair their skycoach. Don't just set a Crafts difficulty. Where's the hangar? Who else is there? Is the Boromar clan watching? Are the parts black market? Now you have a scene, and rolls within that scene mean something.

If the game were a TV show, would they spend screen time on this? If not, skip it.

### Layer 2: Difficulty Table

| Difficulty | Rating | When to Use | Eberron Example |
|------------|--------|-------------|-----------------|
| Trivial | Mediocre (+0) | No real challenge, but something could still go interestingly wrong | Picking a simple lock in an empty room |
| Routine | Fair (+2) | One clear reason it's tough | Fast talking past a bored Watch sergeant |
| Challenging | Good (+3) | Tough even for a trained professional | Navigating the Cogs without a guide |
| Hard | Great (+4) | Requires expertise and effort | Deciphering a Dhakaani cipher |
| Extreme | Superb (+5) | Most characters need to invoke aspects | Breaking into a Kundarak vault |
| Legendary | Fantastic (+6)+ | Nearly impossible without serious preparation | Dispelling a ward on a Cannith creation forge |

### Rules of Thumb

- Start at Fair (+2). Add +1 for each complicating factor.
- Prefer creating a situation aspect over raising difficulty. *Slippery Skybridge* is more interesting than "+2 because it's wet."
- Active opposition (an NPC rolling) is almost always better than passive difficulty.
- If it seems impossible, let them stack create advantage actions first. That's the game working as intended.

---

## 3. Consequence Naming Guide

**Location:** `players-guide.md`, added to the existing "Stress and Consequences" section after the mechanical description.

**Pattern source:** Umdaar p.138-139.

### Physical Consequences

| Severity | Absorbs | Examples |
|----------|---------|---------|
| Mild (2) | Near miss, minor hurt | *Nasty Bruise*, *Winded*, *Grazed by Crossbow Bolt*, *Ringing Ears* |
| Moderate (4) | Serious injury, needs treatment | *Deep Sword Cut*, *Dislocated Shoulder*, *Second Degree Burns*, *Cracked Ribs* |
| Severe (6) | Life altering, long recovery | *Shattered Kneecap*, *Spine Damage*, *Crushed Hand*, *Internal Bleeding* |

### Mental Consequences

| Severity | Absorbs | Examples |
|----------|---------|---------|
| Mild (2) | Shaken, flustered | *Rattled*, *Flustered*, *Momentarily Paralyzed by Doubt*, *Stung Pride* |
| Moderate (4) | Genuine emotional damage | *Terrified of the Dark*, *Crisis of Faith*, *Burning Shame*, *Shaken Loyalty* |
| Severe (6) | Deep trauma | *Recurring Nightmares from the Mourning*, *Broken Will*, *Complete Loss of Trust*, *War Flashback Disorder* |

### Magical Consequences

| Severity | Absorbs | Examples |
|----------|---------|---------|
| Mild (2) | Minor magical effect | *Magical Sleep*, *Momentary Blindness*, *Frostbitten Fingers*, *Unsettling Whispers* |
| Moderate (4) | Significant magical affliction | *Phiarlan Glamour: Wrong Face*, *Dreambound*, *Limbs Won't Obey*, *Marked by the Traveler* |
| Severe (6) | Profound magical transformation | *Mournland Corruption Spreading*, *Soul Partially Unmoored*, *Petrification Creeping Up My Legs*, *Vol's Death Curse* |

### Naming Principle

The name IS the fiction. Once you write *Shattered Kneecap*, that character can't run. Once you write *Phiarlan Glamour: Wrong Face*, everyone sees someone else. Consequences are aspects: always true, invokable, and compellable.

### Recovery Renaming

When treatment succeeds, rename to reflect healing. *Shattered Kneecap* becomes *Walking with a Limp*. *Magical Sleep* becomes *Groggy and Sluggish*. *Dreambound* becomes *Lingering Dream Fragments*. The renamed aspect can still be invoked and compelled until it fully clears.

---

## 4. Stunt Creation Templates

**Location:** `players-guide.md`, replaces the existing "Step 4: Stunts" section with expanded content.

**Pattern source:** Umdaar p.90-97, Atomic Robo RPG (Personal Hardware).

### Seven Stunt Patterns

**1. Skill Bonus (narrow +2)**

> Because I [reason], I get +2 to [skill] when [specific situation].

- *Sharn Street Rat*: Because I grew up in the lower wards, I get +2 to Notice when spotting danger in Sharn's undercity.
- *Veteran Interrogator*: Because I served in Karrnathi intelligence, I get +2 to Empathy when questioning someone I suspect of lying.

**2. Skill Substitution**

> Because I [reason], I can use [Skill A] instead of [Skill B] when [specific situation].

- *Arcane Scholar*: Because I studied combat magic at Arcanix, I can use Lore instead of Shoot when making magical ranged attacks. *(Note: if unrestricted, this needs a limit. See Signature Spells.)*
- *Deft Hands*: Because I'm a trained pickpocket, I can use Burglary instead of Fight to defend against grab attempts.

**3. Once Per Session Effect**

> Because I [reason], once per session I can [powerful effect].

- *Healing Touch (House Jorasco)*: Because I bear the Mark of Healing, once per session I can clear a mild physical consequence on a person I touch by rolling Empathy against Fair (+2).
- *Changeling Vanish*: Because I can shift my features instantly, once per session I can disappear into a crowd by becoming someone else, escaping a scene without a roll.

**4. Fate Point Powered**

> Because I [reason], I can spend a fate point to [dramatic effect].

- *Call Lightning (Mark of Storm)*: Because I bear the Mark of Storm, I can spend a fate point to make a zone attack with Shoot against every target in an outdoor zone.
- *Warforged Resilience*: Because my body is built for war, I can spend a fate point to ignore all stress from a single physical attack.

**5. Conditional Permission**

> Because I [reason], I can [action normally not allowed] when [condition].

- *Inquisitive's Eye*: Because I notice what others miss, I can use Investigate to defend against ambushes and traps instead of Notice.
- *Silver Flame Exorcist*: Because I trained to fight possessing spirits, I can use Will to make mental attacks against entities from other planes.

**6. Teamwork / Altruistic**

> When I'm in [situation] with an ally, they gain +2 to [skill] when [action].

- *Watch Each Other's Backs*: When I'm in the same zone as an ally in a fight, they gain +2 to Athletics when defending against ranged attacks.
- *Inspiring Presence*: When I lead a charge, allies in my zone gain +2 to Will when defending against fear or intimidation.

**7. Personal Hardware**

> Your character has an iconic possession. Pick two options from the list. If two isn't enough, take this stunt again.

Options (pick two):
- +1 to one situational application of one skill
- Weapon:2
- Armor:1
- Add a new action to a skill (once per session)

Non mechanical capabilities come free if they make fictional sense. A sending stone lets you communicate at distance. A featherfall token lets you survive a fall. No roll needed unless the situation is risky.

Eberron examples:
- *Cannith Repeating Crossbow*: Weapon:2, +1 to Shoot when laying down suppressive fire
- *Darkleaf Weave Armor*: Armor:1, +1 to Stealth when moving quietly
- *Docent (Warforged)*: +1 to Lore when recalling historical facts, once per session can use Lore to create an advantage representing tactical analysis from the docent's memory
- *Jorasco Healing Kit*: +1 to Empathy when treating physical consequences, once per session can use Empathy as an overcome to stabilize a character who was taken out
- *Tharashk Dragonshard Focus*: Weapon:2 on magical attacks, +1 to Notice when tracking a specific target

### Design Guidance

- If your stunt would work in every situation, it's too broad. Narrow it.
- If your stunt would never come up, it's too narrow. Broaden it.
- Skill substitution stunts don't need extra limits if the substitution is already situational.
- Stunts that cost a fate point can be more dramatic than free stunts.
- When in doubt, model it on an existing stunt and change the fiction.
- Personal Hardware fills the gap between "I just have a sword" (narrative permission, no stunt) and "I have a legendary Dhakaani blade" (should be an aspect AND a stunt).

---

## 5. Charter System (Party Framework)

**Location:** `players-guide.md`, new section after character creation. Cross reference from `gm-guide.md` campaign frameworks.

**Pattern source:** Umdaar Banners (p.25-44).

### What Is a Charter?

A Charter is the party's shared identity: who they are together, where they operate, who they know, and who wants to stop them. Every group builds one during Session Zero.

### Charter Components

| Component | What It Is | What You Create |
|-----------|-----------|-----------------|
| **Framework** | The type of campaign | Pick one: Agency, Expedition, Cell, Salvage Crew, House Operatives |
| **Territory** | Where the action happens | A region with one or two issue aspects |
| **Headquarters** | Where the party is based | A location with a high concept and one aspect |
| **Community** | The people you care about and protect | A group with a high concept and a values aspect |
| **Patron or Contact** | The NPC who connects you to work | A name, high concept, one skill at Fair (+2)+ |
| **Antagonist** | The recurring opposition you've already tangled with | A name, high concept, and motivation |
| **Reputation** | What people say about you | A party name and reputation aspect |

### Framework Examples

**Agency** (Inquisitive shop):
- Territory: A Sharn ward or district
- HQ: Ramshackle office in Callestan, Lower Dura. *Aspect: Everyone Knows Where to Find Us*
- Community: The working people of Lower Dura who can't afford the Watch's attention
- Antagonist: A Boromar underboss who you've crossed before

**Expedition** (Xen'drik explorers):
- Territory: A stretch of Xen'drik coastline or interior
- HQ: A chartered ship docked at Stormreach. *Aspect: Our Funding Depends on What We Bring Back*
- Community: The crew and scholars aboard the ship
- Antagonist: A rival Morgrave expedition with fewer scruples

**Cell** (Shadow war / resistance):
- Territory: A nation or occupied territory
- HQ: A safehouse that changes every few sessions. *Aspect: If They Find This Place, We're Done*
- Community: A network of sympathizers and informants
- Antagonist: A Citadel handler who's hunting you, or a Trust agent

**Salvage Crew** (Mournland operations):
- Territory: The border towns and the Mournland interior
- HQ: A fortified camp outside the dead gray mist. *Aspect: Last Stop Before the Nothing*
- Community: Other salvagers, refugees, border town locals
- Antagonist: A Lord of Blades lieutenant, or a living spell that seems to follow you

**House Operatives** (Dragonmarked intrigue):
- Territory: Multiple cities connected by House interests
- HQ: A House enclave or satellite office. *Aspect: The House Provides, the House Expects*
- Community: House heirs, workers, and allies caught in internal politics
- Antagonist: A rival faction within your own House

### Building the Charter (Session Zero)

1. **Pick a framework.** Discuss what kind of campaign excites the group.
2. **Define territory.** Pick or create a region. Write one or two issue aspects describing what's wrong there now. These are the problems the campaign is about.
3. **Create headquarters.** Name it, give it a high concept and one aspect. Start humble. The HQ can improve at major milestones.
4. **Define community.** Who are the people you care about? Give them a high concept and a values aspect. These values may align with or challenge the PCs' own beliefs.
5. **Create a patron or contact.** The NPC who brings you work, passes along information, or gives orders. Name, high concept, one relevant skill at Fair (+2) or higher.
6. **Create an antagonist.** Someone you've already clashed with. Not the campaign's final villain, but a persistent mid level threat. Name, high concept, motivation.
7. **Name yourselves and write a reputation aspect.** Assume you've been together for a while with at least one victory and one failure behind you. Mixed reputations work best for longer campaigns.

### Charter Stunts

Each framework has associated charter stunts. When creating your character, pick one from your framework's list or create your own. Charter stunts reflect the party's shared resources, methods, and reputation.

**Agency Stunts:**
- *We Know This Town*: When investigating in our territory, the party gains +2 to Contacts when looking for witnesses or informants.
- *The Office Never Closes*: Once per session, a client or contact shows up at HQ with a lead, creating a situation aspect with a free invoke.
- *Street Cred*: When our reputation is known, gain +2 to Rapport with locals who've heard of us.

**Expedition Stunts:**
- *Provisioned for Anything*: Once per session, a party member can declare they packed a useful non magical item, creating a situation aspect with a free invoke.
- *Seasoned Explorers*: When navigating unknown terrain together, the lead explorer gains +2 to Investigate or Notice.
- *Shared Field Notes*: When one party member succeeds with style on a Lore or Investigate roll related to ruins or artifacts, another party member gains a boost.

**Cell Stunts:**
- *Safe House Protocol*: When the party retreats to their HQ, each member clears one additional stress box.
- *Dead Drops*: Once per session, a party member can use Contacts to receive intelligence from the network without being seen.
- *Ghosts in the Machine*: When operating covertly as a group, gain +2 to Stealth against organized opposition.

**Salvage Crew Stunts:**
- *Mournland Survival Instinct*: When in the Mournland, the party gains +2 to Notice against environmental hazards.
- *Scavenger's Eye*: Once per session, a party member can declare that a piece of salvage they recovered is useful right now, creating a situation aspect with a free invoke.
- *Nobody Left Behind*: When a party member is taken out, another party member in the same zone can spend a fate point to convert the taken out result to a severe consequence instead.

**House Operative Stunts:**
- *House Resources*: Once per session, a party member can use the House's resources to gain +2 to Resources for a single roll.
- *Internal Contacts*: When dealing with members of your own House, gain +2 to Contacts.
- *The House Remembers*: When an NPC who has previously interacted with the party encounters them again, the party starts with a boost representing the House's reputation.

### Charter Advancement

At major milestones, the group can:
- Improve a community aspect
- Upgrade headquarters (add a new aspect or improve the high concept)
- Change the reputation aspect
- Change the framework if the campaign shifts direction

---

## 6. Character Creation Redesign

**Location:** `players-guide.md`, replaces the existing mode based character creation system.

**Pattern source:** Umdaar character creation (p.50-70).

### Character Components

| Component | What It Provides |
|-----------|-----------------|
| **Archetype** | Important skills, one archetype stunt, Impact (world effect at milestones) |
| **Background** | Character building questions, one background stunt, community connection |
| **Species** (optional) | Narrative permission via aspect, one optional stunt (costs refresh) |
| **Charter** | One charter stunt connecting you to the party |
| **Aspects** (5) | High concept, motivation, background, relationship, free |
| **Skills** | Pyramid: 1 Great (+4), 2 Good (+3), 3 Fair (+2), 4 Average (+1) |
| **Stunts** (3) | One archetype, one background, one charter |
| **Refresh** | 3 (reduced by extra stunts or species stunt) |

### Archetypes

Each archetype defines what the character does now. It provides three important skills (which should guide but don't restrict skill pyramid choices), three associated stunts (pick one at creation), and an Impact that changes the campaign map at each major milestone.

| Archetype | Important Skills | Sample Stunts | Impact |
|-----------|-----------------|---------------|--------|
| **Inquisitive** | Investigate, Notice, Contacts | Inquisitive's Eye, Scene Reconstruction, I Know a Guy | Add a contact or informant to the campaign map |
| **Artificer** | Crafts, Lore, Investigate | Jury Rig, Maker's Eye, Improvised Device | Add a location tied to your work (workshop, dig site, client) |
| **Mage** | Lore, Will, Shoot | Arcane Shield, Elemental Blast, Ward Specialist | Add a magical phenomenon or mystery to the campaign map |
| **Priest** | Will, Empathy, Rapport | Divine Conviction, Healing Hands, Turn Undead | Add a community or congregation to the campaign map |
| **Warrior** | Fight, Athletics, Physique | Combat Veteran, Shield Wall, Deadly Charge | Add a rival, enemy, or military contact to the campaign map |
| **Face** | Rapport, Deceive, Contacts | Read the Room, Silver Tongue, Extensive Network | Add a faction relationship (ally, rival, or debt) to the campaign map |
| **Spy** | Stealth, Deceive, Investigate | Dead Drop, Cover Identity, Shadow Network | Add a secret or hidden connection to the campaign map |
| **Explorer** | Athletics, Notice, Will | Danger Sense, Trailblazer, Ruin Runner | Add a location (ruin, passage, landmark) to the campaign map |
| **Pilot** | Drive, Crafts, Notice | Evasive Maneuvers, My Ship My Rules, Barnstormer | Add a route, port, or vehicle upgrade to the campaign map |

Custom archetypes: a name, three important skills, three associated stunts, and an impact.

### Multiple Archetypes

Characters can combine two archetypes (e.g., Mage + Warrior, Spy + Face). When combining:
- Copy important skills from both archetypes; use the combined list for skill pyramid guidance.
- Pick one stunt from each archetype at creation.
- At each major milestone, choose one archetype's impact action.
- Reduce starting refresh by one (from 3 to 2).

### Backgrounds

Each background defines where the character comes from and what they did before. It provides three important skills, three associated stunts (pick one at creation), and a set of character building questions that help flesh out aspects during creation.

| Background | Important Skills | Sample Stunts | Questions to Consider |
|-----------|-----------------|---------------|----------------------|
| **Soldier** | Fight, Athletics, Provoke | War Stories, Battlefield Awareness | Which nation did you serve? What did you see that changed you? Do you miss it? |
| **Criminal** | Burglary, Stealth, Contacts | Underworld Connections, Case the Joint | Who do you still owe? What line won't you cross? Are you still in the life? |
| **Scholar** | Lore, Investigate, Will | Obsessive Researcher, Ancient Languages | What's your field? What question drives you? What did you discover that scared you? |
| **Noble** | Rapport, Resources, Contacts | Noble Bearing, Old Money | Is your family's influence a gift or a cage? What's expected of you? Who resents your privilege? |
| **Entertainer** | Rapport, Deceive, Empathy | Play to the Crowd, Stage Presence | What's your art? Where have you performed? What audience do you never want to face again? |
| **Outlander** | Athletics, Notice, Physique | Survivor, Read the Wild | Where did you come from? Why did you leave? What about civilization confuses or disgusts you? |
| **Street Urchin** | Stealth, Burglary, Notice | Rat Runner, Invisible in a Crowd | Who raised you, if anyone? What ward or district is yours? Who do you protect now? |
| **Dragonmarked Heir** | Contacts, Resources, Rapport | House Connections, Mark Focus | Which house? Are you loyal or rebellious? What does the house want from you that you're not willing to give? |
| **Veteran Spy** | Deceive, Stealth, Investigate | Old Covers Still Work, Trust Issues | Which agency? Citadel? Trust? Royal Eyes? What secret do you carry? Are you still active? |
| **Refugee** | Empathy, Will, Notice | Nothing Left to Lose, Community of Survivors | What did you lose? Where are you from? What do you hold onto from the old life? |

Custom backgrounds: a name, three important skills, three associated stunts, and a set of character building questions.

### Species as Aspect + Stunt

Most characters are human and don't need anything special. For non human species, take an aspect (which counts as one of your five) and optionally a species stunt (costs 1 refresh):

| Species | Aspect Grants (narrative permission) | Optional Stunt |
|---------|-------------------------------------|----------------|
| **Warforged** | Don't eat, sleep, or breathe. Resistant to poison and disease. | *Built for War*: Armor:1 against physical attacks |
| **Changeling** | Can shift features at will to match any humanoid | *Perfect Mimic*: +2 to Deceive when impersonating a specific person you've studied |
| **Shifter** | Can briefly manifest bestial features | *Shifting*: Pick two skills when you take this stunt. Once per scene, you may swap their ratings for the rest of the scene. |
| **Kalashtar** | Telepathic communication with willing targets. Dream resistance. | *Psychic Shield*: +2 to Will when defending against mental attacks from extraplanar entities |

### Aspects

Five aspects, built during creation:

1. **High Concept**: Broad description combining archetype, background, and descriptors. Example: *Cyran Refugee Turned Sharn Inquisitive*
2. **Motivation**: Why your character acts as a champion of this cause. Should push you into action, even when it's risky. Example: *I Won't Let What Happened to Cyre Happen Again*
3. **Background**: Where you grew up, your community, its values. Example: *Proud Karrnathi, Ashamed of What We Did*
4. **Relationship**: Shared bond with another PC. Types: best friends, siblings in arms, mentor/protege, love interest, rivals. Example: *She Saved My Life in the Mournland and I Still Don't Know Why*
5. **Free**: Anything else. A weapon, personality trait, catchphrase, secret. Example: *My Father's Byeshk Blade*, *Trust Is a Luxury I Can't Afford*

### Skill Pyramid

Arrange skills in a pyramid with the highest rated skill at Great (+4):

- 1 Great (+4) skill
- 2 Good (+3) skills
- 3 Fair (+2) skills
- 4 Average (+1) skills
- All other skills at Mediocre (+0)

The archetype and background important skills should guide your choices but don't restrict them.

### Stunts

Three stunts at creation, one from each source:
- One **archetype stunt** (from your archetype's list or create your own)
- One **background stunt** (from your background's list or create your own)
- One **charter stunt** (from your group's charter framework)

Additional stunts may be purchased by spending refresh (minimum refresh of 1).

### Refresh

Starting refresh is 3. Reduced by 1 for each additional stunt beyond the starting three, and by 1 if you take a species stunt.

### Creation Checklist

1. Pick an archetype
2. Pick a background
3. Optionally, choose a species (aspect + optional stunt)
4. Write your five aspects (high concept, motivation, background, relationship, free)
5. Arrange your skill pyramid
6. Pick three stunts (one archetype, one background, one charter)
7. Note refresh, stress tracks, and consequence slots

---

## 7. Consequential Magic System

**Location:** `players-guide.md`, replaces and expands the existing "Magic and Artifice" section's "Narrative Magic" subsection.

**Pattern sources:** Reddit "Consequential Magic" post (r/FATErpg), Umdaar magic (p.12-13), Fate Condensed attack/consequence rules.

### Core Principle

Magic that creates lasting effects works through the attack/consequence framework. The magical effect occupies a consequence slot on the target. Duration, power, and difficulty are all handled by existing consequence mechanics. Temporary tactical magic uses create advantage as normal.

### Two Gears of Magic

| What You Want | How It Works | Duration |
|---------------|-------------|----------|
| Temporary tactical effect | Create Advantage (situation aspect) | Scene, or until overcome. Minor in terms of power level. |
| Lasting effect on a target | Attack (consequence) | Consequence recovery timeline |
| Repeatable signature ability | Stunt (see Signature Spells) | Permanent (per stunt limits) |
| Collaborative ritual/research | Brainstorm | Until the problem is solved |
| Crafted magical item | Invention (catches) | Permanent until broken/lost |

Create Advantage remains the default for most magical actions. A mage uses Lore to create the aspect *Blinding Light*. A priest uses Will to create *Shield of the Silver Flame*. An artificer uses Crafts to create *Smoke Bomb Deployed*. These are powerful and flexible, but temporary and removable with a standard overcome action.

Consequential magic is specifically for when magic attacks or creates lasting effects.

### Four Channels of Magical Attack

| Channel | Skill | Defense | When to Use |
|---------|-------|---------|-------------|
| Precise | Shoot | Athletics | Target can physically dodge the effect (bolt of lightning, ray of frost, force missile) |
| Coercive | Provoke | Will | Target resists mentally (fear, domination, psychic assault, compulsion) |
| Subtle | Deceive | Empathy | Target doesn't realize they're being affected (illusions, charms, suggestion) |
| Unresisted | Lore or Crafts | Passive difficulty | Target is an object, zone, willing subject, or unable to resist |

Lore and Crafts both work for unresisted magic. Lore channels through knowledge and incantation; Crafts channels through artifice and inscription. An Artificer wards a door with Crafts. A Mage wards it with Lore. Same result, different fiction.

### Consequences as Spell Effects

The magical effect occupies one of the target's consequence slots:

| Consequence | Shifts to Inflict | Duration | Example |
|-------------|-------------------|----------|---------|
| Mild (2) | 2 beyond stress | Clears 1 scene after treatment | *Magical Sleep*, *Momentary Blindness* |
| Moderate (4) | 4 beyond stress | Clears 1 session after treatment | *Phiarlan Glamour: Wrong Face*, *Dreambound* |
| Severe (6) | 6 beyond stress | Clears 1 scenario after treatment | *Mournland Corruption*, *Soul Anchored* |

### Consented / Beneficial Magic

When a target welcomes the effect (buffing allies, shapeshifting yourself), they skip the attack roll and simply accept the consequence at the desired severity. The consequence slot is occupied, which is the real cost: a warded character is harder to hurt with further magic but also more fragile if physically attacked.

Examples: *Shapechanged: Hawk Form*, *Warded Against Scrying*, *Blessing of the Silver Flame*.

### Treatment / Dispelling

Same as normal consequence recovery. Lore always works for treating magical consequences, in addition to the usual Empathy for mental and appropriate skills for physical. Difficulty follows the standard: Fair (+2) for mild, Great (+4) for moderate, Fantastic (+6) for severe. Self treatment adds +2 to difficulty.

When treatment succeeds, rename the consequence to reflect recovery. *Magical Sleep* becomes *Groggy and Sluggish*. *Dreambound* becomes *Lingering Dream Fragments*. The renamed aspect can still be invoked and compelled until it fully clears.

### Wards and Persistent Effects (Bronze Rule)

Objects and locations can take consequences via the Bronze Rule. A warded door, a cursed room, an enchanted bridge. The GM sets passive difficulty for the Lore or Crafts roll. The caster chooses the severity of consequence to impose, which determines total shifts needed (the object's stress boxes + consequence absorption). Creating powerful wards requires preparation through create advantage actions first.

### Integration with Existing Systems

- **Signature Spells** (stunts) represent reliable, repeatable magical abilities. They may bypass or modify the consequential magic framework per their specific stunt description.
- **Brainstorms** remain for collaborative magical problem solving (ritual research, prophecy interpretation, breaking ancient wards).
- **Invention** remains for crafting magical items, using the catches system. Drawbacks from Venture City can serve as inspiration for catches and flaws on invented items.
- **Narrative permission** still applies. You need a magical aspect (high concept, free aspect, or species aspect) to use magic at all.

---

## 8. Signature Spell Framework

**Location:** `players-guide.md`, replaces and expands the existing "Signature Spells" subsection within "Magic and Artifice."

**Pattern sources:** Venture City power/enhancement structure, Umdaar stunt creation (p.90-97).

### Structure

A signature spell is a stunt that represents a reliable, repeatable magical ability. Unlike one off magical actions (create advantage or consequential magic attacks), signature spells are part of your character's identity.

**Signature Spell (1 stunt):** The base spell. Follows normal stunt patterns (skill bonus, skill substitution, once per session, fate point powered, etc.).

**Enhancement (1 stunt each):** An upgrade to an existing signature spell. Extends its reach, power, or flexibility. A player investing multiple stunts into one spell has a deep, distinctive magical identity.

### The Replication Rule

A signature spell that replicates what another skill already does needs a built in limit:
- Once per scene, OR
- Requires a fate point to activate, OR
- Restricted to a specific situation

The limit is what makes it a spell instead of just having the skill. Signature spells that do things no skill covers (healing consequences, summoning creatures, creating wards) can be more permissive.

### Enhancement Menu

Not every option applies to every spell. The player and GM pick what makes fictional sense.

| Enhancement | Effect |
|-------------|--------|
| **Master** | +2 to rolls with this spell |
| **Widen** | Affect a full zone instead of one target |
| **Extend** | Increase range by one zone |
| **Fortify** | Use the spell's skill to defend as well as attack |
| **Deepen** | Inflict a consequence instead of stress, or reduce consequence severity for healing |
| **Quicken** | Use the spell as a free action once per scene |

### Eberron Signature Spell Examples

**Force Bolt** (Morgrave War Mage)
- **Base (1 stunt):** Once per scene, I can use Lore to make a physical attack against a target up to 2 zones away. Targets defend with Athletics.
- **Enhancement: Master Force Bolt (1 stunt):** When I attack with Force Bolt, I get +2 to Lore.
- **Enhancement: Force Shield (1 stunt):** When I am targeted by a ranged physical attack I can see, I can use Lore to defend.
- **Enhancement: Concussive Wave (1 stunt):** I can spend a fate point to attack every target in a zone with Force Bolt.

**Healing Prayer** (Priest of the Silver Flame)
- **Base (1 stunt):** Once per scene, I can roll Will against Fair (+2) to clear all physical stress on a person I touch.
- **Enhancement: Miraculous Recovery (1 stunt):** When I treat a physical consequence with Will, I reduce the consequence severity by one step. Mild consequences clear immediately.
- **Enhancement: Radiant Shield (1 stunt):** I can spend a fate point to grant an ally in my zone Armor:2 against undead attacks for the rest of the scene.

**Whispering Shadows** (Phiarlan Shadow Spy)
- **Base (1 stunt):** Once per scene, I can use Deceive to create the aspect *Cloaked in Shadow* on myself with two free invokes instead of the usual one.
- **Enhancement: Shadow Step (1 stunt):** When I am in a zone with a shadow related aspect, I can spend a fate point to move to any other zone in the scene that also has a shadow related aspect, bypassing all obstacles.
- **Enhancement: Phantom Decoy (1 stunt):** I can use Deceive to create a shadow illusion of myself in an adjacent zone. The illusion has one stress box and can be attacked or investigated (Investigate vs. my Deceive) to dispel.

**Lightning Call** (Lyrandar Storm Caller)
- **Base (1 stunt):** Once per scene, I can use Shoot to make a magical attack using lightning against a target up to 3 zones away. Targets defend with Athletics.
- **Enhancement: Chain Lightning (1 stunt):** When I invoke an aspect on a Lightning Call attack, I may split the invoke bonus (+1/+1) across two targets in the same zone instead of +2 on one.
- **Enhancement: Storm Shield (1 stunt):** When I am targeted by a ranged physical attack, I can use Shoot to defend by deflecting the projectile with a gust of wind.

**Animate Dead** (Order of the Emerald Claw Necromancer)
- **Base (1 stunt):** Once per scene, I can summon one undead servant. It has one aspect (*Mindless Undead Servant*), one Good (+3) skill (Fight), and 2 physical stress boxes. It acts on my turn and lasts until the end of the scene or until destroyed.
- **Enhancement: Stronger Dead (1 stunt):** My summoned undead gains an additional Good (+3) skill (chosen when summoned) and a mild consequence slot.
- **Enhancement: Rise Again (1 stunt):** When my summoned undead is taken out, I can spend a fate point to immediately resummon it in my zone with full stress but carrying any consequences it had.

### Venture City Powers Adapted as Signature Spell Bases

The following Venture City powers provide well tested mechanical patterns for Eberron signature spells. Each can be taken as a base signature spell stunt:

| Venture City Power | Eberron Flavor | Mechanical Core |
|---|---|---|
| Energy Blast | Elemental bolt, force missile | Once per scene, use [skill] to attack at range up to X zones |
| Healing | Divine healing, Jorasco mark | Once per scene, roll [skill] to clear stress or start consequence recovery |
| Illusion | Phiarlan glamour, arcane mirage | Once per scene, create an illusion with +2 to Deceive against recognition |
| Influence | Enchantment, domination | Use Rapport to attack (mental stress); target chooses stress or compliance |
| Shielding | Arcane ward, divine shield | Create a barrier between zones; intercept attacks with Will |
| Creature Summoning | Bound elemental, animated dead | Summon a creature with one aspect, one Good (+3) skill, 2 stress boxes |
| Precognition | Divination, Mark of Detection | Use Notice to defend against physical attacks; always act first |
| Slowing | Hold person, temporal magic | Target cannot move zones until they overcome your roll |
| Harm | Necrotic touch, Vol's grasp | Deal extra stress on touch; enhancement: inflict consequence instead |
| Regeneration | Troll blood, healing factor | Physical consequences recover at reduced severity |
| Shape Shifting | Druidic wild shape | Will roll to create creature form advantage; persists until ended |
| Power Nullification | Antimagic, dispelling | Zone increases magic opposition by +2; enhancement: strip powers on touch |
| Super Senses | Divination, enhanced perception | +2 Investigate with chosen sense; sense cannot be impeded |

---

## Phase 2 and Phase 3 Preview

### Phase 2: Toolkit Document Foundation

A new document (`toolkit.md` or `eberron-toolkit.md`) containing:
- **Genre Dials**: Tone adjustment knobs for each campaign framework (grit, lethality, intrigue density, magic prevalence)
- **Compel and Drama Escalation**: Systematic guidance for building drama through compels, consequence stacking, and faction pressure
- **Region/Continent System**: Adapted from Umdaar's continent rules (p.234+) for building Sharn neighborhoods, Five Nations regions, Xen'drik territories, and planar locations with sites, communities, issues, and interconnections

### Phase 3: Toolkit Content

Additions to the toolkit document:
- **Case/Adventure Generator**: Procedural tables for generating mysteries, missions, and complications tailored to each campaign framework
- **NPC Gallery**: Fully statted recurring characters with personalities, faction ties, and relationship hooks for each framework
- **Exploration Rules**: Zone based travel and discovery systems for Xen'drik, the Mournland, and other wilderness/ruin settings

---

## Implementation Notes

### Files Modified
- `players-guide.md`: Sections 1, 3, 4, 6, 7, 8 (attack/defend tables, consequence guide, stunt templates, character creation, consequential magic, signature spells)
- `gm-guide.md`: Section 2, charter cross reference (difficulty setting, link to charter system)

### Files Created
- None in Phase 1. The toolkit document is created in Phase 2.

### Migration Concerns
- The mode system (Origins, Backgrounds, Callings) is fully replaced by archetypes + backgrounds + species. All existing mode content is retired.
- The existing Narrative Magic section is reframed, not deleted. Create advantage magic remains the baseline. Consequential magic is the new attack/lasting effect layer.
- The existing Signature Spells section is replaced by the expanded signature spell framework.
- Brainstorms, Invention, and Dragonmarks sections remain as written with minor cross references to the new systems.
- The existing campaign frameworks in the GM guide remain. The Charter system in the players guide cross references them.

### Compatibility
- All changes use standard Fate Condensed mechanics. No new subsystems are introduced; existing mechanics (aspects, consequences, stunts, stress) are applied to new domains.
- The consequential magic system is compatible with all existing adversary templates and NPC stat blocks.
- Characters created under the old mode system can be converted by mapping their mode skills to the pyramid and their mode identity to an archetype + background combination.
