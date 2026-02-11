# CreatePed Findings (Empirical)

This domain is scaffolded to mirror pickup structure and is ready for dedicated runtime matrix runs.

## Current State

- **[documented]** File structure and entry format are aligned with the pickup reference domain.
- **[observed]** No dedicated createped matrix logs were provided in this repo snapshot.
- **[hypothesis]** Most createped failures in practice will correlate to model loading and network ownership setup.

## Proposed Test Matrix

- Spawn matrix by native:
  - `CreatePed`
  - `CreatePedInsideVehicle`
  - `ClonePed`
- Conditions:
  - model loaded vs not loaded
  - networked vs non-networked
  - mission entity vs non-mission
- Validation columns:
  - native return handle (`0`/`nil` vs valid)
  - `DoesEntityExist`
  - event hits from `gameEventTriggered`

## Initial Assumptions To Validate

- **[hypothesis]** `CreatePed` with unloaded model returns `0`/`nil` consistently.
- **[hypothesis]** `CreatePedInsideVehicle` failure rate increases with occupied/invalid seat index.
- **[hypothesis]** `SetEntityAsMissionEntity` reduces unexpected cleanup in long-running scripts.

## Next Steps

- **[documented]** Add a reproducible `createped` scan command script similar to pickup scanner style.
- **[documented]** Store first matrix run output in this file with `[observed]` labels.
- **[documented]** Promote validated claims into `core/helpers/events` when behavior is stable.


