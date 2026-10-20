# Consequences

Consequence slots, each with its shift value and a line to write the consequence on.

- Jekyll: `{% include components/consequences.html slots="mild,moderate" %}`. Default is all three. Values: mild 2, moderate 4, severe 6.
- Slot names ignore case and spaces. An unknown slot name renders without a value.
- Labels and circles use `red-text`.
