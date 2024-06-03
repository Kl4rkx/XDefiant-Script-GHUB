local recoilPresets = {
    {strength = 4, horizontalStrength = -2, description = "低"}, --  (Low recoil preset)
}

local selectedPresetIndex = 1
local noRecoilEnabled = true --  (No recoil functionality enabled by default)

-- <===============~~Functions~~===============>
function OnEvent(event, arg)
    OutputLogMessage("event = %s, arg = %s\n", event, arg)

    if (event == "PROFILE_ACTIVATED") then
        EnablePrimaryMouseButtonEvents(true)
    end

    -- Toggle the no-recoil functionality on or off when side button 7 is pressed
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 7) then
        noRecoilEnabled = not noRecoilEnabled
        if (noRecoilEnabled) then
            OutputLogMessage("[+] No recoil is on\n") --  (No recoil functionality is on)
        else
            OutputLogMessage("[-] No recoil is off\n") --  (No recoil functionality is off)
        end
    end

    -- Switch between recoil presets when mouse button 4 is pressed
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 4) then
        selectedPresetIndex = (selectedPresetIndex % #recoilPresets) + 1
        OutputLogMessage("[+] Selected recoil preset: %s\n", recoilPresets[selectedPresetIndex].description) -- (Selected recoil preset)
    end

    -- Execute the no-recoil functionality
    if (noRecoilEnabled and event == "MOUSE_BUTTON_PRESSED" and arg == 1 and IsMouseButtonPressed(1) and IsMouseButtonPressed(3)) then
        local recoil = recoilPresets[selectedPresetIndex]
        repeat
            MoveMouseRelative(recoil.horizontalStrength, recoil.strength)
            Sleep(30)  -- (Increase the wait time to 37 milliseconds to slow down the descent speed)
        until not (IsMouseButtonPressed(1) and IsMouseButtonPressed(3))
    end
end
