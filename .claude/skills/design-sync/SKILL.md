---
name: design-sync
description: Use when design/tokens.json, design/README.md, design/components/, assets/css/components.css, assets/css/handouts.css or design-sample.md changed and the claude.ai Fate of Eberron design system needs republishing, or when the user asks to sync or publish the design system.
---

# Design Sync

Publishes the repository's design system to the claude.ai Design System artifact. The repository is the source of truth: anything edited directly on claude.ai is overwritten by this sync. Say that to the user before publishing.

The artifact URL is recorded in CLAUDE.md under "Design System".

## Steps

1. **Test first.** Run `bash tests/design.sh`. Stop on any failure.

2. **Read the live system.** With the Artifact tool, `read` the artifact URL, then `read` with `path: "project/design-system.json"` and with `path: "artifact-type/reference/format.md"` and `path: "artifact-type/reference/cover.md"` if this session has not read them. Follow `format.md` for every file shape.

3. **Icons.** If the index's `assetGroups.Icons.files` lacks any of `overcome.svg`, `create-advantage.svg`, `attack.svg`, `defend.svg`, `fate-die.svg`, upload each missing one from `images/icons/` with `{action: "publish", url, file_path, asset: true}` and record `{"name", "blob", "size", "type": "image/svg+xml"}` from the result. Never re-upload icons that are already recorded.

4. **Write blobs.json.** It maps each icon file name to its upload id from the index's `assetGroups.Icons.files` (`{"attack.svg": "<blob id>", ...}`), so previews load icons from `/_blob/<id>`. Save the index you read (with the new icon entries added) as `<scratchpad>/index.json`, then:
   ```bash
   ruby -rjson -e 'puts JSON.generate(JSON.parse(File.read(ARGV[0])).dig("assetGroups", "Icons", "files").to_h { |f| [f["name"], f["blob"]] })' "<scratchpad>/index.json" > "<scratchpad>/blobs.json"
   ```
   Keep `blobs.json` outside `$STAGE`, because step 5 deletes that directory. Staging fails if a preview uses an icon that is not in this file.

5. **Build and stage.** Into the scratchpad:
   ```bash
   STAGE="<scratchpad>/design-sync"
   rm -rf "$STAGE" && mkdir -p "$STAGE"
   bundle exec jekyll build --quiet -d "$STAGE/site"
   ruby script/stage_design_system.rb "$STAGE/site" "$STAGE/out" "<scratchpad>/blobs.json"
   ```
   The script also writes an empty `components/bundle.js`; claude.ai does not run previews without one.

6. **Cover.** Keep `project/components/Cover/preview.html` as it is unless the brand changed. To create or redo it, follow `cover.md` and write it into `$STAGE/out/project/components/Cover/`.

7. **Index.** Copy the index you read in step 2 (with the icon entries from step 3) to `$STAGE/out/project/design-system.json`. Keep every key and the marker. Set `title` to "Fate of Eberron", `namespace` to "FateOfEberron", `libraries` to `[]`, keep `groups` containing "Icons", and set `lastChange` to `{"by": "<user's name>", "at": "<now, ISO 8601>", "via": "Claude Code design-sync", "note": "<one line: what changed>"}`.

8. **Publish once.** One Artifact call with `url`, `root: "$STAGE/out"`, `file_path: "$STAGE/out/project/design-system.json"` and `files` mapping every other staged path (`"project/tokens.json": "project/tokens.json"`, and so on). Components that disappeared from the sample get `"project/components/<Name>/README.md": null` and `"project/components/<Name>/preview.html": null`.

9. **Report.** Give the user the artifact link and the list of components published. If the publish is refused because someone saved meanwhile, read the index again, redo step 7 once, and publish; if refused again, stop and tell the user.

## Rules

- Never write outside `project/` in the artifact.
- Never upload previews, tokens or READMEs as assets; only the icon SVGs.
- Never remove an asset someone added on claude.ai.
