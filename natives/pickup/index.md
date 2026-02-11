# Pickup Domain

Pickup creation, pickup state helpers, and pickup-related game events used in FiveM runtime tests.

## Scope

- Creation and spawning behavior for pickup natives.
- Validation helpers (`DoesPickupExist`, collected state, cleanup).
- Player pickup enable/disable behavior (`ToggleUsePickupsForPlayer`).
- Hash mapping guidance (`WEAPON_*` to `PICKUP_*` via `GetPickupHashFromWeapon`).
- Event mapping for collect/drop/respawn paths.
- Runtime matrix notes from `trp_bunker` scans.

## Files

- `core.md`: main pickup creation natives.
- `helpers.md`: helper/state/control natives.
- `events.md`: pickup-related game events.
- `findings.md`: observed scan outcomes and confidence-tagged claims.

## Source Inputs Used

- `c:/Users/Administrator/server/22443/txData/QBCore_1DF200.base/resources/trp_bunker/pickup.md`
- `c:/Users/Administrator/server/22443/txData/QBCore_1DF200.base/resources/trp_bunker/src/cl_main.lua`
- `pickup.lua` (local copy/sync of scan logic and logs)


