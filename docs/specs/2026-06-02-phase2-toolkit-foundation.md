# Phase 2: Toolkit Document Foundation

## Overview

Phase 2 creates a new `toolkit.md` document and adds inline material to the existing guides. The toolkit contains interconnected systems for running Eberron campaigns. The inline additions bring key Book of Hanz principles into the players and GM guides where they're needed at the table.

This is the second of three phases:
- **Phase 1** (complete): Inline reference material, character creation redesign, consequential magic, signature spells
- **Phase 2** (this spec): Toolkit document + Book of Hanz inline additions
- **Phase 3**: Toolkit content (case generator, NPC gallery, exploration rules)

### Sources

- **Umdaar** (Rebel Broadcast Edition, EHP0077, 2026). Game Worksheet (p.19-24), Continent-Based Campaign (p.234-254).
- **Book of Hanz** (collected Fate advice). Intent and Task, Fate's Big Question, Conflict as Bidding War, Branches Not Gates, Questions and Decisions, Calibration, Monster of the Week, GM Workflow.
- **Fate of Eberron GM Guide** (existing). Compels in Eberron section, Campaign Frameworks, Factions as Characters.

### Document Structure

**Toolkit (`toolkit.md`):**
```
  1. The GM Workflow (campaign loop from pitch to session end)
  2. Eberron Story Elements (Session Zero ingredient menu)
  3. The Region System (sites, communities, networks, status, power)
  4. Downtime (start/end of session, GM actions)
  5. Questions and Decisions (scene and campaign structure)
  6. Compels and Drama Escalation (including Fate's Big Question, MotW as character study, calibration)
```

**Inline additions to existing guides:**
- `players-guide.md`: Intent and Task (near Four Actions), Conflict as Bidding War (in Conflicts section)
- `gm-guide.md`: Branches Not Gates / Interesting Failure (near difficulty section)

GM Workflow opens the toolkit because it frames everything else: when do you use Story Elements (Session Zero), when do you build the region (post Session Zero), when does downtime happen (between sessions), and when do compels fire (during play). The workflow is the skeleton; the other sections are the organs.

---

## Inline Addition A: Intent and Task

**Location:** `players-guide.md`, added near the Four Actions section in "Playing the Game."

**Pattern source:** Book of Hanz, "Intent and Task."

Before you can determine which of the four actions to use, you need two things:

1. **Intent**: What are you trying to accomplish? What does success look like?
2. **Task**: How are you going about it? What does your character actually do?

Without both, you can't pick the right action. The Hulk throwing someone over the horizon could be an Attack (trying to take them out of the fight), Create Advantage (knocking them into a bad position), or Overcome (clearing a path). Same task, different intent, different action.

When a player says what they want to do, ask: "What does success look like for you?" This surfaces the intent, which tells you how to resolve it.

**Eberron examples:**
- "I pick the lock." Intent matters: are you trying to get through the door (Overcome), or disable the security system so the whole team can move freely (Create Advantage)?
- "I cast a spell at them." Are you trying to hurt them (Attack), scare them (Attack with Provoke), slow them down (Create Advantage), or get past them (Overcome)?
- "I talk to the guard." Are you getting information (Overcome), building a relationship for later (Create Advantage), or convincing them to abandon their post (Attack with Rapport)?

---

## Inline Addition B: Conflict as Bidding War

**Location:** `players-guide.md`, added to or replacing part of the Conflicts subsection in "Playing the Game."

**Pattern source:** Book of Hanz, "Conflict with Named NPCs."

A conflict with a named NPC isn't really about tactics. It's a test of commitment. A bidding war. A game of chicken.

The escalation goes like this:

1. **Skills only.** Both sides roll and see what happens. This costs nothing.
2. **Invoke aspects.** Spend fate points for +2 or reroll. Now it's costing you resources.
3. **Take consequences.** Accept lasting harm to stay in the fight. Now it's costing you future capability.
4. **Concede or get taken out.** Pay the final price, or walk away on your terms.

At every step, both sides are asking: "How much do I want this?" The answer drives the drama. A conflict where neither side really cares is boring. A conflict where both sides care deeply and are willing to bleed for it is electric.

