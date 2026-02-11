# Pickup Helper Natives

> Official docs base URL used in entries below: https://docs.fivem.net/natives/

## Native: DoesPickupExist

1. **Native name**: `DoesPickupExist`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `DoesPickupExist(pickup) -> bool`
4. **What it does**: Checks whether a pickup handle currently exists.
5. **Arguments**:
   - `pickup`: pickup handle.
6. **Return behavior**:
   - `true` if handle points to an existing pickup.
   - `false` when handle is invalid/collected/removed.
7. **Minimal example**:
   ```lua
   if handle and handle ~= 0 and DoesPickupExist(handle) then
       print("Pickup still exists")
   end
   ```
8. **Related natives**: `RemovePickup`, `HasPickupBeenCollected`
9. **Notes / pitfalls**:
   - Useful as an extra assert in scan loops, not a replacement for event checks.

## Native: HasPickupBeenCollected

1. **Native name**: `HasPickupBeenCollected`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `HasPickupBeenCollected(pickup) -> bool`
4. **What it does**: Returns whether the pickup was collected.
5. **Arguments**:
   - `pickup`: pickup handle.
6. **Return behavior**:
   - `true` when game marks pickup as collected.
   - `false` for not-yet-collected or invalid pickup handles.
7. **Minimal example**:
   ```lua
   if handle and handle ~= 0 and HasPickupBeenCollected(handle) then
       print("Pickup collected")
   end
   ```
8. **Related natives**: `DoesPickupExist`, `CreatePickup`
9. **Notes / pitfalls**:
   - Best used with event logging when validating behavior across hashes.

## Native: RemovePickup

1. **Native name**: `RemovePickup`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `RemovePickup(pickup)`
4. **What it does**: Removes a pickup entity by handle.
5. **Arguments**:
   - `pickup`: pickup handle.
6. **Return behavior**:
   - No return value.
   - Invalid handles usually fail silently.
7. **Minimal example**:
   ```lua
   if handle and handle ~= 0 and DoesPickupExist(handle) then
       RemovePickup(handle)
   end
   ```
8. **Related natives**: `DoesPickupExist`, `CreatePickupRotate`
9. **Notes / pitfalls**:
   - Essential cleanup between matrix runs to avoid stale entities.

## Native: SetPickupRegenerationTime

1. **Native name**: `SetPickupRegenerationTime`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `SetPickupRegenerationTime(pickup, durationMs)`
4. **What it does**: Sets pickup respawn/regeneration timing.
5. **Arguments**:
   - `pickup`: pickup handle.
   - `durationMs`: cooldown duration in milliseconds.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   if handle and handle ~= 0 then
       SetPickupRegenerationTime(handle, 15000)
   end
   ```
8. **Related natives**: `SetPickupDoNotExpire`, `CEventNetworkPickupRespawned`
9. **Notes / pitfalls**:
   - `duration` is always in milliseconds.
   - Recommended for dedicated respawn-event tests.

## Native: DoesPickupOfTypeExistInArea

1. **Native name**: `DoesPickupOfTypeExistInArea`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `DoesPickupOfTypeExistInArea(pickupHash, x, y, z, radius) -> bool`
4. **What it does**: Checks if a pickup of a specific type exists near a position.
5. **Arguments**:
   - `pickupHash`: hash of the pickup type (`PICKUP_*`).
   - `x`, `y`, `z`: center coordinates.
   - `radius`: search radius.
6. **Return behavior**:
   - `true` if at least one pickup of the requested type is found.
   - `false` if none are found in the area.
7. **Minimal example**:
   ```lua
   local c = GetEntityCoords(PlayerPedId())
   local exists = DoesPickupOfTypeExistInArea(`PICKUP_WEAPON_PISTOL`, c.x, c.y, c.z, 5.0)
   print("DoesPickupOfTypeExistInArea:", exists)
   ```
8. **Related natives**: `DoesPickupExist`, `CreatePickup`
9. **Notes / pitfalls**:
   - Useful for area assertions when single-handle tracking is not enough.

## Native: ToggleUsePickupsForPlayer

1. **Native name**: `ToggleUsePickupsForPlayer` (`_TOGGLE_USE_PICKUPS_FOR_PLAYER`)
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `ToggleUsePickupsForPlayer(player, pickupHash, toggle)`
4. **What it does**: Enables or disables whether a player can use/receive a specific pickup type.
5. **Arguments**:
   - `player`: player ID (`PlayerId()` for local player).
   - `pickupHash`: pickup hash (`PICKUP_*`).
   - `toggle`: `true` enables, `false` disables.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   local pickup = GetHashKey("PICKUP_WEAPON_ADVANCEDRIFLE")
   ToggleUsePickupsForPlayer(PlayerId(), pickup, true)
   ```
