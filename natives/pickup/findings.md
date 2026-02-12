# Pickup Findings (Empirical)

This file intentionally contains runtime behavior and test conclusions, separate from official descriptions.

## Test Context

- Source scripts: `pickup.lua` and `trp_bunker/src/cl_main.lua`
- Matrix order: `CreatePickupRotate`, `CreatePickup`, `CreateAmbientPickup`, `CreatePortablePickup`, `CreateNonNetworkedAmbientPickup`, `CreateNonNetworkedPortablePickup`
- Event set tracked:
  - `CEventNetworkPlayerCollectedAmbientPickup`
  - `CEventNetworkPlayerCollectedPickup`
  - `CEventNetworkPlayerCollectedPortablePickup`
  - `CEventNetworkPlayerDroppedPortablePickup`
  - `CEventNetworkPickupRespawned`

## Confidence-Tagged Claims

- **[observed]** Latest matrix snapshot reports: `worked=45`, `failed=118`, `total=163`.
- **[observed]** `CreatePickup` and `CreatePickupRotate` successes usually pair with `CEventNetworkPlayerCollectedPickup`.
- **[observed]** `CreateAmbientPickup` and `CreateNonNetworkedAmbientPickup` successes usually pair with `CEventNetworkPlayerCollectedAmbientPickup`.
- **[observed]** Portable create natives can return valid handles while still showing no collect event.
- **[observed]** `0`/`nil` return strongly correlates with invalid native/hash combinations.
- **[observed]** Weapon pickup failures in prior tests were caused by disabled pickup usage; enabling with `ToggleUsePickupsForPlayer(PlayerId(), pickupHash, true)` restores expected behavior.
- **[observed]** Health and armour pickups are condition-based: if the player is already at max health/armour, collect trigger and pickup result can be absent.
- **[observed]** Health and armour amount handling differs: health pickup amount appears ignored (full heal), while armour pickup amount determines how much armour is granted.
- **[observed]** `CreatePickup` behaved as networked in your tests and the created pickup rotated/spun automatically.
- **[observed]** `CreatePickupRotate` behaved as non-networked in your tests; manual rotation inputs are possible, but pickups still spin automatically around their axis.
- **[hypothesis]** Some hashes may be legacy/single-player biased and not fully functional in network sessions.

## Working Hash Set (Latest Run, 45)

```lua
{
    [68603185] = "PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS_UPRIGHT",
    [79909481] = "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_WITH_PASSENGERS",
    [341217064] = "PICKUP_MONEY_MED_BAG",
    [483577702] = "PICKUP_HEALTH_SNACK",
    [513448440] = "PICKUP_MONEY_PURSE",
    [545862290] = "PICKUP_MONEY_DEP_BAG",
    [738282662] = "PICKUP_CUSTOM_SCRIPT",
    [746606563] = "PICKUP_VEHICLE_WEAPON_STICKYBOMB",
    [772217690] = "PICKUP_VEHICLE_WEAPON_SAWNOFF",
    [837436873] = "PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE",
    [1263688126] = "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR",
    [1274757841] = "PICKUP_ARMOUR_STANDARD",
    [1575005502] = "PICKUP_MONEY_WALLET",
    [1651898027] = "PICKUP_PORTABLE_PACKAGE_LARGE_RADIUS",
    [1704231442] = "PICKUP_VEHICLE_MONEY_VARIABLE",
    [1705498857] = "PICKUP_VEHICLE_WEAPON_SMOKEGRENADE",
    [1751145014] = "PICKUP_VEHICLE_WEAPON_ASSAULTSMG",
    [1852930709] = "PICKUP_PORTABLE_CRATE_UNFIXED",
    [1897726628] = "PICKUP_MONEY_PAPER_BAG",
    [2074855423] = "PICKUP_WEAPON_COMBATSHOTGUN",
    [2158727964] = "PICKUP_PORTABLE_PACKAGE",
    [2228647636] = "PICKUP_VEHICLE_WEAPON_MOLOTOV",
    [2431639355] = "PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS",
    [2499414878] = "PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW",
    [2689501965] = "PICKUP_PORTABLE_CRATE_FIXED_INCAR_WITH_PASSENGERS",
    [2773149623] = "PICKUP_VEHICLE_WEAPON_PISTOL",
    [2803366040] = "PICKUP_VEHICLE_WEAPON_GRENADE",
    [2817147086] = "PICKUP_PORTABLE_CRATE_FIXED_INCAR_SMALL",
    [2821026276] = "PICKUP_WEAPON_PRECISIONRIFLE",
    [3025681922] = "PICKUP_WEAPON_STUNGUN_MP",
    [3094015579] = "PICKUP_VEHICLE_WEAPON_MICROSMG",
    [3285027633] = "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL",
    [3430731035] = "PICKUP_VEHICLE_WEAPON_SMG",
    [3431676165] = "PICKUP_VEHICLE_WEAPON_APPISTOL",
    [3463437675] = "PICKUP_MONEY_CASE",
    [3500855031] = "PICKUP_VEHICLE_WEAPON_COMBATPISTOL",
    [3550712678] = "PICKUP_VEHICLE_WEAPON_PISTOL50",
    [3708929359] = "PICKUP_WEAPON_FERTILIZERCAN",
    [3732468094] = "PICKUP_MONEY_SECURITY_CASE",
    [3782592152] = "PICKUP_GANG_ATTACK_MONEY",
    [3812460080] = "PICKUP_CAMERA",
    [3889104844] = "PICKUP_SUBMARINE",
    [3993904883] = "PICKUP_PORTABLE_CRATE_FIXED_INCAR",
    [4263048111] = "PICKUP_MONEY_VARIABLE",
    [4284229131] = "PICKUP_WEAPON_EMPLAUNCHER",
}
```

