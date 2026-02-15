# cfgSettings Domain

Server configuration references for FiveM `server.cfg` usage, focused on convar types, safe defaults, and operational/security impact.

## Scope

- Correct usage of `set`, `setr`, and `sets`.
- Practical convar groups (network, OneSync, security, voice, listing, performance).
- Distinguishing private vs replicated vs public settings.
- Migration notes for newer listing/UI behavior.

## Files

- `core.md`: main concepts and decision rules (`set` vs `setr` vs `sets`).
- `helpers.md`: categorized `server.cfg` examples and command patterns.
- `events.md`: event-related notes relevant to config decisions.
- `findings.md`: observed behavior, pitfalls, and recommended defaults.

## Primary References

- https://docs.fivem.net/docs/
- https://fixfx.wiki/docs/cfx/best-practices/security
- https://docs.1of1servers.com/1-of-1-game-server-guides/fivem/