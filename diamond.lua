-- 💎 DIAMOND HUB v3.0 - Trade Controller Style
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DiamondHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- ============= ГЛАВНЫЙ ФРЕЙМ =============
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 420)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- Стеклоэффект
local glass = Instance.new("Frame")
glass.Size = UDim2.new(1, 0, 1, 0)
glass.BackgroundColor3 = Color3.fromRGB(60, 40, 100)
glass.BackgroundTransparency = 0.85
glass.BorderSizePixel = 0
glass.Parent = mainFrame

-- ============= ЗАГОЛОВОК =============
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(80, 40, 140)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -50, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "💎 DIAMOND HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 35, 0, 35)
closeBtn.Position = UDim2.new(1, -40, 0, 5)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 90)
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    floatBtn.Visible = true
end)

-- ============= ВКЛАДКИ =============
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 40)
tabFrame.Position = UDim2.new(0, 0, 0, 45)
tabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
tabFrame.BackgroundTransparency = 0.3
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabs = {"KILLER", "SHERIFF", "ESP", "MISC"}
local tabButtons = {}
local tabContents = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#tabs, 0, 1, 0)
    btn.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(200, 180, 255)
    btn.TextScaled = true
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tabFrame
    tabButtons[tabName] = btn
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, 0, 1, -85)
    content.Position = UDim2.new(0, 0, 0, 85)
    content.BackgroundTransparency = 1
    content.ScrollBarThickness = 0
    content.Visible = (i == 1)
    content.Parent = mainFrame
    tabContents[tabName] = content
end

-- ============= ФУНКЦИИ ЭЛЕМЕНТОВ =============

-- ТОГГЛ
local function createToggle(text, parent, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(220, 200, 255)
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 60, 0, 28)
    toggle.Position = UDim2.new(1, -65, 0.5, -14)
    toggle.Text = default and "ON" or "OFF"
    toggle.TextColor3 = default and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    toggle.TextScaled = true
    toggle.BackgroundColor3 = default and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(100, 40, 40)
    toggle.BackgroundTransparency = 0.2
    toggle.BorderSizePixel = 0
    toggle.Font = Enum.Font.GothamBold
    toggle.Parent = frame
    
    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = state and "ON" or "OFF"
        toggle.TextColor3 = state and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        toggle.BackgroundColor3 = state and Color3.fromRGB(40, 100, 40) or Color3.fromRGB(100, 40, 40)
        print(text .. ": " .. (state and "ON" or "OFF"))
    end)
    return frame
end

-- СЛАЙДЕР
local function createSlider(text, parent, min, max, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 50)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.4, 0)
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(200, 180, 255)
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Parent = frame
    
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.8, 0, 0.15, 0)
    slider.Position = UDim2.new(0, 0, 0.6, 0)
    slider.BackgroundColor3 = Color3.fromRGB(60, 40, 100)
    slider.BorderSizePixel = 0
    slider.Parent = frame
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(150, 80, 200)
    fill.BorderSizePixel = 0
    fill.Parent = slider
    
    local value = default
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            local x = (input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
            value = math.floor(min + (max-min) * math.clamp(x, 0, 1))
            fill.Size = UDim2.new((value-min)/(max-min), 0, 1, 0)
            label.Text = text .. ": " .. tostring(value)
        end
    end)
    return frame
end

-- КНОПКА
local function createButton(text, parent, color, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 45)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0.8, 0)
    btn.Position = UDim2.new(0.05, 0, 0.1, 0)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.BackgroundColor3 = color or Color3.fromRGB(100, 40, 160)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    
    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(150, 60, 200)
        task.wait(0.1)
        btn.BackgroundColor3 = color or Color3.fromRGB(100, 40, 160)
        if callback then callback() end
    end)
    return frame
end

-- ============= ЗАПОЛНЯЕМ ВКЛАДКИ =============

