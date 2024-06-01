local recoilPresets = {
    {strength = 4, horizontalStrength = 0, description = "低"}, -- 低後坐力預設 (Low recoil preset)
}

local selectedPresetIndex = 1
local noRecoilEnabled = true -- 無後坐力功能是否啟用，預設為啟用 (No recoil functionality enabled by default)

-- <===============~~Functions~~===============>
function OnEvent(event, arg)
    OutputLogMessage("event = %s, arg = %s\n", event, arg)

    if (event == "PROFILE_ACTIVATED") then
        EnablePrimaryMouseButtonEvents(true)
    end

    -- 當側邊按鈕 7 被按下時，切換無後坐力功能的啟用或關閉狀態
    -- Toggle the no-recoil functionality on or off when side button 7 is pressed
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 7) then
        noRecoilEnabled = not noRecoilEnabled
        if (noRecoilEnabled) then
            OutputLogMessage("[+] No recoil is on\n") -- 無後坐力功能已啟用 (No recoil functionality is on)
        else
            OutputLogMessage("[-] No recoil is off\n") -- 無後坐力功能已關閉 (No recoil functionality is off)
        end
    end

    -- 當滑鼠按鍵 4 被按下時，切換後坐力預設
    -- Switch between recoil presets when mouse button 4 is pressed
    if (event == "MOUSE_BUTTON_PRESSED" and arg == 4) then
        selectedPresetIndex = (selectedPresetIndex % #recoilPresets) + 1
        OutputLogMessage("[+] Selected recoil preset: %s\n", recoilPresets[selectedPresetIndex].description) -- 已選擇的後坐力預設 (Selected recoil preset)
    end

    -- 執行無後坐力功能
    -- Execute the no-recoil functionality
    if (noRecoilEnabled and event == "MOUSE_BUTTON_PRESSED" and arg == 1 and IsMouseButtonPressed(1) and IsMouseButtonPressed(3)) then
        local recoil = recoilPresets[selectedPresetIndex]
        repeat
            MoveMouseRelative(recoil.horizontalStrength, recoil.strength)
            Sleep(37)  -- 增加等待時間至 37 毫秒以減慢下降速度 (Increase the wait time to 37 milliseconds to slow down the descent speed)
        until not (IsMouseButtonPressed(1) and IsMouseButtonPressed(3))
    end
end
