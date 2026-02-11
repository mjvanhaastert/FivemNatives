# CreatePed Core Natives

> Official docs base URL used in entries below: https://docs.fivem.net/natives/

## Native: CreatePed

1. **Native name**: `CreatePed`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `CreatePed(pedType, modelHash, x, y, z, heading, isNetwork, bScriptHostPed) -> ped`
4. **What it does**: Spawns a ped entity at world coordinates.
5. **Arguments**:
   - `pedType`: ped archetype category.
   - `modelHash`: ped model hash (must be loaded).
   - `x`, `y`, `z`, `heading`: spawn transform.
   - `isNetwork`: networked entity toggle.
   - `bScriptHostPed`: script host ownership behavior.
6. **Return behavior**:
   - Returns ped handle on success.
   - `0`/`nil` indicates spawn failure (common with unloaded/invalid model).
7. **Minimal example**:
   ```lua
   local model = `a_m_m_business_01`
   RequestModel(model)
   while not HasModelLoaded(model) do Wait(0) end
   local c = GetEntityCoords(PlayerPedId())
   local ped = CreatePed(4, model, c.x + 1.0, c.y, c.z, 0.0, true, true)
   print("CreatePed:", ped)
   ```
8. **Related natives**: `CreatePedInsideVehicle`, `DeletePed`, `SetEntityAsMissionEntity`
9. **Notes / pitfalls**:
   - Always request/load model before spawn to avoid `0` handle.
   - Network ownership behavior should be validated per resource architecture.

## Native: CreatePedInsideVehicle

1. **Native name**: `CreatePedInsideVehicle`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `CreatePedInsideVehicle(vehicle, pedType, modelHash, seat, isNetwork, bScriptHostPed) -> ped`
4. **What it does**: Spawns a ped directly into a vehicle seat.
5. **Arguments**:
   - `vehicle`: target vehicle handle.
   - `pedType`: ped category.
   - `modelHash`: ped model hash.
   - `seat`: seat index (`-1` driver).
   - `isNetwork`, `bScriptHostPed`: network ownership flags.
6. **Return behavior**:
   - Returns ped handle when seat/model are valid.
   - `0`/`nil` on invalid seat, invalid vehicle, or model failures.
7. **Minimal example**:
   ```lua
   local model = `a_m_y_skater_01`
   RequestModel(model)
   while not HasModelLoaded(model) do Wait(0) end
   local ped = CreatePedInsideVehicle(vehicle, 4, model, -1, true, true)
   print("CreatePedInsideVehicle:", ped)
   ```
8. **Related natives**: `CreatePed`, `TaskWarpPedIntoVehicle`
9. **Notes / pitfalls**:
   - Seat occupancy rules can cause silent failures.

## Native: ClonePed

1. **Native name**: `ClonePed`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `ClonePed(ped, heading, isNetwork, bScriptHostPed) -> ped`
4. **What it does**: Clones an existing ped entity.
5. **Arguments**:
   - `ped`: source ped handle.
   - `heading`: clone heading.
   - `isNetwork`, `bScriptHostPed`: network/host flags.
6. **Return behavior**:
   - Returns cloned ped handle on success.
   - `0`/`nil` if source ped is invalid or cloning fails.
7. **Minimal example**:
   ```lua
   local clone = ClonePed(PlayerPedId(), GetEntityHeading(PlayerPedId()), true, true)
   print("ClonePed:", clone)
   ```
8. **Related natives**: `CreatePed`, `DeletePed`
9. **Notes / pitfalls**:
   - Clones often need explicit relationship/task setup after spawn.