## Full hash list

```lua
{
    [1850631618] = "PICKUP_WEAPON_BULLPUPSHOTGUN",
    [1948018762] = "PICKUP_WEAPON_ASSAULTSMG",
    [1751145014] = "PICKUP_VEHICLE_WEAPON_ASSAULTSMG",
    [1817941018] = "PICKUP_WEAPON_PISTOL50",
    [3550712678] = "PICKUP_VEHICLE_WEAPON_PISTOL50",
    [1426343849] = "PICKUP_AMMO_BULLET_MP",
    [4187887056] = "PICKUP_AMMO_MISSILE_MP",
    [2753668402] = "PICKUP_AMMO_GRENADELAUNCHER_MP",
    [4080829360] = "PICKUP_WEAPON_ASSAULTRIFLE",
    [3748731225] = "PICKUP_WEAPON_CARBINERIFLE",
    [2998219358] = "PICKUP_WEAPON_ADVANCEDRIFLE",
    [2244651441] = "PICKUP_WEAPON_MG",
    [2995980820] = "PICKUP_WEAPON_COMBATMG",
    [4264178988] = "PICKUP_WEAPON_SNIPERRIFLE",
    [1765114797] = "PICKUP_WEAPON_HEAVYSNIPER",
    [496339155] = "PICKUP_WEAPON_MICROSMG",
    [978070226] = "PICKUP_WEAPON_SMG",
    [1274757841] = "PICKUP_ARMOUR_STANDARD",
    [1295434569] = "PICKUP_WEAPON_RPG",
    [792114228] = "PICKUP_WEAPON_MINIGUN",
    [2406513688] = "PICKUP_HEALTH_STANDARD",
    [2838846925] = "PICKUP_WEAPON_PUMPSHOTGUN",
    [2528383651] = "PICKUP_WEAPON_SAWNOFFSHOTGUN",
    [2459552091] = "PICKUP_WEAPON_ASSAULTSHOTGUN",
    [1577485217] = "PICKUP_WEAPON_GRENADE",
    [768803961] = "PICKUP_WEAPON_MOLOTOV",
    [483787975] = "PICKUP_WEAPON_SMOKEGRENADE",
    [2081529176] = "PICKUP_WEAPON_STICKYBOMB",
    [4189041807] = "PICKUP_WEAPON_PISTOL",
    [2305275123] = "PICKUP_WEAPON_COMBATPISTOL",
    [996550793] = "PICKUP_WEAPON_APPISTOL",
    [779501861] = "PICKUP_WEAPON_GRENADELAUNCHER",
    [4263048111] = "PICKUP_MONEY_VARIABLE",
    [3782592152] = "PICKUP_GANG_ATTACK_MONEY",
    [4246083230] = "PICKUP_WEAPON_STUNGUN",
    [3332236287] = "PICKUP_WEAPON_PETROLCAN",
    [663586612] = "PICKUP_WEAPON_KNIFE",
    [1587637620] = "PICKUP_WEAPON_NIGHTSTICK",
    [693539241] = "PICKUP_WEAPON_HAMMER",
    [2179883038] = "PICKUP_WEAPON_BAT",
    [2297080999] = "PICKUP_WEAPON_GolfClub",
    [2267924616] = "PICKUP_WEAPON_CROWBAR",
    [738282662] = "PICKUP_CUSTOM_SCRIPT",
    [3812460080] = "PICKUP_CAMERA",
    [2158727964] = "PICKUP_PORTABLE_PACKAGE",
    [1852930709] = "PICKUP_PORTABLE_CRATE_UNFIXED",
    [1651898027] = "PICKUP_PORTABLE_PACKAGE_LARGE_RADIUS",
    [1263688126] = "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR",
    [2431639355] = "PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS",
    [68603185] = "PICKUP_PORTABLE_CRATE_UNFIXED_INAIRVEHICLE_WITH_PASSENGERS_UPRIGHT",
    [79909481] = "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_WITH_PASSENGERS",
    [2689501965] = "PICKUP_PORTABLE_CRATE_FIXED_INCAR_WITH_PASSENGERS",
    [2817147086] = "PICKUP_PORTABLE_CRATE_FIXED_INCAR_SMALL",
    [3285027633] = "PICKUP_PORTABLE_CRATE_UNFIXED_INCAR_SMALL",
    [2499414878] = "PICKUP_PORTABLE_CRATE_UNFIXED_LOW_GLOW",
    [3463437675] = "PICKUP_MONEY_CASE",
    [1575005502] = "PICKUP_MONEY_WALLET",
    [513448440] = "PICKUP_MONEY_PURSE",
    [545862290] = "PICKUP_MONEY_DEP_BAG",
    [341217064] = "PICKUP_MONEY_MED_BAG",
    [1897726628] = "PICKUP_MONEY_PAPER_BAG",
    [3732468094] = "PICKUP_MONEY_SECURITY_CASE",
    [3500855031] = "PICKUP_VEHICLE_WEAPON_COMBATPISTOL",
    [3431676165] = "PICKUP_VEHICLE_WEAPON_APPISTOL",
    [2773149623] = "PICKUP_VEHICLE_WEAPON_PISTOL",
    [2803366040] = "PICKUP_VEHICLE_WEAPON_GRENADE",
    [2228647636] = "PICKUP_VEHICLE_WEAPON_MOLOTOV",
    [1705498857] = "PICKUP_VEHICLE_WEAPON_SMOKEGRENADE",
    [746606563] = "PICKUP_VEHICLE_WEAPON_STICKYBOMB",
    [160266735] = "PICKUP_VEHICLE_HEALTH_STANDARD",
    [4260266856] = "PICKUP_VEHICLE_HEALTH_STANDARD_LOW_GLOW",
    [1125567497] = "PICKUP_VEHICLE_ARMOUR_STANDARD",
    [3094015579] = "PICKUP_VEHICLE_WEAPON_MICROSMG",
    [3430731035] = "PICKUP_VEHICLE_WEAPON_SMG",
    [772217690] = "PICKUP_VEHICLE_WEAPON_SAWNOFF",
    [2780351145] = "PICKUP_VEHICLE_CUSTOM_SCRIPT",
    [83435908] = "PICKUP_VEHICLE_CUSTOM_SCRIPT_NO_ROTATE",
    [1104334678] = "PICKUP_VEHICLE_CUSTOM_SCRIPT_LOW_GLOW",
    [1704231442] = "PICKUP_VEHICLE_MONEY_VARIABLE",
    [3889104844] = "PICKUP_SUBMARINE",
    [483577702] = "PICKUP_HEALTH_SNACK",
    [1735599485] = "PICKUP_PARACHUTE",
    [544828034] = "PICKUP_AMMO_PISTOL",
    [292537574] = "PICKUP_AMMO_SMG",
    [3837603782] = "PICKUP_AMMO_RIFLE",
    [3730366643] = "PICKUP_AMMO_MG",
    [2012476125] = "PICKUP_AMMO_SHOTGUN",
    [3224170789] = "PICKUP_AMMO_SNIPER",
    [2283450536] = "PICKUP_AMMO_GRENADELAUNCHER",
    [2223210455] = "PICKUP_AMMO_RPG",
    [4065984953] = "PICKUP_AMMO_MINIGUN",
    [4199656437] = "PICKUP_WEAPON_BOTTLE",
    [3317114643] = "PICKUP_WEAPON_SNSPISTOL",
    [2633054488] = "PICKUP_WEAPON_HEAVYPISTOL",
    [157823901] = "PICKUP_WEAPON_SPECIALCARBINE",
    [2170382056] = "PICKUP_WEAPON_BULLPUPRIFLE",
    [3812817136] = "PICKUP_WEAPON_RAYPISTOL",
    [1959050722] = "PICKUP_WEAPON_RAYCARBINE",
    [1000920287] = "PICKUP_WEAPON_RAYMINIGUN",
    [2349845267] = "PICKUP_WEAPON_BULLPUPRIFLE_MK2",
    [990867623] = "PICKUP_WEAPON_DOUBLEACTION",
    [2673201481] = "PICKUP_WEAPON_MARKSMANRIFLE_MK2",
    [1572258186] = "PICKUP_WEAPON_PUMPSHOTGUN_MK2",
    [1835046764] = "PICKUP_WEAPON_REVOLVER_MK2",
    [1038697149] = "PICKUP_WEAPON_SNSPISTOL_MK2",
    [94531552] = "PICKUP_WEAPON_SPECIALCARBINE_MK2",
    [1649373715] = "PICKUP_WEAPON_PROXMINE",
    [3223238264] = "PICKUP_WEAPON_HOMINGLAUNCHER",
    [1548844439] = "PICKUP_AMMO_HOMINGLAUNCHER",
    [1393009900] = "PICKUP_WEAPON_GUSENBERG",
    [3220073531] = "PICKUP_WEAPON_DAGGER",
    [3958938975] = "PICKUP_WEAPON_VINTAGEPISTOL",
    [582047296] = "PICKUP_WEAPON_FIREWORK",
    [1983869217] = "PICKUP_WEAPON_MUSKET",
    [4180625516] = "PICKUP_AMMO_FIREWORK",
    [1613316560] = "PICKUP_AMMO_FIREWORK_MP",
    [837436873] = "PICKUP_PORTABLE_DLC_VEHICLE_PACKAGE",
    [1311775952] = "PICKUP_WEAPON_HATCHET",
    [3832418740] = "PICKUP_WEAPON_RAILGUN",
    [3201593029] = "PICKUP_WEAPON_HEAVYSHOTGUN",
    [127042729] = "PICKUP_WEAPON_MARKSMANRIFLE",
    [1601729296] = "PICKUP_WEAPON_CERAMICPISTOL",
    [2045070941] = "PICKUP_WEAPON_HAZARDCAN",
    [3392027813] = "PICKUP_WEAPON_NAVYREVOLVER",
    [2074855423] = "PICKUP_WEAPON_COMBATSHOTGUN",
    [2010690963] = "PICKUP_WEAPON_GADGETPISTOL",
    [884272848] = "PICKUP_WEAPON_MILITARYRIFLE",
    [3175998018] = "PICKUP_WEAPON_FLAREGUN",
    [3759398940] = "PICKUP_AMMO_FLAREGUN",
    [4254904030] = "PICKUP_WEAPON_KNUCKLE",
    [2329799797] = "PICKUP_WEAPON_MARKSMANPISTOL",
    [2023061218] = "PICKUP_WEAPON_COMBATPDW",
    [3993904883] = "PICKUP_PORTABLE_CRATE_FIXED_INCAR",
    [266812085] = "PICKUP_WEAPON_COMPACTRIFLE",
    [4192395039] = "PICKUP_WEAPON_DBSHOTGUN",
    [3626334911] = "PICKUP_WEAPON_MACHETE",
    [4123384540] = "PICKUP_WEAPON_MACHINEPISTOL",
    [3182886821] = "PICKUP_WEAPON_FLASHLIGHT",
    [1632369836] = "PICKUP_WEAPON_REVOLVER",
    [3722713114] = "PICKUP_WEAPON_SWITCHBLADE",
    [3167076850] = "PICKUP_WEAPON_AUTOSHOTGUN",
    [158843122] = "PICKUP_WEAPON_BATTLEAXE",
    [4041868857] = "PICKUP_WEAPON_COMPACTLAUNCHER",
    [3547474523] = "PICKUP_WEAPON_MINISMG",
    [2942905513] = "PICKUP_WEAPON_PIPEBOMB",
    [155106086] = "PICKUP_WEAPON_POOLCUE",
    [3843167081] = "PICKUP_WEAPON_WRENCH",
    [2173116527] = "PICKUP_WEAPON_ASSAULTRIFLE_MK2",
    [3185079484] = "PICKUP_WEAPON_CARBINERIFLE_MK2",
    [2837437579] = "PICKUP_WEAPON_COMBATMG_MK2",
    [4278878871] = "PICKUP_WEAPON_HEAVYSNIPER_MK2",
    [1234831722] = "PICKUP_WEAPON_PISTOL_MK2",
    [4012602256] = "PICKUP_WEAPON_SMG_MK2",
    [3432031091] = "PICKUP_WEAPON_STONE_HATCHET",
    [2226947771] = "PICKUP_WEAPON_METALDETECTOR",
    [2316705120] = "PICKUP_WEAPON_TACTICALRIFLE",
    [2821026276] = "PICKUP_WEAPON_PRECISIONRIFLE",
    [4284229131] = "PICKUP_WEAPON_EMPLAUNCHER",
    [2308161313] = "PICKUP_AMMO_EMPLAUNCHER",
    [1491498856] = "PICKUP_WEAPON_HEAVYRIFLE",
    [3279969783] = "PICKUP_WEAPON_PETROLCAN_SMALL_RADIUS",
    [3708929359] = "PICKUP_WEAPON_FERTILIZERCAN",
    [3025681922] = "PICKUP_WEAPON_STUNGUN_MP",
}
```