The concession mechanic makes this explicit. At any point before dice are rolled, you can accept a loss and gain fate points. The longer you stay in, the more fate points the concession is worth, but the more you've already paid.

---

## Inline Addition C: Branches Not Gates / Interesting Failure

**Location:** `gm-guide.md`, new subsection near the difficulty section (after "Put a Scene On It").

**Pattern source:** Book of Hanz, "Failure" and general Fate principles.

### Branches, Not Gates

Every roll in Fate should be a fork in the road, not a gate. A gate means: succeed and the story continues, fail and the story stalls. A branch means: succeed and the story goes this way, fail and the story goes that way. Both directions are interesting.

If failure means "nothing happens," don't roll. Either let the characters succeed, or frame the situation so that failure changes things.

**The locked door test:** A locked door in a traditional game is a gate. Pick the lock or you don't get through. In Fate, if you can't think of an interesting failure for picking the lock, just let them through. If you can (the lock breaks and the noise attracts guards, the mechanism triggers an alarm, you get through but it took so long that the target has fled), now you have a branch. Roll for it.

### Interesting Failure

When a roll fails, the situation should change. The story moves forward, just not in the direction the characters wanted. Options:

- **Success at a major cost.** You get what you wanted, but something else goes badly wrong.
- **New complication.** The attempt itself creates a new problem that demands attention.
- **Unwanted attention.** Someone or something noticed what you're doing.
- **Shifted circumstances.** The window of opportunity changes. What was possible a moment ago no longer is, but something else opens up.

"That doesn't work" is never the answer. Keep things moving.

**Eberron example:** The party tries to break into a Cannith vault. The Burglary roll fails. Instead of "the lock doesn't budge," try: "You crack the outer seal, but as the ward discharges, House Cannith's security network logs the intrusion. You have maybe ten minutes before a response team arrives. The vault is open, but the clock is ticking."

---

## 1. The GM Workflow

**Location:** `toolkit.md`, Section 1. This frames the entire toolkit.

**Pattern source:** Book of Hanz, "How I GM Fate Core."

The GM Workflow is the campaign loop. It tells you when to use each of the toolkit's systems, and what to do between sessions. It's the "how to actually run this" guide that ties everything together.

### The Loop

| Phase | What Happens | Toolkit System Used |
|-------|-------------|-------------------|
| **The Pitch** | Propose a game concept. Gauge interest. | None yet. |
| **Session Zero** | Build Story Elements (inspirations, ingredients, campaign aspects). Build the Charter. Build the Region. Create characters. | Story Elements, Charter (players guide), Region System |
| **Post Session Zero** | Reconcile player input with your ideas. Create NPCs based on character aspects and charter antagonists. Sketch the first arc. | Arc Generation (below) |
| **Arc Generation** | Who wants what? Who opposes them? Why do the PCs care? What happens if nobody intervenes? | Questions and Decisions |
| **Session Prep** | What changed since last session? What are the NPCs/factions doing? What hand grenades can you lob? Look at PC aspects for compels. | Downtime (GM actions), Compels |
| **Running the Session** | Start of session check in. Frame scenes. Resolve scenes. Lob hand grenades if momentum stalls. End with downtime. | Downtime, Compels, Region System |
| **Ending the Session** | Milestones. Downtime actions. Feedback. What's next? | Downtime, Advancement (players guide) |
| **Between Sessions** | Update the region map. Advance faction agendas. Track countdowns. Prep the next session. | Region System, Downtime (GM actions) |

### Arc Generation

An arc is a multi-session storyline driven by NPC goals intersecting with PC concerns. To generate an arc, answer these questions:

1. **Why is this relevant to the characters?** Tie it to character aspects. If you can't, find a different arc.
2. **Who is involved?** Name the NPCs and factions.
3. **What are they trying to achieve?** Define their goal.
4. **Who opposes them?** Not just the PCs. Other factions, other NPCs.
5. **What happens if nobody intervenes?** This is your countdown. It gives the situation urgency.

The best arcs come from character creation. Player backstories aren't backstories in Fate. They're the story. The Phase Trio (or in our case, the five aspects + charter) generates NPCs, factions, threats, and relationships that the campaign should revolve around.

### Session Prep

Before each session:

