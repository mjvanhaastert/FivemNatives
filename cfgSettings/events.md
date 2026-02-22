# cfgSettings Events

Config itself does not define game events, but several config choices impact event routing and handling behavior.

## Event-Adjacent Config Notes

1. **Topic**: Net game event filtering
2. **Reference URL**: https://docs.fivem.net/docs/
3. **Related Commands**: `block_net_game_event`, `unblock_net_game_event`
4. **What it does**: Allows blocking specific net game events at server level.
5. **Arguments**:
   - Event name string (for example `"FIRE_EVENT"`).
6. **Return behavior**:
   - Command-based; no script return value.
7. **Minimal example**:
   ```cfg
   block_net_game_event "FIRE_EVENT"
   ```
8. **Related settings**: `sv_filterRequestControl`, `sv_enableNetworkedSounds`
9. **Notes / pitfalls**:
   - Over-blocking can break legitimate gameplay systems.

1. **Topic**: State bag and net event performance path
2. **Reference URL**: https://docs.fivem.net/docs/
3. **Related Convars**: `sv_experimentalStateBagsHandler`, `sv_experimentalNetGameEventHandler`
4. **What it does**: Affects serialization and transport behavior of replicated data/event pathways.
5. **Arguments**:
   - Boolean toggle values.
6. **Return behavior**:
   - Convar toggle only.
7. **Minimal example**:
   ```cfg
   setr sv_experimentalNetGameEventHandler true
   ```
8. **Related settings**: `sv_enableNetworkedScriptEntityStates`
9. **Notes / pitfalls**:
   - Validate compatibility with your resource stack after enabling.


