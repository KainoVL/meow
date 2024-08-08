repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TextService = game:GetService("TextService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KainoGui"
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
    glow.Size = UDim2.new(1, 5, 1, 5)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.ZIndex = parent.ZIndex - 1
    glow.Parent = parent
end

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 550, 0, 350)
mainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
createCorner(mainFrame, 10)
createGlow(mainFrame, Color3.fromRGB(246, 54, 138))

local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topBar.BorderSizePixel = 0
topBar.Parent = mainFrame
createCorner(topBar, 10)

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0, 100, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Text = "Kaino"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = topBar

local versionLabel = Instance.new("TextLabel")
versionLabel.Name = "VersionLabel"
versionLabel.Size = UDim2.new(0, 100, 1, 0)
versionLabel.Position = UDim2.new(0, 60, 0, 0)  
versionLabel.BackgroundTransparency = 1
versionLabel.Font = Enum.Font.Gotham
versionLabel.Text = "Internal UI"
versionLabel.TextColor3 = Color3.fromRGB(246, 54, 138)
versionLabel.TextSize = 14
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.Parent = topBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundTransparency = 1
closeButton.Font = Enum.Font.GothamBold
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Parent = topBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 30, 0, 30)
minimizeButton.Position = UDim2.new(1, -60, 0, 0)  
minimizeButton.BackgroundTransparency = 1
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Text = "-"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 18
minimizeButton.Parent = topBar

local tabFrame = Instance.new("Frame")
tabFrame.Name = "TabFrame"
tabFrame.Size = UDim2.new(1, -20, 1, -40)
tabFrame.Position = UDim2.new(0, 10, 0, 35)
tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame
createCorner(tabFrame, 10)

local tabListScrollFrame = Instance.new("ScrollingFrame")
tabListScrollFrame.Name = "TabListScrollFrame"
tabListScrollFrame.Size = UDim2.new(1, -80, 0, 30)
tabListScrollFrame.Position = UDim2.new(0, 5, 0, 5)
tabListScrollFrame.BackgroundTransparency = 1
tabListScrollFrame.ScrollBarThickness = 0
tabListScrollFrame.ScrollingDirection = Enum.ScrollingDirection.X
tabListScrollFrame.Parent = tabFrame

local tabList = Instance.new("Frame")
tabList.Name = "TabList"
tabList.Size = UDim2.new(1, 0, 1, 0)
tabList.BackgroundTransparency = 1
tabList.Parent = tabListScrollFrame

local addButton = Instance.new("TextButton")
addButton.Name = "AddButton"
addButton.Size = UDim2.new(0, 25, 0, 25)
addButton.Position = UDim2.new(1, -65, 0, 7.5)
addButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
addButton.Font = Enum.Font.GothamBold
addButton.Text = "+"
addButton.TextColor3 = Color3.fromRGB(255, 255, 255)
addButton.TextSize = 14
addButton.Parent = tabFrame
createCorner(addButton, 5)

local listboxButton = Instance.new("TextButton")
listboxButton.Name = "ListboxButton"
listboxButton.Size = UDim2.new(0, 25, 0, 25)
listboxButton.Position = UDim2.new(1, -30, 0, 7.5)
listboxButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
listboxButton.Font = Enum.Font.GothamBold
listboxButton.Text = "<"
listboxButton.TextColor3 = Color3.fromRGB(255, 255, 255)
listboxButton.TextSize = 14
listboxButton.Parent = tabFrame
createCorner(listboxButton, 5)

local listbox = Instance.new("Frame")
listbox.Name = "Listbox"
listbox.Size = UDim2.new(0, 0, 1, 0)  
listbox.Position = UDim2.new(1, 0, 0, 0) 
listbox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
listbox.BorderSizePixel = 0
listbox.Visible = false 
listbox.Parent = mainFrame
createCorner(listbox, 10)
createGlow(listbox, Color3.fromRGB(255, 105, 180)) 


