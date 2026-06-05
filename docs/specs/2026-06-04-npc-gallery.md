# NPC Gallery

## Overview

A new document (`npcs.md`) containing ~30-35 ready to use NPCs for Eberron campaigns. Organized by faction, tagged by role and tier. Each entry has narrative context (who they are, what they want, a hook for introducing them) and a complete stat block.

### Where It Lives

New file: `npcs.md` at the repo root, same level as the other guides. Gets a Jekyll front matter block and an entry in `index.md`.

### Sources

- **Umdaar** (Rebel Broadcast Edition). Rogues Gallery (p.165-192) for structural pattern.
- **Fate of Eberron GM Guide** (existing). Adversary Types (threats, fillers, hitters, bosses), Quick Antagonist Templates, Eberron Adversary Categories.
- **Eberron setting lore.** Factions, organizations, and power structures of Khorvaire.

---

## NPC Entry Format

Every NPC follows this template:

```
#### Name, Title (Pronouns)
**Role:** [patron / contact / rival / enforcer / informant / leader / wild card]
**Tier:** [threat / filler / hitter / boss]

[2-3 sentences: who they are, what they want, why they're interesting]

**Hook:** [One sentence connecting them to play: how PCs encounter them or why they'd care]

**Aspects:**
- High Concept: [phrase]
- Trouble: [phrase]
- Other: [1-2 more if hitter/boss]

**Skills:**
- [peak skill and rating]
- [supporting skills]

**Stunts:** [1-2 for hitters, 2-3 for bosses, none for threats/fillers]

**Stress:** [physical and mental boxes]
**Consequences:** [if hitter or boss]
```

**Tier definitions** (from the GM guide):
- **Threat**: One aspect, 1-2 skills, no stress. One hit downs them. Mooks. Abbreviated stat block.
- **Filler**: One aspect, shared stress (1 box per member), 2-3 skills. Groups. Abbreviated stat block.
- **Hitter**: High concept + 1 aspect, peak skill +3/+4, 2-3 supporting skills, 2-3 stress boxes, mild/moderate consequence. Dangerous individuals. Full stat block.
- **Boss**: 5 aspects, skill pyramid, multiple stunts, full stress/consequences. Campaign level threats. Full stat block.

All tiers get the same narrative content (2-3 sentences, a hook). Only the mechanical depth varies.

---

## Faction Sections and NPC List

### Boromar Clan

Sharn's dominant criminal syndicate. Halfling run, deeply embedded in Lower Dura's economy. They control gambling, smuggling, and protection rackets. Currently losing territory to Daask.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Saidan Boromar** (he/him) | Leader | Boss | The aging patriarch. Sharp mind, failing body. Holds the clan together through loyalty and fear. |
| **Hallia Boromar** (she/her) | Rival | Hitter | Saidan's niece and likely successor. Ambitious, modern, willing to make deals her uncle wouldn't. |
| **Castar** (he/him) | Enforcer | Hitter | Boromar's chief leg-breaker. A halfling who doesn't fit the stereotype: tall for his kind, quiet, and terrifyingly efficient. |
| **Miri Quickfingers** (she/her) | Informant | Threat | A street urchin who runs messages for the Boromar. Knows every alley in Callestan. Will sell information to anyone, including you, including your enemies. |

### Daask

A monstrous crime syndicate backed by the Daughters of Sora Kell in Droaam. Ogres, gnolls, medusas, and changelings pushing into Boromar territory. Brutal but not stupid.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Cavallah** (she/her) | Leader | Boss | An ogre mage who runs Daask operations in Sharn. Genuinely believes Droaam deserves a seat at the table. Uses violence strategically, not gratuitously. |
| **Ash** (they/them) | Enforcer | Hitter | A changeling assassin. Daask's solution for problems that can't be solved with ogre strength. Nobody knows their real face. |
| **Grakk's Pack** (mixed) | Muscle | Filler | A gnoll street gang that controls two blocks in Malleon's Gate. Loyal to Cavallah. Surprisingly disciplined when they need to be. |
| **The Butcher of Fallen** (he/him) | Wild Card | Hitter | A minotaur pit fighter who handles Daask's most public violence. Theatrical. Enjoys his reputation. Secretly exhausted by it. |

### House Cannith