1. **What changed?** How did last session's events affect the world? Update the region map if needed.
2. **What are the NPCs doing?** Every active NPC has a goal. What's their next move?
3. **Look at character sheets.** Which aspects are ripe for compels? Which consequences are still in play?
4. **Prep hand grenades.** A hand grenade is an event that demands a PC response without dictating what that response should be. An NPC shows up asking for help. A secret is revealed. A faction makes a move. Tie hand grenades to PC aspects whenever possible.
5. **Don't predict.** The more you predict what will happen, the more you'll try to make it happen. Go in knowing the situation, not the outcome.

### Running the Session

1. **Start of session check in.** Ask players what their characters have been up to.
2. **Frame scenes.** Drive toward interesting decisions. Ask: "What is this scene about? What's at stake? What could go wrong?"
3. **"What do you do?"** Let the players drive. If they stall, lob a hand grenade.
4. **Resolve scenes.** Use the right pacing mechanism (simple roll, challenge, contest, conflict). After resolution, recap what changed and let the players react.
5. **End with downtime.** Each PC takes a downtime action. You take GM actions.
6. **Solicit feedback.** What worked? What didn't? What do players want more of?

### The Most Important Rule

Don't plan what will happen. Plan the situation: who wants what, who's in the way, what's at stake. Then play to find out what the characters do about it.

---

## 2. Eberron Story Elements

**Location:** `toolkit.md`, Section 1.

**Pattern source:** Umdaar Game Worksheet (p.19-24), specifically the Inspirations, Elements (Keepers/Deal Breakers/Conditional), and World Aspects flow.

### How It Works

During Session Zero, after choosing a Charter framework but before building the region or individual characters, the group fills out a Story Elements worksheet. Three steps.

### Step 1: Inspirations

The group brainstorms media, tropes, and themes that excite them. No bad suggestions. Write them all down.

> Example: *Blade Runner, Legend of Korra, Leverage, political intrigue, ancient mysteries, found family*

### Step 2: Story Ingredients

Go through the Eberron ingredient categories and sort each into Keepers (we want this), Deal Breakers (avoid this), or Conditional (fine under certain conditions, specify what).

| Category | Ingredients to Discuss |
|----------|----------------------|
| **Tone** | Pulp adventure, noir mystery, horror, political drama, heist/caper, comedy, romance, tragedy |
| **Scope** | Neighborhood, city, national, continental, planar |
| **The Last War** | Background texture, active wound, resuming conflict, veteran trauma, war crimes, refugees |
| **Factions** | Which Dragonmarked Houses are active? Which criminal organizations? Which governments? Which secret powers? |
| **The Draconic Prophecy** | Not present, background mystery, central plot driver |
| **The Planes** | Manifest zones as color, planar threats, planar travel, specific planes (Thelanis, Dal Quor, Xoriat, Shavarath) |
| **Horror** | Daelkyr and aberrations, Vol and undead, the Mournland, Khyber, body horror, psychological horror |
| **Identity and Prejudice** | Warforged personhood, changeling distrust, shifter discrimination, goblinoid marginalization |
| **Magic and Technology** | Artifice and invention, dragonshards, creation forges, eldritch machines |

**Keepers** are elements the group wants to see. No one objects to their inclusion.

**Deal Breakers** are elements the group wants to avoid entirely. If one player flags it as a deal breaker, it's off the table for everyone.

**Conditional** elements are allowed under specific conditions the group agrees on. For example: "Horror is fine as long as it's cosmic/existential, not body horror" or "The Last War can be background for NPCs but we don't want flashback scenes."

This is an ideal time to introduce or review safety tools (X-Card, Lines and Veils).

### Step 3: Campaign Aspects

Distill the keepers and inspirations into 2-4 world aspects that apply to every session. These are always true, always invokable, always compellable.

> Examples: *The Treaty of Thronehold Is Held Together by Lies*, *Nobody Trusts a Changeling*, *The Mourning Could Happen Again*, *Sharn Runs on Favors and Debts*

### Between Sessions

Revisit the Story Elements worksheet before each session (adapted from Umdaar p.22-24):

- **Review the elements.** Are the keepers, deal breakers, and conditionals still working? Is there anything to change just for this session?
- **Summarize themes.** Give the players an overview of the themes planned for this session. Do they have feedback or concerns?
- **Monitor the action.** During the game, watch for signs of discomfort and check in when things get intense.