## Representative Matrix Rows

- **[observed] YES (portable-compatible hash)**  
  `PICKUP_PORTABLE_PACKAGE (2158727964)`  
  `CreatePickupRotate/ CreatePickup/ CreateAmbientPickup/ CreateNonNetworkedAmbientPickup` worked with collect events, while portable variants returned valid handles but no collect event in the same report.

- **[observed] NO (weapon hash)**  
  `PICKUP_WEAPON_PISTOL (4189041807)`  
  Returned spawn handles in some natives but no collect event and marked not worked.

- **[observed] Invalid-return example**  
  `PICKUP_AMMO_SMG (292537574)` showed `0` for multiple native variants, matching non-working outcome.

## Hash and Validation Clarifications

- **[observed]** `GetPickupHashFromWeapon(joaat("WEAPON_PISTOL"))` matched `joaat("PICKUP_WEAPON_PISTOL")` in your test (`-105925489`).
- **[documented]** If you already have a `PICKUP_*` hash, use it directly for `CreatePickup`/`CreatePickupRotate`.
- **[documented]** If you only have `WEAPON_*`, convert with `GetPickupHashFromWeapon` first.
- **[observed]** `modelHash` is separate from pickup identity and acts as model override/default hint; `modelHash=0` is often stable.
- **[observed]** `IsPickupWeaponObjectValid` is not a general pickup validator; it is weapon-specific.
- **[observed]** For non-weapon pickups (for example health), `IsObjectAPickup` is the relevant check.

## Open Questions

- **[hypothesis]** Exact meaning of unknown native params (`p4`, `p6`, `p8`, `p9`, `p10`) per variant.
- **[hypothesis]** Why many `PICKUP_WEAPON_*` hashes can spawn but do not emit collect events in network tests.
- **[hypothesis]** How inventory and ammo state alter collect-event eligibility.

## Suggested Next Experiments

- **[documented]** Add state-based asserts with `DoesPickupExist` and `HasPickupBeenCollected`.
- **[documented]** Run dedicated portable sequence: create -> attach -> detach -> drop event capture.
- **[documented]** Run dedicated respawn suite using regeneration/expire controls.
- **[documented]** Export matrix to CSV/JSON (`hash,name,native,returnValid,event,worked`) for diffing over time.

## References

- **[documented]** https://docs.fivem.net/docs/game-references/pickup-hashes/
- **[documented]** https://docs.fivem.net/docs/game-references/weapon-models/


