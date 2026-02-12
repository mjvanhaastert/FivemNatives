# Pickup Core Natives

> Official docs base URL used in entries below: https://docs.fivem.net/natives/

## Input Rules (Important)

- `CreatePickup` and `CreatePickupRotate` expect a pickup hash (`PICKUP_*`) as argument 1, not a weapon hash (`WEAPON_*`).
- If you only have `WEAPON_*`, first map it with `GetPickupHashFromWeapon`.
- `modelHash` is a model override/default hint and is separate from `pickupHash`.
- `modelHash = 0` is usually stable because the engine uses the default pickup model.

## Native: CreatePickup

1. **Native name**: `CreatePickup`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `CreatePickup(pickupHash, posX, posY, posZ, p4, value, p6, modelHash) -> pickupHandle`
4. **What it does**: Creates a pickup entity at world coordinates.
5. **Arguments**:
   - `pickupHash`: `PICKUP_*` hash.
   - `posX`, `posY`, `posZ`: spawn position.
   - `p4`: unknown.
   - `value`: amount/value depending on pickup type.
   - `p6`: unknown bool.
   - `modelHash`: override model hash (often `0` in tests).
6. **Return behavior**:
   - Returns pickup handle on success.
   - `0`/`nil` is treated as failed spawn in scans.
7. **Minimal example**:
   ```lua
   local ped = PlayerPedId()
   local c = GetEntityCoords(ped)
   local handle = CreatePickup(`PICKUP_MONEY_CASE`, c.x, c.y, c.z, 0, 1, true, 0)
   print("CreatePickup handle:", handle)
   ```
8. **Related natives**: `CreatePickupRotate`, `DoesPickupExist`, `RemovePickup`
9. **Notes / pitfalls**:
   - Valid handle does not guarantee collect event.
   - Weapon/ammo state can affect practical collect outcomes.
   - Argument 1 must be `PICKUP_*`; if you only have `WEAPON_*`, map first with `GetPickupHashFromWeapon`.
   - `modelHash` is not the pickup identity; it only controls model override behavior.
   - Health and armour pickups are state-dependent: they are typically only collected/triggered when the player is below max health/armour.
   - Health pickup amount behaves differently from armour: observed behavior is that health pickups restore to full regardless of configured amount, while armour uses the configured amount as increment.
    - Observed behavior: this variant is used as networked pickup creation and the pickup spins automatically.

## Native: CreatePickupRotate

1. **Native name**: `CreatePickupRotate`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `CreatePickupRotate(pickupHash, posX, posY, posZ, rotX, rotY, rotZ, flags, amount, p9, p10, modelHash) -> pickupHandle`
4. **What it does**: Creates a pickup with explicit rotation and flags.
5. **Arguments**:
   - `pickupHash`: `PICKUP_*` hash.
   - `rotX`, `rotY`, `rotZ`: rotation values.
   - `flags`: placement/spin flags (scan used `8 + 512`).
   - `amount`: amount/value.
   - `p9`: unknown.
   - `p10`: unknown bool.
   - `modelHash`: model hash override.
6. **Return behavior**:
   - Returns pickup handle when creation succeeds.
   - `0`/`nil` indicates likely invalid native/hash combination.
7. **Minimal example**:
   ```lua
   local ped = PlayerPedId()
   local c = GetEntityCoords(ped)
   local handle = CreatePickupRotate(`PICKUP_MONEY_MED_BAG`, c.x, c.y, c.z, 0.0, 0.0, 0.0, 520, 1, 0, true, 0)
   print("CreatePickupRotate handle:", handle)
   ```
8. **Related natives**: `CreatePickup`, `CreateAmbientPickup`
9. **Notes / pitfalls**:
   - This native was the previous baseline in historical scan comparisons.
   - Rotation itself did not explain most failures in observed data.
   - Argument 1 must be a pickup hash (`PICKUP_*`), not a weapon hash.
   - Wrong `modelHash` can interfere with visuals/collectability; `0` is often safest.
    - Observed behavior: this variant is treated as non-networked in your tests; it allows setting rotation values but still shows automatic spinning behavior.

## Native: CreateAmbientPickup

1. **Native name**: `CreateAmbientPickup`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `CreateAmbientPickup(pickupHash, posX, posY, posZ, flags, value, modelHash, returnHandle, p8) -> pickupHandle|0`
4. **What it does**: Spawns an ambient pickup variant often tied to ambient collect events.
5. **Arguments**:
   - `pickupHash`: `PICKUP_*` hash.
   - `flags`: placement flags (scan used `8`).
   - `value`: amount/value.
   - `modelHash`: pickup model.
   - `returnHandle`: whether native should return a handle.
   - `p8`: unknown bool.
