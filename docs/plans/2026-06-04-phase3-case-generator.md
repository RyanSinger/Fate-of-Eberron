# Phase 3: Case Generator Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a case/adventure generator to the GM Toolkit for creating Eberron adventures procedurally.

**Architecture:** One large section appended to `toolkit.md`, broken into three implementation tasks: the case type table and first five case types, the remaining five case types, and the complications/connections/adventure aspects/region map integration. The spec is at `docs/specs/2026-06-04-phase3-case-generator.md`.

**Tech Stack:** Markdown, Jekyll.

**Writing style:** Same as existing toolkit. Short sentences. Active voice. No em dashes. No AI writing tells. Contractions fine. Eberron specific throughout.

---

## File Map

| File | What Changes |
|------|-------------|
| `toolkit.md` | Tasks 1, 2, 3 (append case generator as new section) |

---

### Task 1: Case Generator Intro + First Five Case Types

**Files:**
- Modify: `toolkit.md` (append after line 803)

- [ ] **Step 1: Append the section header, intro, case type table, and How to Use**

After the last line of the Calibration section, add a `---` divider then:

```markdown
## The Case Generator

A procedural system for creating Eberron adventures. Roll or choose from the tables below during session prep or on the fly. Use results as written, as inspiration, or combine multiple rolls into something new.

### How to Use

1. **Case Type**: Roll 2dF on the case type table. This is the shape of the job.
2. **Premise**: Roll 2dF within that case type. This is the specific situation.
3. **Complication**: Roll 1dF twice on the complication table. This is what makes it harder than it looks.
4. **Connection**: Choose (or roll) from the connection table. This is why the PCs care.

Not every case needs all four layers. A simple one-shot might just need a type and a premise. A campaign centerpiece might use all four plus a general adventure aspect.

### Case Type Table

| 2dF | Minus | Blank | Plus |
|-----|-------|-------|------|
| **Minus** | Investigate | Protect | Retrieve |
| **Blank** | Infiltrate | GM's Choice | Expose |
| **Plus** | Negotiate | Escape | Thwart |

Roll +/+ twice for **Deliver**, the tenth type for when you need a road trip.

**GM's Choice:** Pick the type that fits, combine two, or roll again.
```

- [ ] **Step 2: Append the Investigate case type**

Write the full Investigate section from the spec: premise table (5 entries), themes, adventure aspects, and 4 twists. The complete content is in the spec under "### Investigate".

- [ ] **Step 3: Append the Protect case type**

Write the full Protect section from the spec: premise table (5 entries), themes, adventure aspects, and 4 twists. The complete content is in the spec under "### Protect".

- [ ] **Step 4: Append the Retrieve case type**

Write the full Retrieve section from the spec: premise table (5 entries), themes, adventure aspects, and 4 twists. The complete content is in the spec under "### Retrieve".

- [ ] **Step 5: Append the Infiltrate case type**

Write the full Infiltrate section from the spec: premise table (5 entries), themes, adventure aspects, and 4 twists. The complete content is in the spec under "### Infiltrate".

- [ ] **Step 6: Append the Expose case type**

Write the full Expose section from the spec: premise table (5 entries), themes, adventure aspects, and 4 twists. The complete content is in the spec under "### Expose".

- [ ] **Step 7: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 8: Commit**

```bash
git add toolkit.md
git commit -m "feat: add case generator with first five case types (Investigate, Protect, Retrieve, Infiltrate, Expose)"
```

---

### Task 2: Remaining Five Case Types

**Files:**
- Modify: `toolkit.md` (append after the Expose section)

- [ ] **Step 1: Append the Negotiate case type**

Write the full Negotiate section from the spec: premise table (5 entries), themes, adventure aspects, and 4 twists.

- [ ] **Step 2: Append the Escape case type**

Write the full Escape section from the spec: premise table (5 entries), themes, adventure aspects, and 4 twists.

- [ ] **Step 3: Append the Thwart case type**

Write the full Thwart section from the spec: premise table (5 entries), themes, adventure aspects, and 4 twists.

- [ ] **Step 4: Append the Deliver case type**

Write the full Deliver section from the spec: premise table (5 entries), themes, adventure aspects, and 4 twists.

- [ ] **Step 5: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 6: Commit**

```bash
git add toolkit.md
git commit -m "feat: add remaining case types (Negotiate, Escape, Thwart, Deliver)"
```

---

### Task 3: Complications, Connections, Adventure Aspects, and Region Map Integration

**Files:**
- Modify: `toolkit.md` (append after the Deliver section)

- [ ] **Step 1: Append the Complications section**

Add `---` divider, then write `### Complications` with the intro paragraph ("After rolling a case type and premise, roll or choose a complication...") and the 9-entry complication table using the 1dF x 1dF rolling mechanic. The complete content is in the spec under "## Complications". The table has 9 rows (from -,- through +,+) with the last entry being "Roll twice."

- [ ] **Step 2: Append the Connections section**

Write `### Connections` with the intro paragraph ("The last layer ties the case to the PCs specifically...") and the 6-entry connection type table. The complete content is in the spec under "## Connections".

- [ ] **Step 3: Append the General Adventure Aspects section**

Write `### General Adventure Aspects` with the intro paragraph, then all five adventure aspects, each with invoke, compel, and twist guidance:

1. The Treaty Means Nothing Here
2. Everyone Has a Price
3. The War Never Really Ended
4. What the Mourning Left Behind
5. Blood Is Thicker Than Dragonmarks

The complete content for each is in the spec under "## General Adventure Aspects".

- [ ] **Step 4: Append the Building Cases from the Region Map section**

Write `### Building Cases from the Region Map` with four subsections:

1. Bad Statuses as Case Seeds
2. Periphery Sites as Case Sources
3. Faction Moves as Case Triggers
4. Downtime Foreshadowing

The complete content is in the spec under "## Building Cases from the Region Map".

- [ ] **Step 5: Verify the file renders**

Run: `cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1 | tail -5`
Expected: Build succeeds.

- [ ] **Step 6: Commit**

```bash
git add toolkit.md
git commit -m "feat: add complications, connections, adventure aspects, and region map case building"
```

---

## Task Dependencies

Tasks 1 → 2 → 3 (sequential appends to the same file).

## Self-Review

**Spec coverage:**
- Case Type table → Task 1 ✓
- How to Use → Task 1 ✓
- Investigate → Task 1 ✓
- Protect → Task 1 ✓
- Retrieve → Task 1 ✓
- Infiltrate → Task 1 ✓
- Expose → Task 1 ✓
- Negotiate → Task 2 ✓
- Escape → Task 2 ✓
- Thwart → Task 2 ✓
- Deliver → Task 2 ✓
- Complications → Task 3 ✓
- Connections → Task 3 ✓
- General Adventure Aspects (all 5) → Task 3 ✓
- Building Cases from Region Map (all 4 subsections) → Task 3 ✓

All spec sections covered. No placeholders. Terminology consistent with existing toolkit.