-- KILLER
createToggle("Auto Stab", tabContents["KILLER"], false)
createToggle("Speed on Kill", tabContents["KILLER"], false)
createToggle("Invisibility", tabContents["KILLER"], false)
createButton("🔪 KILL ALL", tabContents["KILLER"], Color3.fromRGB(160, 40, 40), function()
    print("Kill All activated!")
end)

-- SHERIFF
createToggle("Murder Shot", tabContents["SHERIFF"], false)
createToggle("Auto Aim", tabContents["SHERIFF"], false)
createToggle("Fast Reload", tabContents["SHERIFF"], false)
createButton("🔫 MURDER SHOT", tabContents["SHERIFF"], Color3.fromRGB(40, 80, 160), function()
    print("Murder Shot fired!")
end)

-- ESP
createToggle("Box ESP", tabContents["ESP"], false)
createToggle("Name ESP", tabContents["ESP"], false)
createToggle("Health Bar", tabContents["ESP"], false)
createToggle("Distance", tabContents["ESP"], false)
createToggle("Tracer", tabContents["ESP"], false)
createSlider("ESP Range", tabContents["ESP"], 50, 300, 150)

-- MISC
createToggle("Speed Boost", tabContents["MISC"], false)
createSlider("Speed", tabContents["MISC"], 16, 25, 20)
createToggle("B-Hop", tabContents["MISC"], false)
createToggle("Fly Mode", tabContents["MISC"], false)
createToggle("No Clip", tabContents["MISC"], false)
createToggle("Auto Pickup", tabContents["MISC"], false)

-- ============= ПЕРЕКЛЮЧЕНИЕ ВКЛАДОК =============
for tab, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        for t, content in pairs(tabContents) do
            content.Visible = (t == tab)
        end
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
            b.BackgroundTransparency = 0.2
        end
        btn.BackgroundColor3 = Color3.fromRGB(100, 40, 160)
        btn.BackgroundTransparency = 0
    end)
end
tabButtons["KILLER"].BackgroundColor3 = Color3.fromRGB(100, 40, 160)
tabButtons["KILLER"].BackgroundTransparency = 0

-- ============= PANIC КНОПКА =============
local panicBtn = Instance.new("TextButton")
panicBtn.Size = UDim2.new(0, 70, 0, 35)
panicBtn.Position = UDim2.new(0.5, -35, 1, -45)
panicBtn.Text = "🛑 PANIC"
panicBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
panicBtn.TextScaled = true
panicBtn.BackgroundColor3 = Color3.fromRGB(120, 40, 40)
panicBtn.BackgroundTransparency = 0.2
panicBtn.BorderSizePixel = 0
panicBtn.Font = Enum.Font.GothamBold
panicBtn.Parent = mainFrame
panicBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    floatBtn.Visible = true
end)

-- ============= СТАТУС БАР =============
local statusBar = Instance.new("TextLabel")
statusBar.Size = UDim2.new(1, 0, 0, 25)
statusBar.Position = UDim2.new(0, 0, 1, -25)
statusBar.Text = "💎 Diamond Hub v3.0 | Готов"
statusBar.TextColor3 = Color3.fromRGB(200, 180, 255)
statusBar.TextScaled = true
statusBar.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
statusBar.BackgroundTransparency = 0.5
statusBar.BorderSizePixel = 0
statusBar.Font = Enum.Font.Gotham
statusBar.Parent = mainFrame

-- ============= ПЛАВАЮЩАЯ КНОПКА 💎 =============
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 55, 0, 55)
floatBtn.Position = UDim2.new(0.85, 0, 0.8, 0)
floatBtn.Text = "💎"
floatBtn.TextSize = 30
floatBtn.BackgroundColor3 = Color3.fromRGB(100, 40, 160)
floatBtn.BackgroundTransparency = 0.2
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.BorderSizePixel = 0
floatBtn.Parent = screenGui

floatBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    floatBtn.Visible = false
end)

print("💎 Diamond Hub v3.0 загружен!")
print("Нажми 💎 для открытия меню")
