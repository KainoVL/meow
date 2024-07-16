spawn(function()
    while wait() do
        game:GetService("ReplicatedStorage").FoundFriend:FireServer(5)
    end
end)

local game = game
local players = game.Players
local whitelist = getgenv().whitelist or {}
local grassHierarchy = {
    "Unobtainium", "Quantum", "BlackHole", "Negative", "Celestial", "Moon", "Solar", "Sun", "Midas", "Rainbow",
    "Plasma", "Diamond", "Emerald", "Ruby", "Sapphire", "Amethyst", "Gold", "Silver", "Bronze", "Green"
}

local function isPlayerWhitelisted(player)
    for _, id in ipairs(whitelist) do
        if player.UserId == id then
            return true
        end
    end
    return false
end

local function setWalkSpeed(speed)
    for _, player in ipairs(players:GetPlayers()) do
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = speed
            end
        end
    end
end

local function findBestGrass()
    for _, grassType in ipairs(grassHierarchy) do
        local grassParts = Workspace.Grass:GetChildren()
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

local lastPositions = {}
local function moveWhitelistedPlayersToGrass()
    local bestGrassParts = findBestGrass()
    if #bestGrassParts == 0 then return end
    for _, player in ipairs(players:GetPlayers()) do
        if isPlayerWhitelisted(player) then
            local character = player.Character
            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoid and rootPart then
                    local currentPosition = rootPart.Position
                    local lastPosition = lastPositions[player.UserId]
                    
                    if not lastPosition or (currentPosition - lastPosition).Magnitude > 1 then
                        local randomGrass
                        local attempts = 0
                        repeat
                            randomGrass = bestGrassParts[math.random(1, #bestGrassParts)]
                            attempts = attempts + 1
                        until (attempts > 10) or (randomGrass and getPartPosition(randomGrass) and (getPartPosition(randomGrass) - currentPosition).Magnitude > 10)
                        
                        local grassPosition = getPartPosition(randomGrass)
                        if grassPosition then
                            humanoid:MoveTo(grassPosition + Vector3.new(0, 3, 0))
                            lastPositions[player.UserId] = grassPosition
                        end
                    end
                end
            end
        end
    end
end

local function areNonWhitelistedPlayersPresent()
    for _, player in ipairs(players:GetPlayers()) do
        if not isPlayerWhitelisted(player) then
            return true
        end
    end
    return false
end

local defaultSpeed = 20
local whitelistedSpeed = 100

while true do
    if areNonWhitelistedPlayersPresent() then
        setWalkSpeed(defaultSpeed)
    else
        setWalkSpeed(whitelistedSpeed)
    end
    moveWhitelistedPlayersToGrass()
    wait(1)
end
