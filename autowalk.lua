repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GrassToucherGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
end

local function createGlow(parent, color)
    local glow = Instance.new("ImageLabel")
    glow.Name = "Glow"
    glow.BackgroundTransparency = 1
    glow.Image = "rbxassetid://5028857472"
    glow.ImageColor3 = color
    glow.ImageTransparency = 0.8
    glow.Size = UDim2.new(1, 10, 1, 10)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.ZIndex = parent.ZIndex - 1
    glow.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = glow
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 400)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
createCorner(mainFrame, 10)
createGlow(mainFrame, Color3.fromRGB(111, 167, 223))

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame
createCorner(topBar, 10)

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Grass Toucher"
titleLabel.TextColor3 = Color3.fromRGB(224, 224, 224)
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(224, 224, 224)
closeButton.TextSize = 18
closeButton.Parent = topBar

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -40)
contentFrame.Position = UDim2.new(0, 10, 0, 35)
contentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentFrame.BorderSizePixel = 0
contentFrame.Parent = mainFrame
createCorner(contentFrame, 10)

local whitelistFrame = Instance.new("Frame")
whitelistFrame.Name = "WhitelistFrame"
whitelistFrame.Size = UDim2.new(1, -20, 0, 200)
whitelistFrame.Position = UDim2.new(0, 10, 0, 140)
whitelistFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
whitelistFrame.BorderSizePixel = 0
whitelistFrame.Parent = contentFrame
createCorner(whitelistFrame, 10)

local whitelistLabel = Instance.new("TextLabel")
whitelistLabel.Name = "WhitelistLabel"
whitelistLabel.Size = UDim2.new(1, -10, 0, 30)
whitelistLabel.Position = UDim2.new(0, 5, 0, 5)
whitelistLabel.BackgroundTransparency = 1
whitelistLabel.Font = Enum.Font.GothamBold
whitelistLabel.Text = "Whitelist (ID or Username)"
whitelistLabel.TextColor3 = Color3.fromRGB(224, 224, 224)
whitelistLabel.TextSize = 14
whitelistLabel.TextXAlignment = Enum.TextXAlignment.Left
whitelistLabel.Parent = whitelistFrame

local whitelistScrollFrame = Instance.new("ScrollingFrame")
whitelistScrollFrame.Name = "WhitelistScrollFrame"
whitelistScrollFrame.Size = UDim2.new(1, -10, 1, -70)
whitelistScrollFrame.Position = UDim2.new(0, 5, 0, 40)
whitelistScrollFrame.BackgroundTransparency = 1
whitelistScrollFrame.ScrollBarThickness = 6
whitelistScrollFrame.Parent = whitelistFrame

local addWhitelistButton = Instance.new("TextButton")
addWhitelistButton.Name = "AddWhitelistButton"
addWhitelistButton.Size = UDim2.new(0, 30, 0, 30)
addWhitelistButton.Position = UDim2.new(1, -35, 0, 5)
addWhitelistButton.BackgroundColor3 = Color3.fromRGB(111, 167, 223)
addWhitelistButton.Font = Enum.Font.GothamBold
addWhitelistButton.Text = "+"
addWhitelistButton.TextColor3 = Color3.fromRGB(224, 224, 224)
addWhitelistButton.TextSize = 18
addWhitelistButton.Parent = whitelistFrame
createCorner(addWhitelistButton, 5)

local whitelistedIds = {}

local function saveConfig()
    local configString = table.concat(whitelistedIds, ",")
    writefile("Grass.txt", configString)
end

local function loadConfig()
    if isfile("Grass.txt") then
        local configRead = readfile("Grass.txt")
        whitelistedIds = {}
        for id in configRead:gmatch("[^,]+") do
            table.insert(whitelistedIds, tonumber(id))
        end
    end
end