The house that makes things. Split into three factions (South, West, East) after the Mourning destroyed their headquarters in Cyre. They built the warforged. They built the creation forges. They may have built the weapon that caused the Mourning.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Merrix d'Cannith** (he/him) | Patron / Rival | Boss | Leader of Cannith South. Brilliant, secretive, probably running an illegal creation forge beneath Sharn. Will help you if it serves his interests. |
| **Leya d'Cannith** (she/her) | Contact | Hitter | A mid-level Cannith artificer with a conscience. Feeds information to people she trusts when the House does something she can't stomach. |
| **The Reforged** (it/its) | Wild Card | Hitter | A warforged that Merrix built in secret after the Treaty banned creation forges. It doesn't know it's illegal. It thinks it's a person. It is. |
| **Cannith Retrieval Team** (mixed) | Enforcer | Filler | A squad of House agents dispatched to recover stolen schemas, rogue artificers, or unauthorized use of the Cannith mark. Professional, persistent, well equipped. |

### House Tharashk

Bounty hunters, prospectors, and dragonshard traders. Part orc, part human, entirely pragmatic. They find things and people for a price.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Kalaash'arrna** (she/her) | Patron | Hitter | A Tharashk inquisitive who runs a finding service in Sharn. Hires freelancers for jobs the House won't officially take. Blunt, fair, and remembers every favor. |
| **Dol** (he/him) | Rival | Hitter | An orc bounty hunter with a Mark of Finding. Relentless. If he's been hired to find you, start running yesterday. Not cruel, just unstoppable. |
| **Tharashk Prospectors** (mixed) | Contact | Filler | A dragonshard survey team operating in Xen'drik or the Mournland border. They know the terrain, they need protection, and they've found something they shouldn't have. |

### Houses Phiarlan and Thuranni

