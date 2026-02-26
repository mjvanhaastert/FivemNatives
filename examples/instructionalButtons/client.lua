local function loadInstructionalScaleform()
    -- Load the GTA/FiveM instructional button scaleform before use.
    local handle = RequestScaleformMovie("INSTRUCTIONAL_BUTTONS")
    while not HasScaleformMovieLoaded(handle) do
        Wait(0)
    end
    return handle
end

local function setSlot(scaleformHandle, slotIndex, control, label)
    -- Add one button + label row to the instructional overlay.
    -- `control` uses FiveM control IDs and respects active keybinds.
    PushScaleformMovieFunction(scaleformHandle, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(slotIndex)
    PushScaleformMovieMethodParameterButtonName(GetControlInstructionalButton(2, control, true))
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(label)
    EndTextCommandScaleformString()
    PopScaleformMovieFunctionVoid()
end

local function buildInstructionalScaleform()
    local scaleformHandle = loadInstructionalScaleform()

    PushScaleformMovieFunction(scaleformHandle, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleformHandle, "TOGGLE_MOUSE_BUTTONS")
    PushScaleformMovieFunctionParameterBool(false)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleformHandle, "CREATE_CONTAINER")
    PopScaleformMovieFunctionVoid()

    -- Demo controls:
    -- 38 = confirm/action, 194 = back (frontend), 177 = toggle/cancel style input.
    setSlot(scaleformHandle, 0, 38, "Confirm")
    setSlot(scaleformHandle, 1, 194, "Back")
    setSlot(scaleformHandle, 2, 177, "Toggle")

    PushScaleformMovieFunction(scaleformHandle, "DRAW_INSTRUCTIONAL_BUTTONS")
    PushScaleformMovieFunctionParameterInt(0)
    PopScaleformMovieFunctionVoid()

    return scaleformHandle
end

local function applyHudPosition(position)
    -- Position argument is reserved for future expansion.
    -- Current test layout draws at a fixed top-left offset.
    SetScriptGfxAlign(string.byte("L"), string.byte("T"))
    SetScriptGfxAlignParams(-0.8, -0.95, 0.0, 0.0) --this is top left of the corner
end

function ShowTestInstructionalButtons(position, durationMs)
    -- Public helper to render the instructional overlay for a limited duration.
    local duration = tonumber(durationMs) or 10000

    CreateThread(function()
        local scaleformHandle = buildInstructionalScaleform()
        local endTime = GetGameTimer() + duration

        while GetGameTimer() < endTime do
            Wait(0)
            applyHudPosition(position)
            DrawScaleformMovieFullscreen(scaleformHandle, 255, 255, 255, 255, 0)
            ResetScriptGfxAlign()
        end

        SetScaleformMovieAsNoLongerNeeded(scaleformHandle)
    end)
end

RegisterCommand("sentinel_testbuttons", function(_source, args, _raw)
    -- Usage:
    -- /sentinel_testbuttons [position] [durationMs]
    -- position: top-left | top-right | bottom-left | bottom-right
    ShowTestInstructionalButtons(args[1], args[2])
end, false)