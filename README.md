# FiveM Natives Knowledge Base

Community-maintained documentation for FiveM/CFX natives, combining official references with reproducible runtime findings.

## Repository Structure

```text
FivemNatives/
  README.md
  natives/
    <domain>/
      index.md
      core.md
      helpers.md
      events.md
      findings.md
```

- `index.md`: domain overview, scope, links to all subfiles.
- `core.md`: main natives for the domain.
- `helpers.md`: supporting/maintenance natives.
- `events.md`: related game events and payload notes.
- `findings.md`: runtime behavior, test matrices, and open questions.

## Evidence Labels

- `documented`: stated in official docs or official source comments.
- `observed`: seen in local runtime tests and logs.
- `hypothesis`: reasoned assumption that still needs confirmation.

## Add a New Domain

1. Create `natives/<new-domain>/`.
2. Add `index.md`, `core.md`, `helpers.md`, `events.md`, and `findings.md`.
3. Keep official knowledge in `core/helpers/events`.
4. Keep runtime behavior in `findings` with confidence labels.
5. Follow the standard entry format in every native entry:
   1. Native name
   2. Native URL
   3. Signature
   4. What it does
   5. Arguments
   6. Return behavior (including `0`/`nil` caveats)
   7. Minimal example
   8. Related natives
   9. Notes / pitfalls

## Current Domains

- `pickup`
- `createped`


