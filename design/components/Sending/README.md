# Sending

A Sivis message slip for a Sending spell, with the 25 word limit shown as ticks.

- Markup: `<div class="handout handout--sending" markdown="1">` with `<p class="handout__stamp">`, the message in capitals, then the counter.
- Counter: `{% include components/word-count.html words=24 %}`. Over 25 fills every tick and turns the total red.