The elven houses of shadow. Phiarlan runs entertainment and espionage. Thuranni split off during the Last War and runs assassination and counter-intelligence. They hate each other with the intimacy that only family can produce.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Salia Phiarlan** (she/her) | Contact / Patron | Hitter | A Phiarlan entertainer who runs a theater in Middle Menthis. The theater is a front for the Serpentine Table (Phiarlan's intelligence arm). Charming, dangerous, and always performing. |
| **Vael Thuranni** (he/him) | Rival | Boss | A Thuranni shadow operative. Sent to Sharn to establish a competing intelligence network. Cold, patient, and utterly convinced that Phiarlan's sentimentality makes them weak. |
| **The Whisper** (unknown) | Informant | Threat | An anonymous source who sells secrets from both houses. Nobody knows which house they belong to. Maybe neither. Their information is always accurate but never free. |

### The Emerald Claw / Blood of Vol

The Emerald Claw is the militant arm of the Blood of Vol, a religion that worships the divinity within the blood. Outlawed in most nations. Their goals range from genuine spiritual seeking to undead supremacy. Lady Illmarrow (Vol) pulls strings from the shadows.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Commander Malik Draven** (he/him) | Leader | Boss | A true believer. Former Karrnathi soldier who found purpose in the Blood of Vol after the war. Commands an Emerald Claw cell with military discipline. Thinks he's saving the world. |
| **Sera the Bone Mender** (she/her) | Wild Card | Hitter | A Vol necromancer who genuinely heals people using necromantic techniques. The lower wards love her. The Watch wants her arrested. She just wants to practice medicine. |
| **Skeledrone Squad** (none) | Muscle | Filler | Undead soldiers animated by Emerald Claw necromancers. Mindless, tireless, and unsettling. They follow orders literally, which sometimes creates darkly comic results. |
| **The Seeker** (she/her) | Informant | Threat | A young Vol acolyte who genuinely believes in the faith's message of inner divinity. Not violent. Not scheming. Just devout. Her sincerity makes her the most effective recruiter the Emerald Claw has. |

### The King's Citadel / Dark Lanterns

Breland's national intelligence service. The Citadel handles domestic security. The Dark Lanterns handle espionage and deniable operations. They answer to the Brelish crown, in theory.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Captain Talleon Haliar Tonan** (he/him) | Patron / Rival | Boss | A Dark Lanterns handler. Recruits assets, runs operations, and occasionally needs freelancers for jobs the Lanterns can't officially touch. Trustworthy within the scope of his mission. Outside that scope, everything is negotiable. |
| **Agent Nali** (she/her) | Contact | Hitter | A Citadel field agent working undercover in Lower Dura. Her cover is a bartender at a tavern in Callestan. She's good at her job, which means she's also genuinely good at bartending. |
| **Citadel Redcloaks** (mixed) | Enforcer | Filler | The Citadel's uniformed division. Better trained and better equipped than the Sharn Watch. When Redcloaks show up, the situation has been escalated. |

### The Aurum

A secret society of the wealthy and powerful. They believe gold is the only true power and work to ensure that remains true. Their members include nobles, house scions, and merchant princes from every nation.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Antus ir'Soldorak** (he/him) | Rival | Boss | A dwarf industrialist and Aurum concordian. Controls three smelting operations and two banks. Sees the PCs' community as a market to be captured, not a people to be helped. |
| **Mara Thornton** (she/her) | Contact | Hitter | A mid-level Aurum member who's started to question the organization's methods. Not ready to betray them, but willing to trade information if it serves her conscience. |
| **The Accountant** (he/him) | Enforcer | Hitter | The Aurum doesn't employ thugs. They employ financial instruments. The Accountant doesn't hurt people. He destroys their credit, calls their debts, and revokes their leases. The damage is worse and lasts longer. |

### Lord of Blades

A warforged revolutionary who believes organic life will never accept warforged as equals. Operates from the Mournland. Recruits warforged who've been mistreated, abandoned, or denied personhood. Equal parts liberator and extremist.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Hatchet** (she/her) | Enforcer | Hitter | A Lord of Blades lieutenant who operates outside the Mournland, recruiting warforged from Sharn's lower wards. Patient, persuasive, and willing to use violence only when recruitment fails. |
| **Crucible** (they/them) | Wild Card | Hitter | A warforged artificer who left the Lord of Blades because the methods went too far. Carries guilt about the operations they participated in. Wants to help warforged without hurting organics. |
| **Blade Scouts** (none) | Enforcer | Filler | Small teams of warforged operatives. They move through the Mournland like ghosts. Outside it, they're less subtle but no less dangerous. Armed with salvaged Cannith weaponry. |

### Independents

NPCs without strong faction ties. Community figures, freelancers, wild cards, and people who exist at the margins where factions overlap.

| NPC | Role | Tier | Concept |
|-----|------|------|---------|
| **Geth** (he/him) | Contact | Hitter | A shifter bouncer who works the door at a Clifftop tavern. Knows everyone who comes through. Doesn't volunteer information, but can be persuaded if you're honest about why you need it. |
| **Professor Maia Tessant** (she/her) | Patron | Threat | A Morgrave University archaeologist who funds expeditions with grant money and enthusiasm. Brilliant but naive about the dangers her research attracts. |
| **Rotgut** (it/its) | Informant | Threat | A warforged who lives in the Cogs and collects information the way others collect junk. Trades secrets for stories. Has no allegiance. Remembers everything. |
| **Lira Shol** (she/her) | Wild Card | Hitter | A changeling private inquisitive who works Lower Dura. Not affiliated with any house or faction. Takes cases the Watch won't touch and the Houses don't care about. Knows the PCs by reputation. Opinions vary. |
| **Father Dorn** (he/him) | Contact | Threat | A human priest of the Sovereign Host who runs a soup kitchen in Fallen. Genuinely kind. Connected to everyone in the neighborhood. Will ask for help eventually, and you won't be able to say no. |

---

## Implementation Notes

### Files Created
- `npcs.md`: New document with Jekyll front matter, organized by faction with a role/tier index at the top.

### Files Modified
- `index.md`: Add NPC Gallery to site navigation.
- `toolkit.md`: Add cross-reference in the "Designing Threats Around Characters" section pointing to the NPC Gallery for ready-made characters.

### NPC Count
- Boromar Clan: 4
- Daask: 4
- House Cannith: 4
- House Tharashk: 3
- Houses Phiarlan/Thuranni: 3
- Emerald Claw / Blood of Vol: 4
- King's Citadel / Dark Lanterns: 3
- The Aurum: 3
- Lord of Blades: 3
- Independents: 5

**Total: 36 NPCs**

### Document Structure
The document opens with a brief intro explaining how to use the gallery, followed by a quick-reference index table listing all NPCs with their faction, role, and tier. Then each faction gets a section with a 2-3 sentence faction overview and the full NPC entries.
