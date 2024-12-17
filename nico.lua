local HyperionUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/KainoVL/meow/refs/heads/main/uilibrary.lua"))()

local location1 = CFrame.new(Vector3.new(-742.771, 240.207, -450.902))
local location2 = CFrame.new(Vector3.new(-795.143, 247, -449.75))

local ui = HyperionUI.new("AutoFarm")

local isTeleporting = false
local isFullbright = false

local mainTab = ui:NewTab("Main")
task.wait(0.1)

ui:CreateToggle(mainTab, "Auto Teleport", "teleports between 2 locations to stop ncio antiafk", false, function(state)
    isTeleporting = state
    
    if isTeleporting then
        spawn(function()
            while isTeleporting do
                if not isTeleporting then break end
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(location1)
                task.wait(10)
                if not isTeleporting then break end
                game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(location2)
                task.wait(10)
            end
        end)
    end
end)
task.wait(0.1)

ui:CreateToggle(mainTab, "Fullbright", "enables fullbright", false, function(state)
    isFullbright = state
    
    if isFullbright then
        game.Lighting.GlobalShadows = false
        game.Lighting.Ambient = Color3.new(1, 1, 1)
        game.Lighting.Brightness = 2
    else
        game.Lighting.GlobalShadows = true
        game.Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
        game.Lighting.Brightness = 1
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightControl then
        ui:Toggle()
    end
end)