---

## 3. The Region System

**Location:** `toolkit.md`, Section 2.

**Pattern source:** Umdaar Continent-Based Campaign (p.234-254).

### What Is a Region?

A region is a collection of 8-15 sites arranged by proximity to the party's home base. Each site is a community with aspects, status, skills, and a power rating. Sites can be part of your network, on the periphery, neutral, or hostile. The region evolves through play as your network grows, statuses change, and new sites are discovered.

### Terminology

| Term | Meaning |
|------|---------|
| **Site** | A location on your region map. Could be a neighborhood, city, ruin, fortress, or planar locale. |
| **Community** | Most sites are communities: groups of people with shared identity, values, and problems. |
| **Network** | Sites allied with or connected to the party. Network sites share resources and information. |
| **Periphery** | Sites bordering your network. Not allied, but accessible. Potential allies, threats, or sources of adventure. |
| **Home Base** | The core site. Your Charter's headquarters is here. You can always go back. |
| **Status** | A site's current situation aspect, positive or negative. |
| **Power** | A site's size and influence, rated on the Fate ladder. |

### Building a Region

Build the region during Session Zero or across the first few sessions. You don't need every site filled in before play begins. Start with 4-6 and discover the rest through adventures.

1. **Place the home base.** This is the core site from your Charter. It's always part of your network.
2. **Place 2-3 periphery sites** bordering the home base. These are the places you interact with most. Fill in names, high concepts, and at least one issue.
3. **Sketch the rest loosely.** Mark 5-8 more sites with just a type (friendly district, hostile territory, unexplored ruin, contested zone) and fill in details as the campaign demands.
4. **Arrange by proximity.** Not physical distance but difficulty to reach or interact with. The closer to the home base, the easier to access. The further out, the more dangerous or politically complicated.

### Site Stats

Each site has the following:

| Component | What It Is |
|-----------|-----------|
| **Name and High Concept** | What is this place? One phrase capturing its identity. |
| **Values** | What does the community believe or prioritize? |
| **Trouble** | The site's internal flaw or vulnerability. Often stems from a tension with its own values. |
| **Status** | Current situation aspect. Positive, negative, or neutral. Negative statuses come with a free invoke for the GM and drive adventures. |
| **Additional Aspects** | 1-3 miscellaneous aspects: strengths, weaknesses, landmarks, notable features. |
| **Skills** | Binary: the site has it or doesn't. Represents what the community excels at. NPCs from here likely have that skill at Average (+1) or better. |
| **Power** | Size and influence on the Fate ladder. |

### Power Scale

Power is relative to your campaign's scope.

