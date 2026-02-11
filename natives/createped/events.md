# CreatePed Events

Ped-specific game event documentation is fragmented; this file tracks relevant event hooks and known limits.

## Event: CEventNetworkEntityDamage

1. **Event name**: `CEventNetworkEntityDamage`
2. **Native/Event URL**: https://docs.fivem.net/docs/game-references/game-events/
3. **Observed payload signature**: `eventName, eventData[]`
4. **What it does**: Reports network damage events involving entities (including peds).
5. **Arguments / payload fields**:
   - Known: callback provides event name and integer payload array.
   - Unknown: stable per-index mapping across game builds.
6. **Return behavior**:
   - No callback return contract.
7. **Minimal example**:
   ```lua
   AddEventHandler("gameEventTriggered", function(name, data)
       if name == "CEventNetworkEntityDamage" then
           print("EntityDamage", json.encode(data))
       end
   end)
   ```
8. **Related natives/events**: `CreatePed`, `DeletePed`
9. **Notes / pitfalls**:
   - Payload index interpretation should be validated locally before production logic.

## Event: CEventNetworkPlayerEnteredVehicle

1. **Event name**: `CEventNetworkPlayerEnteredVehicle`
2. **Native/Event URL**: https://docs.fivem.net/docs/game-references/game-events/
3. **Observed payload signature**: `eventName, eventData[]`
4. **What it does**: Signals vehicle enter actions that may involve spawned peds.
5. **Arguments / payload fields**:
   - Known: callback receives raw event array.
   - Unknown: strict index mapping for actor/vehicle/seat in all builds.
6. **Return behavior**:
   - No return contract.
7. **Minimal example**:
   ```lua
   AddEventHandler("gameEventTriggered", function(name, data)
       if name == "CEventNetworkPlayerEnteredVehicle" then
           print("PlayerEnteredVehicle", json.encode(data))
       end
   end)
   ```
8. **Related natives/events**: `CreatePedInsideVehicle`
9. **Notes / pitfalls**:
   - Useful when validating spawn + seat occupancy workflows.


