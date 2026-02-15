# cfgSettings Findings

Empirical and practical outcomes from real server operations and config review.

## Confidence-Tagged Claims

- **[documented]** `set` is appropriate for sensitive/internal values.
- **[documented]** `setr` values are readable by clients and should never contain secrets.
- **[documented]** `sets` values are public-facing metadata and visible in listing contexts.
- **[observed]** Misplacing secrets in `setr` or `sets` is a common real-world leak pattern.
- **[observed]** Aggressive control filtering can reduce exploit vectors but may impact normal gameplay scripts.
- **[observed]** Listing presentation quality improves when metadata is short, readable, and stripped of decorative noise.

## Practical Security Conclusions

- **[documented]** Keep anti-cheat/security knobs server-only (`set`).
- **[observed]** Rate limiter values are best treated as internal tuning and should remain non-public.
- **[documented]** Use replicated settings only where client scripts explicitly depend on `GetConvar` reads.

## Common Mistakes

- **[observed]** Putting DB connection strings or API keys in `setr` or `sets`.
- **[observed]** Using `sets` as a general-purpose config store.
- **[observed]** Overloading `sv_hostname` with noisy metadata instead of concise user-facing text.

## Migration Notes (Listing/UI)

- **[observed]** Recent listing/UI behavior favors plain, readable metadata.
- **[documented]** Keep listing fields policy-compliant and avoid deceptive/publicly misleading text.

## Next Actions

- **[documented]** Audit `server.cfg` for secret leakage (`setr`/`sets` misuse).
- **[documented]** Keep a minimal baseline profile and an optional hardening profile.
- **[documented]** Re-test gameplay systems after changes to request/event filtering.


