# Track

A row of boxes for stress, refresh or a countdown.

- Jekyll: `{% include components/track.html label="Physical" boxes=3 %}`. `boxes` is clamped to 1 through 12. Default label is Stress.
- Countdown: add `style="clock"` for a segmented dial beside the boxes.
- Boxes are real checkboxes on screen with no saved state, and empty squares on paper. They carry no numbers: in Fate Condensed each box absorbs one shift.
