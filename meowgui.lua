print("im gay")

local location1 = CFrame.new(Vector3.new(-742.771, 240.207, -450.902))
local location2 = CFrame.new(Vector3.new(-795.143, 247, -449.75))

local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.15, 0, 0.5, 0)
frame.Position = UDim2.new(0.02, 0, 0.25, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.new(1, 1, 1)
frame.Parent = gui

local function setButtonColor(button, enabled)
    if enabled then
        button.BackgroundColor3 = Color3.new(0, 1, 0)
    else
        button.BackgroundColor3 = Color3.new(1, 0, 0)
    end
end

local teleportButton = Instance.new("TextButton")
teleportButton.Text = "Toggle Teleportation"
teleportButton.Size = UDim2.new(0.8, 0, 0.1, 0)
teleportButton.Position = UDim2.new(0.1, 0, 0.1, 0)
teleportButton.Parent = frame

local fullbrightButton = Instance.new("TextButton")
fullbrightButton.Text = "Toggle Fullbright"
fullbrightButton.Size = UDim2.new(0.8, 0, 0.1, 0)
fullbrightButton.Position = UDim2.new(0.1, 0, 0.25, 0)
fullbrightButton.Parent = frame

local destroyButton = Instance.new("TextButton")
destroyButton.Text = "Destroy GUI"
destroyButton.Size = UDim2.new(0.8, 0, 0.1, 0)
destroyButton.Position = UDim2.new(0.1, 0, 0.9, 0)
destroyButton.Parent = frame

local isTeleporting = false
local isFullbright = false

local function teleportLoop()
    while isTeleporting do
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(location1)
        wait(10)
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(location2)
        wait(10)
    end
end

local function onTeleportButtonClick()
    isTeleporting = not isTeleporting
    if isTeleporting then
        teleportLoop()
    end
    setButtonColor(teleportButton, isTeleporting)
end

local function onFullbrightButtonClick()
    isFullbright = not isFullbright
    if isFullbright then
        game.Lighting.GlobalShadows = false
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        game.Lighting.Brightness = 2
    else
        game.Lighting.GlobalShadows = true
        game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        game.Lighting.Brightness = 1
    end
    setButtonColor(fullbrightButton, isFullbright)
end

local function onDestroyButtonClick()
    gui:Destroy()
end

teleportButton.MouseButton1Click:Connect(onTeleportButtonClick)
fullbrightButton.MouseButton1Click:Connect(onFullbrightButtonClick)
destroyButton.MouseButton1Click:Connect(onDestroyButtonClick)

setButtonColor(teleportButton, isTeleporting)
setButtonColor(fullbrightButton, isFullbright)

local function toggleGui()
    gui.Enabled = not gui.Enabled
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        toggleGui()
    end
end)