8. **Related natives**: `CreatePickup`, `CreatePickupRotate`, `GetPickupHashFromWeapon`
9. **Notes / pitfalls**:
   - Critical for weapon pickup behavior: disabled state can make weapon pickups appear non-working.
   - Native hashes: `0x616093EC6B139DD9`, `0x7FADB4B9`.

## Native: GetPickupHashFromWeapon

1. **Native name**: `GetPickupHashFromWeapon`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `GetPickupHashFromWeapon(weaponHash) -> pickupHash`
4. **What it does**: Maps a `WEAPON_*` hash to its corresponding `PICKUP_WEAPON_*` hash.
5. **Arguments**:
   - `weaponHash`: weapon hash (for example `joaat("WEAPON_PISTOL")`).
6. **Return behavior**:
   - Returns matching pickup hash when mapping exists.
   - May return `0` when no mapping exists.
7. **Minimal example**:
   ```lua
   local weapon = GetHashKey("WEAPON_PISTOL")
   local pickup = GetPickupHashFromWeapon(weapon)
   print("Pickup hash from weapon:", pickup)
   ```
8. **Related natives**: `CreatePickup`, `CreatePickupRotate`, `ToggleUsePickupsForPlayer`
9. **Notes / pitfalls**:
   - Use this only when you start from `WEAPON_*`; create natives still require `PICKUP_*` as first argument.

## Validation Guidance

- `IsPickupWeaponObjectValid` is only valid for weapon pickup objects.
- For non-weapon pickups (for example health), `IsObjectAPickup` is the relevant generic check.

## Native: SetPickupDoNotExpire

1. **Native name**: `SetPickupDoNotExpire`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `SetPickupDoNotExpire(pickup, toggle)`
4. **What it does**: Configures expiration behavior for pickups.
5. **Arguments**:
   - `pickup`: pickup handle.
   - `toggle`: keep alive if true.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   if handle and handle ~= 0 then
       SetPickupDoNotExpire(handle, true)
   end
   ```
8. **Related natives**: `SetPickupRegenerationTime`, `RemovePickup`
9. **Notes / pitfalls**:
   - Useful to isolate collection behavior from auto-expire behavior.

## Native: CreateMoneyPickups

1. **Native name**: `CreateMoneyPickups`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `CreateMoneyPickups(x, y, z, value, amount, modelHash) -> any`
4. **What it does**: Spawns money pickup clusters/splits.
5. **Arguments**:
   - `x`, `y`, `z`: spawn position.
   - `value`: total value.
   - `amount`: split count/size behavior.
   - `modelHash`: model override.
6. **Return behavior**:
   - Return shape is not fully standardized across examples.
   - `0`/`nil` still indicates no useful created handle(s).
7. **Minimal example**:
   ```lua
   local c = GetEntityCoords(PlayerPedId())
   local result = CreateMoneyPickups(c.x, c.y, c.z, 1000, 10, 0)
   print("CreateMoneyPickups result:", result)
   ```
8. **Related natives**: `CreatePickup`, `CreateAmbientPickup`
9. **Notes / pitfalls**:
   - Marked for separate matrix testing because money pickups can differ from generic pickup behavior.

## Native: AttachPortablePickupToPed

1. **Native name**: `AttachPortablePickupToPed`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `AttachPortablePickupToPed(pickupObject, ped)`
4. **What it does**: Attaches portable pickup object to a ped.
5. **Arguments**:
   - `pickupObject`: object handle returned by portable create native.
   - `ped`: target ped handle.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   local ped = PlayerPedId()
   local c = GetEntityCoords(ped)
   local obj = CreatePortablePickup(`PICKUP_PORTABLE_PACKAGE`, c.x, c.y, c.z, true, 0)
   if obj and obj ~= 0 then
       AttachPortablePickupToPed(obj, ped)
   end
   ```
8. **Related natives**: `DetachPortablePickupFromPed`, `CreatePortablePickup`
9. **Notes / pitfalls**:
   - Key helper for testing portable drop/collect event chains.

## Native: DetachPortablePickupFromPed

1. **Native name**: `DetachPortablePickupFromPed`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `DetachPortablePickupFromPed(pickupObject)`
4. **What it does**: Detaches a portable pickup from a ped.
5. **Arguments**:
   - `pickupObject`: portable pickup object handle.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   if obj and obj ~= 0 then
       DetachPortablePickupFromPed(obj)
   end
   ```
8. **Related natives**: `AttachPortablePickupToPed`, `CEventNetworkPlayerDroppedPortablePickup`
9. **Notes / pitfalls**:
   - Should be tested with event tracing to verify dropped-portable event timing.


