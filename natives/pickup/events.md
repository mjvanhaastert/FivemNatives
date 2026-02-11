# Pickup Events

Official event docs for these CEvent variants are sparse; this file records current known shape and test usage boundaries.

## Event: CEventNetworkPlayerCollectedPickup

1. **Event name**: `CEventNetworkPlayerCollectedPickup`
2. **Native/Event URL**: https://docs.fivem.net/docs/game-references/game-events/
3. **Observed payload signature**: `eventName, eventData[]` (index mapping not fully documented)
4. **What it does**: Triggered when a player collects a pickup in networked flow.
5. **Arguments / payload fields**:
   - Known: event name and integer payload array provided by game event handler.
   - Unknown: stable field mapping to pickup hash/handle/player.
6. **Return behavior**:
   - Event callback has no return contract.
   - Missing event does not prove spawn failure by itself.
7. **Minimal example**:
   ```lua
   AddEventHandler("gameEventTriggered", function(name, data)
       if name == "CEventNetworkPlayerCollectedPickup" then
           print("CollectedPickup", json.encode(data))
       end
   end)
   ```
8. **Related natives/events**: `CreatePickup`, `CreatePickupRotate`, `CEventNetworkPlayerCollectedAmbientPickup`
9. **Notes / pitfalls**:
   - Main positive signal for many successful `CreatePickup`/`CreatePickupRotate` test cases.
   - If `ToggleUsePickupsForPlayer` is disabled for that pickup hash, expected collect flow can be suppressed.

## Event: CEventNetworkPlayerCollectedAmbientPickup

1. **Event name**: `CEventNetworkPlayerCollectedAmbientPickup`
2. **Native/Event URL**: https://docs.fivem.net/docs/game-references/game-events/
3. **Observed payload signature**: `eventName, eventData[]` (field mapping unknown)
4. **What it does**: Triggered for ambient pickup collection paths.
5. **Arguments / payload fields**:
   - Known: same game event callback shape.
   - Unknown: exact semantic meaning of each payload index.
6. **Return behavior**:
   - No return contract.
   - Seen frequently when ambient natives succeed.
7. **Minimal example**:
   ```lua
   AddEventHandler("gameEventTriggered", function(name, data)
       if name == "CEventNetworkPlayerCollectedAmbientPickup" then
           print("CollectedAmbient", json.encode(data))
       end
   end)
   ```
8. **Related natives/events**: `CreateAmbientPickup`, `CreateNonNetworkedAmbientPickup`
9. **Notes / pitfalls**:
   - Ambient and non-ambient collect events can appear together in cross-native matrix reports.

## Event: CEventNetworkPlayerCollectedPortablePickup

1. **Event name**: `CEventNetworkPlayerCollectedPortablePickup`
2. **Native/Event URL**: https://docs.fivem.net/docs/game-references/game-events/
3. **Observed payload signature**: `eventName, eventData[]`
4. **What it does**: Intended collection event for portable pickup flows.
5. **Arguments / payload fields**:
   - Known: callback receives event data array.
   - Unknown: stable portable object identifiers in payload.
6. **Return behavior**:
   - No return contract.
7. **Minimal example**:
   ```lua
   AddEventHandler("gameEventTriggered", function(name, data)
       if name == "CEventNetworkPlayerCollectedPortablePickup" then
           print("CollectedPortable", json.encode(data))
       end
   end)
   ```
8. **Related natives/events**: `CreatePortablePickup`, `CreateNonNetworkedPortablePickup`
9. **Notes / pitfalls**:
   - Not consistently seen in latest broad matrix despite some portable handles being valid.

## Event: CEventNetworkPlayerDroppedPortablePickup

1. **Event name**: `CEventNetworkPlayerDroppedPortablePickup`
2. **Native/Event URL**: https://docs.fivem.net/docs/game-references/game-events/
3. **Observed payload signature**: `eventName, eventData[]`
4. **What it does**: Trigger candidate when a portable pickup is dropped.
5. **Arguments / payload fields**:
   - Known: callback event name + data array.
   - Unknown: exact field mapping.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   AddEventHandler("gameEventTriggered", function(name, data)
       if name == "CEventNetworkPlayerDroppedPortablePickup" then
           print("DroppedPortable", json.encode(data))
       end
   end)
   ```
8. **Related natives/events**: `AttachPortablePickupToPed`, `DetachPortablePickupFromPed`
9. **Notes / pitfalls**:
   - Requires dedicated attach/detach scenarios; broad matrix did not focus on this path.

## Event: CEventNetworkPickupRespawned

1. **Event name**: `CEventNetworkPickupRespawned`
2. **Native/Event URL**: https://docs.fivem.net/docs/game-references/game-events/
3. **Observed payload signature**: `eventName, eventData[]`
4. **What it does**: Signals pickup respawn behavior in network context.
5. **Arguments / payload fields**:
   - Known: event name + data array.
   - Unknown: payload index mapping and strict trigger conditions.
6. **Return behavior**:
   - No return value.
7. **Minimal example**:
   ```lua
   AddEventHandler("gameEventTriggered", function(name, data)
       if name == "CEventNetworkPickupRespawned" then
           print("PickupRespawned", json.encode(data))
       end
   end)
   ```
8. **Related natives/events**: `SetPickupRegenerationTime`, `SetPickupDoNotExpire`
9. **Notes / pitfalls**:
   - Needs dedicated regeneration tests to validate deterministic triggering.


