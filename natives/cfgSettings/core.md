# cfgSettings Core

This file contains the core rules for configuring FiveM `server.cfg` values in a safe and maintainable way.

## `set` vs `setr` vs `sets`

### `set` (server-only)

- Visibility: server-side only.
- Use for: secrets, anti-cheat/security, internal limits, DB connection strings.
- Example:

```cfg
set sv_scriptHookAllowed 0
set mysql_connection_string "server=127.0.0.1;database=fivem;userid=root;password=..."
```

### `setr` (replicated server -> client)

- Visibility: server + clients can read the value.
- Use for: values client scripts must read (`GetConvar`), voice behavior, client gameplay toggles.
- Example:

```cfg
setr voice_defaultVolume 0.3
setr sv_enableNetworkedScriptEntityStates 1
```

### `sets` (public server-info metadata)

- Visibility: server, clients, server browser, metadata endpoints.
- Use for: public server branding and listing details only.
- Example:

```cfg
sets sv_hostname "My Server"
sets tags "roleplay, serious, whitelist"
```

## Why this approach over alternatives

Using the proper convar type (`set` vs `setr` vs `sets`) is better than forcing everything into one type because:

- It prevents leaking sensitive values.
- It keeps client-visible settings intentionally readable.
- It avoids exposing private data in listing/browser metadata.
- It makes runtime behavior clearer when debugging configuration issues.

## Security rule of thumb

- ~90% of convars should be `set`.
- Use `setr` only when clients must read the value.
- Use `sets` only for public listing metadata.

Never do:

```cfg
sets mysql_connection_string "..."   # public leak
setr api_key "secret"                # readable by clients
```

Do this instead:

```cfg
set mysql_connection_string "..."
set api_key "secret"
```

## Rate limiter and networked-state examples

- Correct (`set`) for internal rate limiting:

```cfg
set rateLimiter_stateBag_rate 75
set rateLimiter_stateBag_burst 125
```

- Correct (`setr`) for values client scripts must read:

```cfg
setr sv_enableNetworkedScriptEntityStates 1
setr sv_experimentalStateBagsHandler true
```

## Structure in this domain

- Use `helpers.md` for categorized, practical `server.cfg` entries.
- Use `findings.md` for observed behavior, migration notes, and pitfalls.
- Use `events.md` for event-driven config notes (if applicable).