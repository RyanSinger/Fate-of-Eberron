---
name: publish
description: Build site, verify no errors, commit changes, and push to remote. Use when the user wants to publish changes to the live site.
disable-model-invocation: true
---

# Publish

Build, verify, commit, and push changes to the remote repository.

## Steps

1. **Build the site** and check for errors:
   ```bash
   cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build 2>&1
   ```
   If the build fails, stop and report the error. Do not commit broken builds.

2. **Check git status** to see what changed:
   ```bash
   git status
   git diff --stat
   ```

3. **Show the user** a summary of what will be committed and get confirmation.

4. **Stage and commit** the changes:
   - Stage specific changed files (not `git add -A`)
   - Write a concise commit message describing the changes
   - Include `Co-Authored-By: Claude Opus 4.6 <noreply@anthropic.com>`

5. **Push to remote**:
   ```bash
   git push
   ```

6. **Confirm** the push succeeded and report the commit hash.

## Important

- Never commit `.env` files, API keys, or secrets
- Never commit `_site/` (it's gitignored)
- If there are no changes to commit, tell the user "nothing to publish"
- Always build before committing to catch errors early