local function updateWhitelistDisplay()
    for i, v in ipairs(whitelistScrollFrame:GetChildren()) do
        v:Destroy()
    end
    
    for i, id in ipairs(whitelistedIds) do
        local whitelistEntry = Instance.new("Frame")
        whitelistEntry.Name = "WhitelistEntry"
        whitelistEntry.Size = UDim2.new(1, -10, 0, 30)
        whitelistEntry.Position = UDim2.new(0, 5, 0, (i-1) * 35)
        whitelistEntry.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        whitelistEntry.Parent = whitelistScrollFrame
        createCorner(whitelistEntry, 5)
        
        local entryText = Instance.new("TextBox")
        entryText.Name = "EntryText"
        entryText.Size = UDim2.new(1, -35, 1, 0)
        entryText.Position = UDim2.new(0, 5, 0, 0)
        entryText.BackgroundTransparency = 1
        entryText.Font = Enum.Font.Gotham
        entryText.Text = tostring(id)
        entryText.TextColor3 = Color3.fromRGB(224, 224, 224)
        entryText.TextSize = 14
        entryText.TextXAlignment = Enum.TextXAlignment.Left
        entryText.Parent = whitelistEntry
        
        local removeButton = Instance.new("TextButton")
        removeButton.Name = "RemoveButton"
        removeButton.Size = UDim2.new(0, 30, 0, 30)
        removeButton.Position = UDim2.new(1, -30, 0, 0)
        removeButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        removeButton.Font = Enum.Font.GothamBold
        removeButton.Text = "X"
        removeButton.TextColor3 = Color3.fromRGB(224, 224, 224)
        removeButton.TextSize = 14
        removeButton.Parent = whitelistEntry
        createCorner(removeButton, 5)
        
        removeButton.MouseButton1Click:Connect(function()
            table.remove(whitelistedIds, i)
            updateWhitelistDisplay()
            saveConfig()
        end)
        
        entryText.FocusLost:Connect(function(enterPressed)
            if enterPressed then
                local newValue = entryText.Text
                if tonumber(newValue) then
                    whitelistedIds[i] = tonumber(newValue)
                else
                    local success, result = pcall(function()
                        return Players:GetUserIdFromNameAsync(newValue)
                    end)
                    if success then
                        whitelistedIds[i] = result
                        entryText.Text = tostring(result)
                    else
                        entryText.Text = tostring(whitelistedIds[i])
                    end
                end
                saveConfig()
            end
        end)
    end
    
    whitelistScrollFrame.CanvasSize = UDim2.new(0, 0, 0, #whitelistedIds * 35)
end

addWhitelistButton.MouseButton1Click:Connect(function()
    table.insert(whitelistedIds, 0)
    updateWhitelistDisplay()
    saveConfig()
end)

local walkingThreads = {}

local function isPlayerWhitelisted(player)
    for _, id in ipairs(whitelistedIds) do
        if player.UserId == id then
            return true
        end
    end
    return false
end

local function setWalkSpeed(speed)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
        end
    end
end

local function moveToGrass()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local grassParts = workspace.Grass:GetChildren()
            if #grassParts > 0 then
                local randomGrass = grassParts[math.random(1, #grassParts)]
                humanoid:MoveTo(randomGrass.Position + Vector3.new(0, 3, 0))
            end
        end
    end
end

local function areOnlyWhitelistedPlayersPresent()
    for _, player in ipairs(Players:GetPlayers()) do
        if not isPlayerWhitelisted(player) then
            return false
        end
    end
    return true
end

local function createToggleButton(name, position)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(0, 360, 0, 30)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.Gotham
    button.Text = name .. ": OFF"
    button.TextColor3 = Color3.fromRGB(224, 224, 224)
    button.TextSize = 14
    button.Parent = contentFrame
    createCorner(button, 5)
    
    local isActive = false
    
    button.MouseButton1Click:Connect(function()
        isActive = not isActive
        button.Text = name .. ": " .. (isActive and "ON" or "OFF")
        button.BackgroundColor3 = isActive and Color3.fromRGB(111, 167, 223) or Color3.fromRGB(60, 60, 60)
        
        if isActive then
            if name == "Old Walking" then
                walkingThreads[name] = task.spawn(function()
                    while task.wait(1) do
                        if not isActive then break end
                        if areOnlyWhitelistedPlayersPresent() then
                            setWalkSpeed(100)
                        else
                            setWalkSpeed(30)
                        end
                        moveToGrass()
                    end
                end)
            elseif name == "New Walking" then
                walkingThreads[name] = task.spawn(function()
                    local grassHierarchy = {
                        "Unobtainium", "Quantum", "BlackHole", "Negative", "Celestial", "Moon", "Solar", "Sun", "Midas", "Rainbow",
                        "Plasma", "Diamond", "Emerald", "Ruby", "Sapphire", "Amethyst", "Gold", "Silver", "Bronze", "Green"
                    }

                    local function findBestGrass()
                        for _, grassType in ipairs(grassHierarchy) do
                            local grassParts = workspace.Grass:GetChildren()
                            local bestGrassParts = {}
                            for _, part in ipairs(grassParts) do
                                if part.Name == grassType then
                                    table.insert(bestGrassParts, part)
                                end
                            end
                            if #bestGrassParts > 0 then
                                return bestGrassParts
                            end
                        end
                        return {}
                    end

                    local function getPartPosition(part)
                        if part:IsA("BasePart") then
                            return part.Position
                        else
                            local subPart = part:FindFirstChild(part.Name)
                            if subPart and subPart:IsA("BasePart") then
                                return subPart.Position
                            end
                        end
                        return nil
                    end

                    local lastPosition
                    local function moveToGrass()
                        local character = player.Character
                        if character then
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            local rootPart = character:FindFirstChild("HumanoidRootPart")
                            if humanoid and rootPart then
                                local currentPosition = rootPart.Position
                                
                                if not lastPosition or (currentPosition - lastPosition).Magnitude > 1 then
                                    local bestGrassParts = findBestGrass()
                                    if #bestGrassParts > 0 then
                                        local randomGrass
                                        local attempts = 0
                                        repeat
                                            randomGrass = bestGrassParts[math.random(1, #bestGrassParts)]
                                            attempts = attempts + 1
                                        until (attempts > 10) or (randomGrass and getPartPosition(randomGrass) and (getPartPosition(randomGrass) - currentPosition).Magnitude > 10)
                                        
                                        local grassPosition = getPartPosition(randomGrass)
                                        if grassPosition then
                                            humanoid:MoveTo(grassPosition + Vector3.new(0, 3, 0))
                                            lastPosition = grassPosition
                                        end
                                    end
                                end
                            end
                        end
                    end

                    while task.wait(1) do
                        if not isActive then break end
                        if areOnlyWhitelistedPlayersPresent() then
                            setWalkSpeed(100)
                        else
                            setWalkSpeed(30)
                        end
                        moveToGrass()
                    end
                end)
            elseif name == "Found Friend" then
                walkingThreads[name] = task.spawn(function()
                    while task.wait() do
                        if not isActive then break end
                        game:GetService("ReplicatedStorage").FoundFriend:FireServer(5)
                    end
                end)
            end
        else
            if walkingThreads[name] then
                task.cancel(walkingThreads[name])
                walkingThreads[name] = nil
            end
        end
    end)
    
    return button
end

createToggleButton("Old Walking", UDim2.new(0, 10, 0, 10))
createToggleButton("New Walking", UDim2.new(0, 10, 0, 50))
createToggleButton("Found Friend", UDim2.new(0, 10, 0, 90))

local dragging = false
local dragStart = nil
local startPos = nil

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

topBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

topBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

closeButton.MouseButton1Click:Connect(function()
    for _, thread in pairs(walkingThreads) do
        task.cancel(thread)
    end
    screenGui:Destroy()
end)

local function toggleUI()
    screenGui.Enabled = not screenGui.Enabled
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Equals then
        toggleUI()
    end
end)

loadConfig()
updateWhitelistDisplay()

return mainFrame