6. **Return behavior**:
   - Non-zero handle when created.
   - `0`/`nil` commonly seen for incompatible hashes.
7. **Minimal example**:
   ```lua
   local ped = PlayerPedId()
   local c = GetEntityCoords(ped)
   local handle = CreateAmbientPickup(`PICKUP_MONEY_PURSE`, c.x, c.y, c.z, 8, 1, 0, true, false)
   print("CreateAmbientPickup handle:", handle)
   ```
8. **Related natives**: `CreateNonNetworkedAmbientPickup`, `HasPickupBeenCollected`
9. **Notes / pitfalls**:
   - In scans, successful ambient spawns often mapped to `CEventNetworkPlayerCollectedAmbientPickup`.
   - Health and armour pickup collection can be suppressed if player health/armour is already full.
   - Same amount nuance applies here: health pickup amount is effectively ignored in observed behavior (full heal), armour amount controls added armour.

## Native: CreatePortablePickup

1. **Native name**: `CreatePortablePickup`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `CreatePortablePickup(pickupHash, x, y, z, placeOnGround, modelHash) -> objectHandle|0`
4. **What it does**: Spawns portable pickup object variants.
5. **Arguments**:
   - `pickupHash`: portable-capable `PICKUP_*` hash.
   - `x`, `y`, `z`: world coordinates.
   - `placeOnGround`: placement bool.
   - `modelHash`: model hash.
6. **Return behavior**:
   - Returns object handle for some portable types.
   - `0` for many non-portable hashes.
7. **Minimal example**:
   ```lua
   local ped = PlayerPedId()
   local c = GetEntityCoords(ped)
   local obj = CreatePortablePickup(`PICKUP_PORTABLE_PACKAGE`, c.x, c.y, c.z, true, 0)
   print("CreatePortablePickup object:", obj)
   ```
8. **Related natives**: `AttachPortablePickupToPed`, `DetachPortablePickupFromPed`
9. **Notes / pitfalls**:
   - A valid object return did not automatically produce collect events in observed runs.

## Native: CreateNonNetworkedAmbientPickup

1. **Native name**: `CreateNonNetworkedAmbientPickup`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `CreateNonNetworkedAmbientPickup(pickupHash, posX, posY, posZ, flags, value, modelHash, p7, p8) -> pickupHandle|0`
4. **What it does**: Spawns non-networked ambient pickup variant.
5. **Arguments**:
   - Similar to ambient variant.
   - `p7`, `p8`: unknown bool fields.
6. **Return behavior**:
   - Non-zero handle on success.
   - `0` for unsupported combinations.
7. **Minimal example**:
   ```lua
   local ped = PlayerPedId()
   local c = GetEntityCoords(ped)
   local handle = CreateNonNetworkedAmbientPickup(`PICKUP_MONEY_CASE`, c.x, c.y, c.z, 8, 1, 0, true, false)
   print("CreateNonNetworkedAmbientPickup handle:", handle)
   ```
8. **Related natives**: `CreateAmbientPickup`, `DoesPickupExist`
9. **Notes / pitfalls**:
   - In scans this native frequently emitted ambient collect events when successful.

## Native: CreateNonNetworkedPortablePickup

1. **Native name**: `CreateNonNetworkedPortablePickup`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `CreateNonNetworkedPortablePickup(pickupHash, x, y, z, placeOnGround, modelHash) -> pickupHandle|0`
4. **What it does**: Non-networked portable pickup creation.
5. **Arguments**:
   - Same shape as portable create variant.
6. **Return behavior**:
   - May return handle for portable-compatible hashes.
   - Often `0` for non-portable hashes.
7. **Minimal example**:
   ```lua
   local ped = PlayerPedId()
   local c = GetEntityCoords(ped)
   local handle = CreateNonNetworkedPortablePickup(`PICKUP_PORTABLE_CRATE_UNFIXED`, c.x, c.y, c.z, true, 0)
   print("CreateNonNetworkedPortablePickup handle:", handle)
   ```
8. **Related natives**: `CreatePortablePickup`, `CEventNetworkPlayerDroppedPortablePickup`
9. **Notes / pitfalls**:
   - Handle creation success and event success diverged in observed matrix data.


