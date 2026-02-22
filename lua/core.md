local table = {
    invBusy = true,
    invHotkeys = false,
}

local stringValueLenght =  "value123"

local tableJson = json.encode(table)
local stringValueJson = json.encode(stringValueLenght)

print(#tableJson..' byte - '..#stringValueJson..' byte')


local modelString = "s_m_m_fiboffice_01"
local modelHash = joaat(modelString) // or you can use `modelString` but this not something i like as its hard to then see whats happning. joaat -> transforms into -> hash numbers
print(modelHash)