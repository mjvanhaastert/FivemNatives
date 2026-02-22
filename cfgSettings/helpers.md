# cfgSettings Helpers

Practical `server.cfg` snippets grouped by category. This is the English-structured version of the previous draft and keeps the same operational intent.

## Legend

- `[SET]`: server-only convar
- `[SETR]`: replicated convar (readable by clients)
- `[SETS]`: public metadata convar
- `[COMMAND]`: direct command (no `set` prefix)

## 1) Server Identity and Visibility

```cfg
[SETS] sets sv_hostname "My FiveM Server"
[SETS] sets sv_projectName "My Community"
[SETS] sets sv_projectDesc "A serious roleplay community"
[SETS] sets tags "roleplay,serious,whitelist,qbcore"
[SETS] sets locale "en-US"
[SETS] sets Discord "https://discord.gg/yourserver"
[SETS] sets Website "https://yourserver.com"
[SETS] sets banner_detail "https://cdn.yourserver.com/banner.png"
[SETS] sets banner_connecting "https://cdn.yourserver.com/loading.png"
[SETS] sets gametype "Roleplay"
[SETS] sets mapname "Los Santos"
```

## 2) Network and Connection

```cfg
[COMMAND] endpoint_add_tcp "0.0.0.0:30120"
[COMMAND] endpoint_add_udp "0.0.0.0:30120"
[COMMAND] netPort 30120
[COMMAND] sv_maxclients 64

[SET] set net_tcpConnLimit 16
[SET] set sv_tcpConnectionTimeoutSeconds 30
[SET] set sv_httpHandlerConnectionTimeoutSeconds 600
[SET] set sv_netRateLimit 1048576
[SET] set sv_netRateLimitBurst 2097152
[SET] set sv_netRateLimitPerClient 100000
```

## 3) OneSync and State Synchronization

```cfg
[COMMAND] onesync on
[SET] set onesync_population false
[SETR] setr sv_experimentalStateBagsHandler true
[SETR] setr sv_experimentalOneSyncPopulation true
[SETR] setr sv_experimentalNetGameEventHandler true
[SETR] setr sv_enableNetworkedScriptEntityStates 1
```

## 4) Build and Runtime

```cfg
[COMMAND] sv_enforceGameBuild 3751
[COMMAND] gamename gta5
[SET] set sv_replaceExeToSwitchBuilds false
```

## 5) Security and Anti-Cheat

```cfg
[SET] set sv_scriptHookAllowed 0
[SET] set sv_pureLevel 1
[SET] set sv_disableClientReplays true
[SET] set sv_authMaxVariance 2
[SET] set sv_authMinTrust 3
[SET] set sv_requestParanoia 3
[SET] set sv_filterRequestControl 2
[SET] set sv_filterRequestControlSettleTimer 30000
[SET] set sv_enableNetworkedSounds true
[SET] set sv_enableNetworkedPhoneExplosions false
```

## 6) CNL Connection-Based Anti-Cheat

```cfg
[SET] set sv_cnlConnectionTimeout 600
[SET] set sv_cnlConnectionFrequency 60
[SET] set sv_cnlConnectionGracePeriod 120
[SET] set sv_cnlConnectionKickThreshold 2
[SET] set sv_kick_players_cnl 1
```

## 7) Rate Limiting

```cfg
[SET] set rateLimiter_stateBag_rate 75
[SET] set rateLimiter_stateBag_burst 125
[SET] set rateLimiter_stateBagFlood_rate 150
[SET] set rateLimiter_stateBagFlood_burst 175
```

## 8) Privacy and Listing

```cfg
[SET] set sv_endpointprivacy true
[SET] set sv_forceIndirectListing true
[SET] set sv_disableInactiveListing true
[SET] set sv_master1 ""
[SET] set sv_httpFileServerProxyOnly false
; optional:
; set sv_listingIpOverride "1.2.3.4"
; set sv_endpoint "external.ip:30120"
; set sv_proxyIPRanges "10.0.0.0/8,172.16.0.0/12"
```

## 9) Performance and Threading

```cfg
[SET] set sv_threadSleep 0
[SET] set sv_enableProfiling false
```

## 10) Pool Sizes (Advanced)

```cfg
[COMMAND] increase_pool_size "TxdStore" 10000
; optional examples:
; increase_pool_size "AnimStore" 5000
; increase_pool_size "FragmentStore" 5000
; increase_pool_size "Building" 5000
; increase_pool_size "Object" 1000
; increase_pool_size "CMoveObject" 200
```

## 11) Authentication and Identity

```cfg
[SET] set steam_webApiKey "YOUR_STEAM_API_KEY"
[SET] set rcon_password "StrongPasswordHere"
[SET] set sv_exposePlayerIdentifiersInHttpEndpoint false
; optional:
; set sv_tebexSecret "..."
```

## 12) Voice Chat

```cfg
[SETR] setr voice_useNativeAudio true
[SETR] setr voice_useSendingRangeOnly true
[SETR] setr voice_defaultCycle "GRAVE"
[SETR] setr voice_defaultVolume 0.3
[SETR] setr voice_enableRadioAnim 1
```

## 13) Client Gameplay Toggles

```cfg
[SETR] setr game_enableFlyThroughWindscreen true
[SETR] setr game_enablePlayerJumpRagdollControl true
[SETR] setr game_enablePlayerRagdollOnCollision true
```

## 14) ACL and Resource Ops

```cfg
[COMMAND] add_ace group.admin command.restart allow
[COMMAND] add_principal identifier.steam:110000112345678 group.admin
[COMMAND] start my_resource
[COMMAND] stop my_resource
[COMMAND] ensure my_resource
[COMMAND] restart my_resource
[COMMAND] refresh
```

## 15) Misc and Custom Convars

```cfg
[SET] set mysql_connection_string "server=127.0.0.1;database=fivem;userid=root;password=..."
[SETR] setr qb_locale "en"
```

## 16) Exec Files

```cfg
[COMMAND] exec server_nested.cfg
```

## 17) 2026 Listing Migration (Quick Rules)

- Remove color codes (`^1` to `^9`) from listing fields.
- Keep `sv_projectName` concise.
- Keep `sv_hostname` readable and concise.
- Use `sv_projectDesc` for full details.
- Avoid tags and visual noise in `sv_projectName`.