| Rating | Agency (Sharn) | Expedition (Xen'drik) | Cell (Nations) | Salvage (Mournland) | House Ops (Cities) |
|--------|---------------|----------------------|----------------|--------------------|--------------------|
| Mediocre (+0) | A single establishment | A campsite | A safe house | An outpost | A satellite office |
| Average (+1) | A city block or small district | A small settlement | A village cell network | A border hamlet | A branch office |
| Fair (+2) | A ward with its own identity | A tribal territory | A town with sympathizers | A fortified border town | A regional enclave |
| Good (+3) | A major district or tower cluster | Stormreach itself | A city with underground networks | A major staging area | A House headquarters |
| Great (+4) | All of Sharn (endgame scale) | A Xen'drik sub-region | A national intelligence apparatus | The Mournland border zone | The House itself |

### Site Skills

A site's skills use the same 18 skills as PCs, but they're binary: the site has the skill or it doesn't. If a community has Fight, it has soldiers or trained fighters. If it has Lore, it has scholars, libraries, or magical knowledge. If it has Burglary, it has a thriving criminal element.

When a site needs to make a roll (rare, but it happens during site vs. site interactions), its signature skill is equal to its Power + 1, and all other skills equal its Power.

### Site vs. Site Interactions

Sites can act against each other between sessions. A site with Stealth can spy. A site with Fight can raid. A site with Rapport can negotiate. A site with Resources can embargo.

When this happens, both sites roll. Signature skill equals Power + 1, other skills equal Power. The bigger site has the advantage.

The winner can:
- Place a new status aspect on the loser
- Remove a negative status from themselves
- Change the nature of an existing status to something worse (or better)
- Add a second negative status

The loser's population suffers the consequences. Alert the players: these are people in their network or periphery.

Resist the urge to turn this into a board game. Site interactions create world aspects and adventure hooks, not strategic optimization. "Make drama, not war" (Umdaar p.242).

### Network Mechanics

Sites in your network share resources and information. During downtime, you can interact with any networked site. The benefits:

- You can invoke a networked site's aspects during downtime actions for free.
- NPCs from networked sites are generally willing to help (though they may have conditions).
- Information flows: if something happens at a networked site, you hear about it.

### Forging Alliances (Expanding Your Network)

Bringing a periphery site into your network is always an adventure, never just a roll. What needs to happen varies:

- The site's leadership wants proof you're trustworthy. Solve their problem first.
- The site is under the influence of a hostile faction. Free them before they can ally with you.
- The site is willing, but the journey there is dangerous. Getting there is the adventure.

Alliances always involve compromise. The new site may:
- Change one of your network's aspects to reflect their influence
- Demand ongoing favors or resources
- Create new complications (their enemies are now your enemies)
- Refuse to join unconditionally (become neutral instead)

Each new allied site gains a **Friendly Face**: an NPC who acts as liaison between the party and the community. The players can pick an existing NPC or create a new one.

### Neutral Sites

Not every site will join your network. Some prefer neutrality. Possible reasons:
- Cultural or religious pacifism
- Strategic fence-sitting (profiting from both sides)
- Distrust of your network based on past actions
- Mysterious motives the players haven't uncovered yet

Neutral sites create interesting drama: the value of sovereignty, whether neutrality is cowardice or wisdom, the temptation to force an alliance.

### Framework Examples

Include one fully worked example per framework, each showing 5-6 sites with full stat blocks (name, high concept, values, trouble, status, 1-2 additional aspects, skills, power). These must be complete and ready to use at the table, not abbreviated:

**Agency example:** A Sharn ward with Lower Dura as home base, surrounding neighborhoods (Callestan, Fallen, the Stores, Malleon's Gate, Precarious), each with distinct identity, values, trouble, and status.

**Expedition example:** A Xen'drik coastal stretch with a Stormreach dockside camp as home base, surrounding sites (a drow trading post, a sahuagin reef, a giant ruin, an unexplored jungle interior, a Morgrave competitor's camp).

**Cell example:** A Karrnathi region with a hidden village as home base, surrounding sites (a provincial capital under Master control, a sympathetic border town, an old military fortress, a monastery with divided loyalties, a smuggler's crossing).

**Salvage Crew example:** The Mournland border with a fortified camp as home base, surrounding sites (Vathirond border town, a dead-gray mist entry point, an intact Cyran village frozen in time, a Lord of Blades outpost, a living spell hunting ground).

**House Operatives example:** Multiple cities with a House Cannith enclave in Sharn as home base, surrounding sites (Cannith South HQ in Breland, a satellite forge in Karrnath, a Tharashk rival operation, a rogue Cannith heir's workshop, a Kundarak vault holding contested patents).

---

## 4. Downtime

**Location:** `toolkit.md`, Section 3.

**Pattern source:** Umdaar Interacting with Your Continent (p.243-251).

### The Rhythm of Play

Play alternates between adventures and downtime. Adventures are where the action happens. Downtime is where the region comes alive: players interact with sites, the GM advances faction agendas, and the seeds of the next adventure are planted.

### Start of Session: What Are You Up To?

Before the adventure begins, go around the table. Each player describes what their character has been doing since last session. Keep it brief.

The GM can use this to introduce hooks, compel aspects, or set up complications. A player who says "I've been drinking at the Broken Anvil" might learn a rumor. A player who says "I've been tailing that Boromar courier" might have attracted attention.

### End of Session: Downtime Actions

After an adventure wraps, each PC takes one downtime action. This is a brief vignette with the GM. The player picks a site or NPC to interact with.

| Action | What It Does | Example |
|--------|-------------|---------|
| **Overcome** | Fix something harmful. Heal, repair, mend a relationship, clear a negative status. | Remove *Running Low on Supplies* from a border town. |
| **Create Advantage** | Discover or build something useful. Scout a location, forge a contact, write propaganda, acquire gear. | Research a peripheral site before visiting it. |
| **Attack** | Convince a site to act against a hostile force. Risky: the target may retaliate. | Persuade the Clifftop Adventurers' Guild to raid a Daask warehouse. |
| **Compel** | GM compels a player to spend downtime dealing with their aspects. Costs a fate point (which the player keeps for next session). | *Debts to House Cannith* means a Cannith agent shows up demanding a favor. |

### Downtime Rules

- Players pick one site or NPC to interact with. If it's a networked site or friendly NPC, they can invoke one of that site's aspects for free.
- The GM can invoke site aspects against the player to increase difficulty.
- Downtime can cover days or weeks of in-game time. Results can be more generous than mid-adventure rolls.
- **Shopping and supplies** are handled narratively. If it's reasonable, you have it. If it's unusual, spend a downtime action.
- **Personal development**: A player can use their downtime action as a minor milestone, adjusting skills or aspects early. Tie it to a specific site (training at a site known for Fight, studying at a library site with Lore).
- **Relax**: A player who does nothing productive clears all remaining mild consequences. Good option for absent players.

### GM Actions Between Sessions

While players take their downtime vignettes, the GM also advances the world:

| GM Action | What It Does |
|-----------|-------------|
| **Foreshadow** | Plant seeds for the next adventure or the larger campaign arc. A strange symbol appears. A contact goes missing. Rumors spread. |
| **Counter-Action** | If players acted against a faction, that faction acts back. Scouts are sent. Prices go up. An ally is threatened. |
| **Apply Pressure** | Change a site's status for the worse. Not enough to break things, but enough to demand attention soon. |
| **Track Countdowns** | Advance any active countdowns by one step. The Emerald Claw ritual is one week closer. The Boromar deadline approaches. |

### Solving Bad Statuses

Negative status aspects on sites are adventure hooks. They can be compelled, invoked against the players, and they make the community's life worse.

- **Downtime actions can mitigate** (reduce severity, buy time) but usually can't fully resolve a bad status.
- **Adventures resolve bad statuses.** Fixing a bad status is a story, not a roll.
- **At major milestones**, the group may improve a site's status if they can justify how their actions made things better.
- **Ignoring a bad status** makes it worse. If a site's status degrades too far, it may leave the network, fall to a hostile faction, or collapse entirely.

---

## 5. Questions and Decisions

**Location:** `toolkit.md`, Section 5.

**Pattern source:** Book of Hanz, "Questions & Decisions."

### Every Campaign Has a Big Question

Before the first session, the GM should be able to state the campaign's central question. This is what the whole story is about. Player decisions will answer it.

> *Can the Treaty of Thronehold hold, or will the Last War resume?*
> *Who really caused the Mourning, and can it be stopped from happening again?*
> *Can a band of outcasts protect Lower Dura from forces bigger than all of them?*

The Big Question doesn't need to be answered quickly. It might take the entire campaign. But it should be present from the start, giving every session a sense of direction.

### Every Arc Has a Question

Each arc (3-5 sessions) answers a smaller question that feeds into the Big Question.

> *Can we stop the Emerald Claw from completing the ritual before the solstice?*
> *Will the Boromar Clan or Daask control Callestan by the end of the month?*
> *Can we find the missing heir before House Cannith declares them dead?*

### Every Scene Has a Question

If you can't name the question a scene is answering, skip the scene. A scene without a question is exposition, and exposition should be brief.

> *Will the party convince the Watch captain to share the autopsy report?*
> *Can they cross the Mournland border before the living spell catches them?*
> *Does the changeling contact tell the truth, or does she have her own agenda?*

### Player Decisions Answer the Questions

Questions set the stage. Decisions answer them. If the players are going from point A to B to C, defeating challenges along the way, they're not making decisions. They're following a path.

The GM's job is to present situations where the answer isn't obvious, where the players' values and priorities determine what happens next. This ties directly into compels: compels are the mechanism that forces decisions by making characters choose between things they care about.

### If the Players Aren't Making Decisions, Something Is Wrong

Check for:
- **Gates instead of branches.** Are failures stopping progress instead of changing direction?
- **No stakes.** Do the players care about the outcome? If not, tie it to their aspects.
- **Predetermined outcomes.** If you know what's going to happen, the players aren't driving. Let go.
- **Missing questions.** If the scene doesn't have a question, it doesn't need to exist.

---

## 6. Compels and Drama Escalation

**Location:** `toolkit.md`, Section 6.

**Pattern source:** Umdaar GM chapter on compels (p.122-127), Book of Hanz ("Fate's Big Question," "In Defense of Monster of the Week," "Calibration"), Fate of Eberron existing compel categories.

### Fate's Big Question: "How Much Do You Want This?"

A Fate character can do anything, but they can't do everything.

Given enough fate points and enough willingness to take consequences, a character can accomplish almost any reasonable goal. Sneak into the vault? You will. Defeat the lieutenant? You can. Convince the council? Possible.

But every victory costs something. Fate points spent here aren't available there. Consequences taken now limit you later. The concession you avoided means the fate points you didn't earn.

This is Fate's Big Question: not "can you do this?" but "what are you willing to give up to do it?" Every scene should drive toward this question. Every compel makes it sharper. The GM's real job isn't designing encounters. It's pricing the things the characters want.

### The Compel Rhythm

Every session should have a rhythm of compels that builds tension toward the climactic scene.

| Session Phase | Compel Style | Purpose |
|---------------|-------------|---------|
| **Opening / Downtime** | Soft compels from character aspects | Establish personal stakes, set the tone, remind players who their characters are |
| **Investigation / Exploration** | Situational compels from the environment and factions | Complicate the task, introduce new threads, force choices |
| **Rising Action** | Escalating compels that stack | Force characters into positions where their aspects conflict with each other or with the mission |
| **Climax** | Hard compels with real consequences | The moment where accepting the compel changes the story's direction |

### Compel Sources

**Character Compels** (from PC aspects):
- **Early campaign**: Compels create inconvenience. *Cyran Refugee* means someone recognizes you and wants to talk about the old days when you're in a hurry.
- **Mid campaign**: Compels create dilemmas. *Cyran Refugee* means a Cyran community asks you to choose between their needs and the mission.
- **Late campaign**: Compels force defining choices. *Cyran Refugee* means the chance to rebuild Cyre is real, but it means abandoning everything you've built here.

**Faction Compels** (from the region map):
- Factions act between sessions. Their actions create compellable situations.
- When a faction's agenda intersects with a PC's aspects, that's a compel waiting to happen.
- Track which factions have been active recently. Rotate pressure so no single faction dominates.

**Site Compels** (from the region's status aspects):
- Negative statuses on network sites are standing compel opportunities.
- *Running Low on Supplies* at a border town can compel a PC with *Nobody Left Behind* to divert from the mission.
- Solving a site's status problem earns the community's gratitude. Ignoring it earns resentment (change a site aspect to reflect this).

**Relationship Compels** (from PC relationship aspects):
- The most powerful compels come from relationships between PCs.
- When two PCs have a relationship aspect, the GM can compel it to put them at odds.
- *She Saved My Life and I Still Don't Know Why* can be compelled when the truth about why would change how you feel about her.

### Drama Escalation Across a Campaign

| Campaign Phase | Compel Intensity | What Changes |
|----------------|-----------------|-------------|
| **Early sessions** | 1-2 compels per session, mostly soft | Players learn what their aspects mean in play. The GM learns what players respond to. |
| **Mid campaign** | 2-3 compels per session, mixing soft and hard | Faction pressure increases. Sites develop problems. Relationship tensions surface. |
| **Late campaign** | 3-4 compels per session, mostly hard | Every compel forces a meaningful choice. Accepting means sacrificing something. Refusing means spending precious fate points before the final confrontation. |

### Consequences as Drama Fuel

Consequences are aspects, which means they're compellable. A PC carrying *Mournland Corruption Spreading* isn't just mechanically impaired. They're a walking story hook. The GM can compel it to create scenes: the corruption reacts to Demiurge tech, other characters are afraid of you, a healer refuses to treat you unless you do something for them.

Magical consequences from the consequential magic system are especially rich compel targets because they represent ongoing magical effects with narrative weight.

### The Fate Point Economy as Drama Pacing

Players who accept compels stockpile fate points. Players who refuse them deplete their reserves. By the climax, the group's fate point situation tells you how much narrative agency they have left.

A group flush with points can power through the final challenge. A group that's been refusing compels all session is now vulnerable. This is working as intended. Don't try to balance it. Let the economy create tension naturally.

### Designing Threats Around Characters, Not the Other Way Around

When designing a case, threat, or antagonist, start with PC aspects, not the threat concept.

A Daask enforcer isn't interesting because they're tough. They're interesting because one PC used to run with Daask, and another PC lost family to them. A haunted Cannith workshop isn't interesting because it's spooky. It's interesting because the artificer's mentor died there, and the priest's faith is tested by what they find.

This is the "Monster of the Week" principle from the Book of Hanz: episodic threats exist to highlight, pressure, or complicate a character. The first season of Buffy didn't use monster-of-the-week episodes as filler. The witch episode was about Buffy wanting a normal life. The mantis episode was about Xander's desperation in love. The monster was the vehicle, not the point.

**The process:**
1. Look at the PCs' aspects. Which ones haven't been tested recently?
2. Design a situation that puts pressure on that aspect.
3. Build the threat, antagonist, or complication around that pressure.
4. The threat doesn't need to be connected to the campaign's Big Question (though it's great if it is). It needs to be connected to a character.

### Calibration: Same Mechanics, Different Feel

The same mechanical result means different things depending on your game's tone. A 3 stress hit, narratively, is completely different in a pulp game versus a noir game versus a horror game.

| Tone | 3 Stress Hit | Mild Consequence | Severe Consequence |
|------|-------------|-----------------|-------------------|
| **Pulp** | A nasty cut across the chest. Blood drips but you keep fighting. | *Scratched Up* | *Deep Gash to the Leg* |
| **Noir** | Knocked off balance into a wall. Stars in your eyes but nothing broken. | *Seeing Stars* | *Something's Broken Inside* |
| **Horror** | A moment of pure, freezing terror. Your body screams to run. | *Shaking Hands* | *I Can Still Hear It Breathing* |

Use the Story Elements to determine your tone. Once you know the tone, you know how to narrate mechanical results. The dice tell you the constraints. You tell the story within those constraints.

This applies to consequences especially. A moderate consequence doesn't have to be a physical injury. It's whatever lasting impact fits the tone: a wound, a fear, a broken relationship, a compromised cover, a debt called in.

---

## Implementation Notes

### Files Created
- `toolkit.md`: New document with six sections plus the framework examples. Gets a Jekyll front matter block matching the existing guide format (layout: guide, title, description).

### Files Modified
- `players-guide.md`: Inline Addition A (Intent and Task, near Four Actions) and Inline Addition B (Conflict as Bidding War, in Conflicts section).
- `gm-guide.md`: Inline Addition C (Branches Not Gates / Interesting Failure, near difficulty section). Cross-reference to toolkit.md in Campaign Frameworks and Compels sections.
- `index.md`: Add toolkit.md to the site navigation.

### Cross-References
- The GM Workflow (toolkit Section 1) references all other toolkit sections by name, telling GMs when to use each system.
- The Charter system (in `players-guide.md`) references the Region System for building the map around the charter's territory and headquarters.
- The Region System references the Charter components (home base = charter HQ, territory = charter territory).
- The Questions and Decisions section connects to the Compels section (compels force decisions) and the future case generator (Phase 3).
- The Compels section references the existing GM guide compel examples but expands them with Fate's Big Question, escalation framework, region-based compels, MotW character study, and calibration.
- The Downtime section references the Region System (downtime actions interact with sites) and the Advancement section in the players guide (downtime can grant early milestones).

### Compatibility
- All systems use standard Fate mechanics. No new subsystems.
- The Region System is compatible with all five Charter frameworks from Phase 1.
- Downtime actions use the standard four actions (Overcome, Create Advantage, Attack, Defend) applied to sites.
- The Compels section extends (does not replace) the existing GM guide compel categories.
- The inline additions to players-guide.md and gm-guide.md are additions, not replacements. They add new subsections without modifying existing content.