local listboxScrollFrame = Instance.new("ScrollingFrame")
listboxScrollFrame.Name = "ListboxScrollFrame"
listboxScrollFrame.Size = UDim2.new(1, -10, 1, -10)
listboxScrollFrame.Position = UDim2.new(0, 5, 0, 5)
listboxScrollFrame.BackgroundTransparency = 1
listboxScrollFrame.ScrollBarThickness = 6
listboxScrollFrame.Parent = listbox


local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Name = "ScrollFrame"
scrollFrame.Size = UDim2.new(1, -10, 1, -75)
scrollFrame.Position = UDim2.new(0, 5, 0, 40)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.Parent = tabFrame

local codeBox = Instance.new("TextBox")
codeBox.Name = "CodeBox"
codeBox.Size = UDim2.new(1, -6, 1, 0)
codeBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
codeBox.Font = Enum.Font.Code
codeBox.Text = "--buy kaino"
codeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
codeBox.TextSize = 14
codeBox.TextXAlignment = Enum.TextXAlignment.Left
codeBox.TextYAlignment = Enum.TextYAlignment.Top
codeBox.ClearTextOnFocus = false
codeBox.MultiLine = true
codeBox.Parent = scrollFrame
createCorner(codeBox, 5)

local pairings = {
    ['"'] = '"',
    ["'"] = "'",
    ["("] = ")",
    ["{"] = "}",
    ["["] = "]"
}

local isProcessing = false

codeBox:GetPropertyChangedSignal("Text"):Connect(function()
    if isProcessing then return end
    isProcessing = true

    local cursorPos = codeBox.CursorPosition
    local text = codeBox.Text

    if cursorPos > 1 then
        local charBefore = text:sub(cursorPos - 1, cursorPos - 1)
        if pairings[charBefore] then
            local closingChar = pairings[charBefore]
            local textAfter = text:sub(cursorPos)
            
            if textAfter == "" or textAfter:sub(1, 1) ~= closingChar then
                codeBox.Text = text:sub(1, cursorPos - 1) .. closingChar .. textAfter
                codeBox.CursorPosition = cursorPos
            end
        end
    end

    isProcessing = false
end)

local bottomBar = Instance.new("Frame")
bottomBar.Name = "BottomBar"
bottomBar.Size = UDim2.new(1, -10, 0, 30)
bottomBar.Position = UDim2.new(0, 5, 1, -35)
bottomBar.BackgroundTransparency = 1
bottomBar.Parent = tabFrame

local isMinimized = false
minimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        mainFrame.Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, topBar.Size.Y.Offset)
        tabFrame.Visible = false
    else
        mainFrame.Size = UDim2.new(0, mainFrame.Size.X.Offset, 0, 350)
        tabFrame.Visible = true
    end
end)

local function createBottomButton(name, position, text)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 70, 0, 25)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.Font = Enum.Font.Gotham
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 12
    button.Parent = bottomBar
    createCorner(button, 5)
    return button
end

local lockButton = createBottomButton("LockButton", UDim2.new(0, 0, 0, 2.5), "Lock")
local clearButton = createBottomButton("ClearButton", UDim2.new(0, 75, 0, 2.5), "Clear")
local saveButton = createBottomButton("SaveButton", UDim2.new(0, 150, 0, 2.5), "Save")
local executeButton = createBottomButton("ExecuteButton", UDim2.new(1, -75, 0, 2.5), "Execute")

local tabs = {}
local currentTab = nil

local function switchToTab(tab)
    if currentTab then
        currentTab.content = codeBox.Text
        currentTab.button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
    currentTab = tab
    codeBox.Text = tab.content
    tab.button.BackgroundColor3 = Color3.fromRGB(246, 54, 138)
end

