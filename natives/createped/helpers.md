# CreatePed Helper Natives

> Official docs base URL used in entries below: https://docs.fivem.net/natives/

## Native: SetEntityAsMissionEntity

1. **Native name**: `SetEntityAsMissionEntity`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `SetEntityAsMissionEntity(entity, scriptHostObject, bGrabFromOtherScript)`
4. **What it does**: Pins entity ownership to script context for persistence/control.
5. **Arguments**:
   - `entity`: ped/entity handle.
   - `scriptHostObject`: script host ownership toggle.
   - `bGrabFromOtherScript`: attempt take-over from other scripts.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   SetEntityAsMissionEntity(ped, true, true)
   ```
8. **Related natives**: `CreatePed`, `DeletePed`
9. **Notes / pitfalls**:
   - Important before long-lived AI task assignment and cleanup workflows.

## Native: DoesEntityExist

1. **Native name**: `DoesEntityExist`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `DoesEntityExist(entity) -> bool`
4. **What it does**: Checks whether an entity handle is valid/alive in world state.
5. **Arguments**:
   - `entity`: entity handle.
6. **Return behavior**:
   - `true` for valid entity.
   - `false` for deleted/invalid entity handle.
7. **Minimal example**:
   ```lua
   if ped and ped ~= 0 and DoesEntityExist(ped) then
       print("Ped exists")
   end
   ```
8. **Related natives**: `DeletePed`, `CreatePed`
9. **Notes / pitfalls**:
   - Use this check before cleanup or task calls.

## Native: DeletePed

1. **Native name**: `DeletePed`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `DeletePed(pedPointer)`
4. **What it does**: Deletes a ped entity.
5. **Arguments**:
   - `pedPointer`: ped reference/handle according to runtime language binding.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   if ped and ped ~= 0 and DoesEntityExist(ped) then
       DeletePed(ped)
   end
   ```
8. **Related natives**: `DoesEntityExist`, `SetEntityAsMissionEntity`
9. **Notes / pitfalls**:
   - Ensure no dependent logic still references the deleted handle.

## Native: SetPedAsNoLongerNeeded

1. **Native name**: `SetPedAsNoLongerNeeded`
2. **Native URL**: https://docs.fivem.net/natives/
3. **Signature**: `SetPedAsNoLongerNeeded(pedPointer)`
4. **What it does**: Releases script ownership so engine can clean up ped when appropriate.
5. **Arguments**:
   - `pedPointer`: ped reference/handle.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   if ped and ped ~= 0 then
       SetPedAsNoLongerNeeded(ped)
   end
   ```
8. **Related natives**: `DeletePed`, `SetEntityAsMissionEntity`
9. **Notes / pitfalls**:
   - Prefer this when you want soft release instead of immediate delete.


