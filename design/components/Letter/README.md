# Letter

A letter on house letterhead with a wax seal.

- Markup: `<div class="handout handout--letter" markdown="1">` with `<p class="handout__letterhead">`, the body as markdown, then `<div class="handout__footer" markdown="1">` holding `<p class="handout__signature">` and the seal.
- Seal: `{% include components/seal.html house="Sivis" %}`.
