local HyperionUI = {}
HyperionUI.__index = HyperionUI

local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
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

    createCorner(glow, 10)
    return glow
end

local function createTooltip(description)
    local tooltip = Instance.new("Frame")
    tooltip.Name = "Tooltip"
    tooltip.Size = UDim2.new(0, 200, 0, 40)
    tooltip.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tooltip.BackgroundTransparency = 0
    tooltip.Visible = false
    tooltip.ZIndex = 10
    createCorner(tooltip, 5)

    local tooltipText = Instance.new("TextLabel")
    tooltipText.Name = "TooltipText"
    tooltipText.Size = UDim2.new(1, -10, 1, -10)
    tooltipText.Position = UDim2.new(0, 5, 0, 5)
    tooltipText.BackgroundTransparency = 1
    tooltipText.Text = description
    tooltipText.TextColor3 = Color3.fromRGB(255, 255, 255)
    tooltipText.TextWrapped = true
    tooltipText.Font = Enum.Font.Gotham
    tooltipText.TextSize = 12
    tooltipText.ZIndex = 11
    tooltipText.Parent = tooltip

    return tooltip
end

local function createHelpButton(parent, description)
    if not description then return end
    
    local helpButton = Instance.new("TextButton")
    helpButton.Name = "HelpButton"
    helpButton.Size = UDim2.new(0, 20, 0, 20)
    helpButton.Position = UDim2.new(1, -30, 0.5, -10)
    helpButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    helpButton.Text = "?"
    helpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    helpButton.Font = Enum.Font.GothamBold
    helpButton.TextSize = 14
    helpButton.Parent = parent
    createCorner(helpButton, 4)

    local tooltip = createTooltip(description)
    tooltip.Parent = helpButton

    helpButton.MouseButton1Click:Connect(function()
        tooltip.Position = UDim2.new(0, -210, 0, 0)
        tooltip.Visible = not tooltip.Visible
    end)

    helpButton.MouseLeave:Connect(function()
        tooltip.Visible = false
    end)

    return helpButton
end

function HyperionUI.new(name)
    local self = setmetatable({}, HyperionUI)
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = name .. "HyperionUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    self.screenGui = screenGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 550, 0, 350)
    mainFrame.Position = UDim2.new(0.5, -275, 0.5, -175)
    mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    createCorner(mainFrame, 10)
    createGlow(mainFrame, Color3.fromRGB(111, 167, 223))
    self.mainFrame = mainFrame
    
    self.tabs = {}
    self.currentTab = nil
    
    self:_createTopBar()
    self:_createTabSystem()
    
    return self
end

