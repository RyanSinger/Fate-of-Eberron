---
name: build-and-preview
description: Build Jekyll site and take a Playwright screenshot of a specified page. Use when the user wants to see how the site looks after changes.
disable-model-invocation: true
---

# Build and Preview

Build the Jekyll site, start a local server, and take a Playwright screenshot of a page.

## Steps

1. Build the site:
   ```bash
   cd /Users/ryan/Fate-of-Eberron-2 && bundle exec jekyll build
   ```

2. Start the Jekyll server in the background (if not already running):
   ```bash
   bundle exec jekyll serve --detach 2>/dev/null || true
   ```

3. Wait briefly for the server to start, then check it's running:
   ```bash
   lsof -i :4000 | grep LISTEN
   ```

4. Use Playwright to navigate to the requested page (default: `http://localhost:4000/Fate-of-Eberron/`).

5. Take a screenshot and show it to the user.

6. If the user specified a specific page path, navigate to `http://localhost:4000/Fate-of-Eberron/<path>` instead.

## Arguments

- If the user provides a page name (e.g., "players guide"), map it to the URL path (e.g., `/players-guide`).
- If no page is specified, screenshot the home page.
- If the user specifies a viewport size, resize the browser before screenshotting.
