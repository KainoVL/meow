wait(0.5)
local bb = game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
    bb:CaptureController()
    bb:ClickButton2(Vector2.new())
end)

local placeId = game.PlaceId

local games = {
    [12629753855] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/KainoVL/meow/main/meowgui.lua', true))()",
    [8387888847] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/KainoVL/meow/main/autowalk.lua', true))()",
    [16498369169] = [[
        getgenv().LoadSettings = {
            Example_Setting = Example_Value
        }
        loadstring(game:HttpGet("https://HugeGames.io/ps99"))()
    ]],
    [13772394625] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/PawsThePaw/Plutonium.AA/main/Plutonium.Loader.lua', true))()",
    [286090429] = {
        "loadstring(game:HttpGet('https://raw.githubusercontent.com/Mick-gordon/Hyper-Escape/main/Universal%20Aimbot.lua', true))()",
        "loadstring(game:HttpGet('https://raw.githubusercontent.com/Mick-gordon/Hyper-Escape/main/Universal%20Box%20ESP.lua', true))()"
    },
    [7449423635] = {
        "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()"
    }
}

local additionalPlaceIDs = {
    2753915549, 4442272183
}

local additionalPlaceIDsV2 = {
    8737899170
}

for _, id in ipairs(additionalPlaceIDs) do
    games[id] = "loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()"
end

for _, id in ipairs(additionalPlaceIDsV2) do
    games[id] = [[
        getgenv().LoadSettings = {
            Example_Setting = Example_Value
        }
        loadstring(game:HttpGet("https://HugeGames.io/ps99"))()
    ]]
end

local loadstringsOrScriptsToExecute = games[placeId]

if not loadstringsOrScriptsToExecute then
    warn("No loadstring or script found for the current game's PlaceID. Generating GUI...")
    local gui = Instance.new("ScreenGui")
    gui.Name = "GameScriptsGUI"
    gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.5, 0, 0.5, 0)
    frame.Position = UDim2.new(0.25, 0, 0.25, 0)
    frame.BackgroundColor3 = Color3.new(0, 0, 0)
    frame.BorderColor3 = Color3.new(1, 1, 1)
    frame.BorderSizePixel = 2
    frame.BackgroundTransparency = 0.7
    frame.Parent = gui

    local buttonLayout = Instance.new("UIListLayout")
    buttonLayout.Parent = frame
    buttonLayout.FillDirection = Enum.FillDirection.Vertical
    buttonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    buttonLayout.VerticalAlignment = Enum.VerticalAlignment.Center

local buttonTexts = {
    [12629753855] = "Nextbot",
    [16498369169] = "PSim99",
    [13772394625] = "Plutonium",
    [286090429] = "Arsenal",
    [7449423635] = "HoHo",
    [69] = "Infinite Yield",
    ["Accidentally Executed"] = "Accidentally Executed"
}

for gameId, buttonText in pairs(buttonTexts) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0.8, 0, 0, 50)
    button.BackgroundColor3 = Color3.new(1, 1, 1)
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.new(0, 0, 0)
    button.Text = buttonText
    button.Font = Enum.Font.SourceSansBold
    button.TextSize = 20
    button.TextColor3 = Color3.new(0, 0, 0)
    button.Parent = frame

    button.MouseButton1Click:Connect(function()
        if buttonText == "Accidentally Executed" then
            gui:Destroy()
        else
            gui:Destroy()
            if gameId == 12629753855 then
                loadstring(game:HttpGet('https://raw.githubusercontent.com/sdazerra/meow/main/meowgui.lua', true))()
            elseif gameId == 16498369169 then
                getgenv().LoadSettings = {
                    Example_Setting = Example_Value
                }
                loadstring(game:HttpGet("https://HugeGames.io/ps99"))()
            elseif gameId == 13772394625 then
                loadstring(game:HttpGet('https://raw.githubusercontent.com/PawsThePaw/Plutonium.AA/main/Plutonium.Loader.lua', true))()
            elseif gameId == 7449423635 then
                loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI'))()
            elseif gameId == 69 then
             loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
            elseif gameId == 286090429 then
                loadstring(game:HttpGet('https://raw.githubusercontent.com/Mick-gordon/Hyper-Escape/main/Universal%20Aimbot.lua', true))()
                loadstring(game:HttpGet('https://raw.githubusercontent.com/Mick-gordon/Hyper-Escape/main/Universal%20Box%20ESP.lua', true))()
            else
                warn("Button clicked! Implement desired functionality here for game ID: " .. gameId)
            end
        end
    end)
end

else
    if type(loadstringsOrScriptsToExecute) == "table" then
        for _, loadstringOrScriptToExecute in ipairs(loadstringsOrScriptsToExecute) do
            loadstring(loadstringOrScriptToExecute)()
        end
    else
        loadstring(loadstringsOrScriptsToExecute)()
    end
end