function HyperionUI:_createTopBar()
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    topBar.BorderSizePixel = 0
    topBar.Parent = self.mainFrame
    createCorner(topBar, 10)
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(0, 200, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = "Hyperion UI"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
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
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextSize = 18
    closeButton.Parent = topBar

    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        self.mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.mainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
    
    closeButton.MouseButton1Click:Connect(function()
        self.screenGui:Destroy()
    end)
    
    return topBar
end

function HyperionUI:_createTabSystem()
    local tabFrame = Instance.new("Frame")
    tabFrame.Name = "TabFrame"
    tabFrame.Size = UDim2.new(1, -20, 0, 40)
    tabFrame.Position = UDim2.new(0, 10, 0, 35)
    tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabFrame.BorderSizePixel = 0
    tabFrame.Parent = self.mainFrame
    createCorner(tabFrame, 10)
    
    local tabScrollFrame = Instance.new("ScrollingFrame")
    tabScrollFrame.Name = "TabScrollFrame"
    tabScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    tabScrollFrame.BackgroundTransparency = 1
    tabScrollFrame.ScrollBarThickness = 0
    tabScrollFrame.ScrollingDirection = Enum.ScrollingDirection.X
    tabScrollFrame.Parent = tabFrame
    
    self.tabScrollFrame = tabScrollFrame
end

function HyperionUI:NewTab(name)
    local tab = {
        name = name,
        elements = {}
    }
    
    local tabButton = Instance.new("TextButton")
    tabButton.Name = name .. "Tab"
    tabButton.Size = UDim2.new(0, 100, 1, 0)
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.Text = name
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.Font = Enum.Font.Gotham
    tabButton.TextSize = 14
    tabButton.Parent = self.tabScrollFrame
    createCorner(tabButton, 5)
    
    local tabCount = #self.tabs
    tabButton.Position = UDim2.new(0, tabCount * 105, 0, 0)
    
    self.tabScrollFrame.CanvasSize = UDim2.new(0, (tabCount + 1) * 105, 0, 0)
    
    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Name = name .. "Content"
    contentFrame.Size = UDim2.new(1, -20, 1, -100)
    contentFrame.Position = UDim2.new(0, 10, 0, 80)
    contentFrame.BackgroundTransparency = 1
    contentFrame.ScrollBarThickness = 6
    contentFrame.Parent = self.mainFrame
    
    tab.button = tabButton
    tab.contentFrame = contentFrame
    
    table.insert(self.tabs, tab)
    
    tabButton.MouseButton1Click:Connect(function()
        self:SwitchTab(tab)
    end)
    
    if #self.tabs == 1 then
        self:SwitchTab(tab)
    end
    
    return setmetatable(tab, {
        __index = function(_, key)
            if key == "Button" then
                return function(...)
                    return self:CreateButton(tab, ...)
                end
            elseif key == "Toggle" then
                return function(...)
                    return self:CreateToggle(tab, ...)
                end
            elseif key == "Slider" then
                return function(...)
                    return self:CreateSlider(tab, ...)
                end
            end
        end
    })
end

function HyperionUI:SwitchTab(tab)
    for _, existingTab in ipairs(self.tabs) do
        existingTab.contentFrame.Visible = false
        existingTab.button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end
    
    tab.contentFrame.Visible = true
    tab.button.BackgroundColor3 = Color3.fromRGB(111, 167, 223)
    
    self.currentTab = tab
end

function HyperionUI:CreateButton(tab, name, description, callback)
    local button = Instance.new("TextButton")
    button.Name = name .. "Button"
    button.Size = UDim2.new(1, -10, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = tab.contentFrame
    createCorner(button, 5)
    
    local buttonCount = #tab.elements
    button.Position = UDim2.new(0, 0, 0, buttonCount * 45)
    
    tab.contentFrame.CanvasSize = UDim2.new(0, 0, 0, (buttonCount + 1) * 45)
    
    createHelpButton(button, description)
    
    button.MouseButton1Click:Connect(function()
        if button:FindFirstChild("HelpButton") and button.HelpButton:FindFirstChild("Tooltip") then
            button.HelpButton.Tooltip.Visible = false
        end
        callback()
    end)
    
    table.insert(tab.elements, button)
    
    return button
end

function HyperionUI:CreateToggle(tab, name, description, defaultState, callback)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Name = name .. "ToggleFrame"
    toggleFrame.Size = UDim2.new(1, -10, 0, 40)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    toggleFrame.Parent = tab.contentFrame
    createCorner(toggleFrame, 5)
    
    local toggleCount = #tab.elements
    toggleFrame.Position = UDim2.new(0, 0, 0, toggleCount * 45)
    
    tab.contentFrame.CanvasSize = UDim2.new(0, 0, 0, (toggleCount + 1) * 45)
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(0.7, 0, 1, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = toggleFrame
    
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(0, 40, 0, 20)
    toggleButton.Position = UDim2.new(1, -80, 0.5, -10)
    toggleButton.BackgroundColor3 = defaultState and Color3.fromRGB(111, 167, 223) or Color3.fromRGB(60, 60, 60)
    toggleButton.Parent = toggleFrame
    createCorner(toggleButton, 10)
    
    createHelpButton(toggleFrame, description)
    
    local isToggled = defaultState
    
    toggleButton.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        toggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(111, 167, 223) or Color3.fromRGB(60, 60, 60)
        callback(isToggled)
    end)
    
    table.insert(tab.elements, toggleFrame)
    
    return toggleButton
end

function HyperionUI:CreateSlider(tab, name, description, min, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Name = name .. "SliderFrame"
    sliderFrame.Size = UDim2.new(1, -10, 0, 40)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    sliderFrame.Parent = tab.contentFrame
    createCorner(sliderFrame, 5)
    
    local elementCount = #tab.elements
    sliderFrame.Position = UDim2.new(0, 0, 0, elementCount * 45)
    
    tab.contentFrame.CanvasSize = UDim2.new(0, 0, 0, (elementCount + 1) * 45)
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(0.5, -20, 1, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = sliderFrame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Name = "ValueLabel"
    valueLabel.Size = UDim2.new(0, 50, 0, 20)
    valueLabel.Position = UDim2.new(1, -90, 0.5, -10)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueLabel.Font = Enum.Font.Gotham
    valueLabel.TextSize = 14
    valueLabel.Parent = sliderFrame
    
    local sliderBg = Instance.new("Frame")
    sliderBg.Name = "SliderBackground"
    sliderBg.Size = UDim2.new(0.4, 0, 0, 6)
    sliderBg.Position = UDim2.new(0.5, -20, 0.5, -3)
    sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    sliderBg.Parent = sliderFrame
    createCorner(sliderBg, 3)
    
    local sliderFill = Instance.new("Frame")
    sliderFill.Name = "SliderFill"
    sliderFill.Size = UDim2.new((default - min)/(max - min), 0, 1, 0)
    sliderFill.BackgroundColor3 = Color3.fromRGB(111, 167, 223)
    sliderFill.Parent = sliderBg
    createCorner(sliderFill, 3)
    
    local sliderKnob = Instance.new("Frame")
    sliderKnob.Name = "SliderKnob"
    sliderKnob.Size = UDim2.new(0, 16, 0, 16)
    sliderKnob.Position = UDim2.new((default - min)/(max - min), -8, 0.5, -8)
    sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    sliderKnob.Parent = sliderBg
    createCorner(sliderKnob, 8)
    
    createHelpButton(sliderFrame, description)
    
    local UserInputService = game:GetService("UserInputService")
    local dragging = false
    
    local function updateSlider(input)
        local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * pos)
        
        sliderFill.Size = UDim2.new(pos, 0, 1, 0)
        sliderKnob.Position = UDim2.new(pos, -8, 0.5, -8)
        valueLabel.Text = tostring(value)
        
        callback(value)
    end
    
    sliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    table.insert(tab.elements, sliderFrame)
    
    return sliderFrame
end

function HyperionUI:CreateTextbox(tab, name, description, placeholder, callback)
    local textboxFrame = Instance.new("Frame")
    textboxFrame.Name = name .. "TextboxFrame"
    textboxFrame.Size = UDim2.new(1, -10, 0, 40)
    textboxFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    textboxFrame.Parent = tab.contentFrame
    createCorner(textboxFrame, 5)
    
    local elementCount = #tab.elements
    textboxFrame.Position = UDim2.new(0, 0, 0, elementCount * 45)
    
    tab.contentFrame.CanvasSize = UDim2.new(0, 0, 0, (elementCount + 1) * 45)
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Name = "NameLabel"
    nameLabel.Size = UDim2.new(0.3, 0, 1, 0)
    nameLabel.Position = UDim2.new(0, 10, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.Font = Enum.Font.Gotham
    nameLabel.TextSize = 14
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = textboxFrame
    
    local textbox = Instance.new("TextBox")
    textbox.Name = "Input"
    textbox.Size = UDim2.new(0.5, 0, 0, 25)
    textbox.Position = UDim2.new(0.35, 0, 0.5, -12.5)
    textbox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    textbox.Text = ""
    textbox.PlaceholderText = placeholder
    textbox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textbox.PlaceholderColor3 = Color3.fromRGB(180, 180, 180)
    textbox.Font = Enum.Font.Gotham
    textbox.TextSize = 14
    textbox.Parent = textboxFrame
    createCorner(textbox, 5)
    
    createHelpButton(textboxFrame, description)
    
    textbox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            callback(textbox.Text)
        end
    end)
    
    table.insert(tab.elements, textboxFrame)
    
    return textbox
end

function HyperionUI:Toggle()
    self.screenGui.Enabled = not self.screenGui.Enabled
end

function HyperionUI:SetTheme(mainColor, accentColor)
    self.mainFrame.BackgroundColor3 = mainColor
    for _, tab in ipairs(self.tabs) do
        for _, element in ipairs(tab.elements) do
            if element:IsA("Frame") or element:IsA("TextButton") then
                element.BackgroundColor3 = mainColor
            end
        end
    end
    
    for _, tab in ipairs(self.tabs) do
        if tab == self.currentTab then
            tab.button.BackgroundColor3 = accentColor
        end
        for _, element in ipairs(tab.elements) do
            local toggleButton = element:FindFirstChild("ToggleButton")
            if toggleButton and toggleButton.BackgroundColor3 == Color3.fromRGB(111, 167, 223) then
                toggleButton.BackgroundColor3 = accentColor
            end
            
            local sliderFill = element:FindFirstChild("SliderFill")
            if sliderFill then
                sliderFill.BackgroundColor3 = accentColor
            end
        end
    end
end

return HyperionUI