local function updateTabPositions()
    for i, tab in ipairs(tabs) do
        tab.button.Position = UDim2.new(0, (i-1) * 105, 0, 0)
    end
    tabListScrollFrame.CanvasSize = UDim2.new(0, #tabs * 105, 0, 0)
end

local function removeTab(tab)
    for i, t in ipairs(tabs) do
        if t == tab then
            table.remove(tabs, i)
            tab.button:Destroy()
            updateTabPositions()
            break
        end
    end
    if currentTab == tab then
        if #tabs > 0 then
            switchToTab(tabs[#tabs])
        else
            currentTab = nil
            codeBox.Text = ""
        end
    end
end

local function createTab(name)
    local tab = {}
    tab.name = name
    tab.content = "--buy kaino"

    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(0, 100, 1, -5)
    tabButton.Position = UDim2.new(0, #tabs * 105, 0, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.Parent = tabList
    createCorner(tabButton, 5)  

    local closeTabButton = Instance.new("TextButton")
    closeTabButton.Name = "CloseTabButton"
    closeTabButton.Size = UDim2.new(0, 20, 0, 20)
    closeTabButton.Position = UDim2.new(1, -22, 0.5, -10)
    closeTabButton.BackgroundTransparency = 1
    closeTabButton.Font = Enum.Font.GothamBold
    closeTabButton.Text = "X"
    closeTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeTabButton.TextSize = 14
    closeTabButton.Parent = tabButton

    tabButton.MouseButton1Click:Connect(function()
        switchToTab(tab)
    end)

    closeTabButton.MouseButton1Click:Connect(function()
        removeTab(tab)
    end)

    tab.button = tabButton
    table.insert(tabs, tab)

    tabListScrollFrame.CanvasSize = UDim2.new(0, #tabs * 105, 0, 0)

    if not currentTab then
        switchToTab(tab)
    end

    return tab
end

local function refreshScriptList()
    for _, child in ipairs(listboxScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local files = listfiles("Kaino")
    for i, file in ipairs(files) do
        if isfile(file) then
            local fileName = string.match(file, "([^/\\]+)$")  
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(1, -10, 0, 30)
            button.Position = UDim2.new(0, 5, 0, (i-1) * 35)
            button.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
            button.BorderSizePixel = 0
            button.Font = Enum.Font.SourceSans
            button.TextColor3 = Color3.new(1, 1, 1)
            button.TextSize = 14
            button.Text = fileName
            button.Parent = listboxScrollFrame
            button.ZIndex = 10  

            button.MouseButton1Down:Connect(function()
                if currentTab then
                    local content = readfile(file)
                    currentTab.content = content
                    codeBox.Text = content
                else
                end
            end)

            button.MouseButton2Click:Connect(function()
                for _, child in ipairs(screenGui:GetChildren()) do
                    if child.Name == "ContextMenu" then
                        child:Destroy()
                    end
                end

                local contextMenu = Instance.new("Frame")
                contextMenu.Name = "ContextMenu"
                contextMenu.Size = UDim2.new(0, 100, 0, 90)
                contextMenu.Position = UDim2.new(0, button.AbsolutePosition.X + button.AbsoluteSize.X, 0, button.AbsolutePosition.Y)
                contextMenu.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
                contextMenu.BorderSizePixel = 0
                contextMenu.Parent = screenGui

                local function createContextButton(text, position, callback)
                    local contextButton = Instance.new("TextButton")
                    contextButton.Size = UDim2.new(1, 0, 0, 30)
                    contextButton.Position = position
                    contextButton.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
                    contextButton.BorderSizePixel = 0
                    contextButton.Font = Enum.Font.SourceSans
                    contextButton.TextColor3 = Color3.new(1, 1, 1)
                    contextButton.TextSize = 14
                    contextButton.Text = text
                    contextButton.Parent = contextMenu
                    contextButton.MouseButton1Click:Connect(callback)
                end

                createContextButton("Execute", UDim2.new(0, 0, 0, 0), function()
                    local script = readfile(file)
                    loadstring(script)()
                    contextMenu:Destroy()
                end)

                createContextButton("Load", UDim2.new(0, 0, 0, 30), function()
                    if currentTab then
                        currentTab.content = readfile(file)
                        codeBox.Text = currentTab.content
                    end
                    contextMenu:Destroy()
                end)

                createContextButton("Delete", UDim2.new(0, 0, 0, 60), function()
                    delfile(file)
                    refreshScriptList()
                    contextMenu:Destroy()
                end)

                local connection
                connection = UserInputService.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local mousePosition = UserInputService:GetMouseLocation()
                        local menuPosition = contextMenu.AbsolutePosition
                        local menuSize = contextMenu.AbsoluteSize
                        
                        if mousePosition.X < menuPosition.X or
                           mousePosition.X > menuPosition.X + menuSize.X or
                           mousePosition.Y < menuPosition.Y or
                           mousePosition.Y > menuPosition.Y + menuSize.Y then
                            contextMenu:Destroy()
                            if connection then
                                connection:Disconnect()
                            end
                        end
                    end
                end)
            end)
        end
    end

    listboxScrollFrame.CanvasSize = UDim2.new(0, 0, 0, #files * 35)
end

local listboxOpen = false

local function toggleListbox()
    listboxOpen = not listboxOpen
    
    local targetSize
    local targetRotation
    if listboxOpen then
        listbox.Visible = true
        targetSize = UDim2.new(0, 150, 1, 0)
        targetRotation = 180
        listboxButton.Text = ">"
        refreshScriptList()  
    else
        targetSize = UDim2.new(0, 0, 1, 0)
        targetRotation = 0
        listboxButton.Text = "<"
    end
    
    local sizeTween = TweenService:Create(listbox, TweenInfo.new(0.3), {Size = targetSize})
    local rotationTween = TweenService:Create(listboxButton, TweenInfo.new(0.3), {Rotation = targetRotation})
    
    sizeTween:Play()
    rotationTween:Play()
    
    if not listboxOpen then
        sizeTween.Completed:Connect(function()
            listbox.Visible = false
        end)
    end
end

listboxButton.MouseButton1Click:Connect(toggleListbox)

local function addNewTab()
    local newTabName = "Tab " .. (#tabs + 1)
    local newTab = createTab(newTabName)
    switchToTab(newTab)
end

addButton.MouseButton1Click:Connect(addNewTab)

addNewTab()

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

local resizeButton = Instance.new("TextButton")
resizeButton.Name = "ResizeButton"
resizeButton.Size = UDim2.new(0, 20, 0, 20)
resizeButton.Position = UDim2.new(1, -20, 1, -20)
resizeButton.BackgroundTransparency = 0.5
resizeButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
resizeButton.Text = ""
resizeButton.Parent = mainFrame
createCorner(resizeButton, 5)

local resizing = false
local resizeStart = nil
local startSize = nil

resizeButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = true
        resizeStart = input.Position
        startSize = mainFrame.Size
    end
end)

resizeButton.InputChanged:Connect(function(input)
    if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - resizeStart
        local newSize = UDim2.new(
            startSize.X.Scale,
            startSize.X.Offset + delta.X,
            startSize.Y.Scale,
            startSize.Y.Offset + delta.Y
        )
        mainFrame.Size = UDim2.new(
            0,
            math.max(newSize.X.Offset, 550),
            0,
            math.max(newSize.Y.Offset, 300)
        )
        
        topBar.Size = UDim2.new(1, 0, 0, 30)
        tabFrame.Size = UDim2.new(1, -20, 1, -40)
        tabListScrollFrame.Size = UDim2.new(1, -80, 0, 30)
        scrollFrame.Size = UDim2.new(1, -10, 1, -75)
        bottomBar.Size = UDim2.new(1, -10, 0, 30)
        bottomBar.Position = UDim2.new(0, 5, 1, -35)
    end
end)

resizeButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        resizing = false
    end
end)

local function toggleUI()
    screenGui.Enabled = not screenGui.Enabled
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.Equals then
        toggleUI()
    end
end)

local function executeCode()
    if currentTab then
        currentTab.content = codeBox.Text
        local success, error = pcall(function()
            loadstring(currentTab.content)()
        end)
        
        if not success then
            warn("Error executing code: " .. error)
        end
    end
end

executeButton.MouseButton1Click:Connect(executeCode)

codeBox:GetPropertyChangedSignal("TextBounds"):Connect(function()
    scrollFrame.CanvasSize = UDim2.new(0, codeBox.TextBounds.X, 0, codeBox.TextBounds.Y)
end)

clearButton.MouseButton1Click:Connect(function()
    if currentTab then
        codeBox.Text = ""
        currentTab.content = ""
    end
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

saveButton.MouseButton1Click:Connect(function()
    if currentTab then
        local saveFrame = Instance.new("Frame")
        saveFrame.Size = UDim2.new(0, 200, 0, 100)
        saveFrame.Position = UDim2.new(0.5, -100, 0.5, -50)
        saveFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        saveFrame.Parent = screenGui
        createCorner(saveFrame, 10)

        local saveNameBox = Instance.new("TextBox")
        saveNameBox.Size = UDim2.new(0.9, 0, 0, 30)
        saveNameBox.Position = UDim2.new(0.05, 0, 0.1, 0)
        saveNameBox.Font = Enum.Font.Gotham
        saveNameBox.PlaceholderText = "Enter file name"
        saveNameBox.Text = ""
        saveNameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        saveNameBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        saveNameBox.Parent = saveFrame
        createCorner(saveNameBox, 5)

        local saveConfirmButton = Instance.new("TextButton")
        saveConfirmButton.Size = UDim2.new(0.4, 0, 0, 30)
        saveConfirmButton.Position = UDim2.new(0.3, 0, 0.6, 0)
        saveConfirmButton.Font = Enum.Font.GothamBold
        saveConfirmButton.Text = "Save"
        saveConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        saveConfirmButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        saveConfirmButton.Parent = saveFrame
        createCorner(saveConfirmButton, 5)

        saveConfirmButton.MouseButton1Click:Connect(function()
            local fileName = saveNameBox.Text
            if fileName ~= "" then
                makefolder("Kaino")
                writefile("Kaino/" .. fileName .. ".lua", currentTab.content)
                saveFrame:Destroy()
                refreshScriptList()
            end
        end)
    end
end)

lockButton.MouseButton1Click:Connect(function()
    print("not done yet meow")
end)

local function createContextMenu(tab)
    local contextMenu = Instance.new("Frame")
    contextMenu.Size = UDim2.new(0, 100, 0, 30)
    contextMenu.Position = UDim2.new(0, tab.button.AbsolutePosition.X, 0, tab.button.AbsolutePosition.Y + 30)
    contextMenu.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    contextMenu.BorderSizePixel = 0
    contextMenu.ZIndex = 10
    createCorner(contextMenu, 5)

    local deleteButton = Instance.new("TextButton")
    deleteButton.Size = UDim2.new(1, 0, 1, 0)
    deleteButton.BackgroundTransparency = 1
    deleteButton.Font = Enum.Font.Gotham
    deleteButton.Text = "Delete"
    deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    deleteButton.TextSize = 14
    deleteButton.ZIndex = 11
    deleteButton.Parent = contextMenu

    deleteButton.MouseButton1Click:Connect(function()
        removeTab(tab)
        contextMenu:Destroy()
    end)

    contextMenu.Parent = screenGui

    return contextMenu
end

for _, tab in ipairs(tabs) do
    tab.button.MouseButton2Click:Connect(function()
        local contextMenu = createContextMenu(tab)
        
        local connection
        connection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                contextMenu:Destroy()
                connection:Disconnect()
            end
        end)
    end)
end

screenGui.Enabled = true

return mainFrame