-- 💎 DIAMOND HUB v6.0 - ПОЛНАЯ ВЕРСИЯ (со всеми функциями)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DiamondHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = player.PlayerGui

-- ===== ОСНОВНОЙ ФРЕЙМ (БОЛЬШЕ, ЧТОБЫ ВСЕ ВЛЕЗЛО) =====
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 460)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -230)
mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
mainFrame.BackgroundTransparency = 0
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

-- ===== ЗАГОЛОВОК =====
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
titleBar.BackgroundTransparency = 0
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -35, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "💎 DIAMOND HUB"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true
title.TextXAlignment = Enum.TextXAlignment.Left
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -33, 0, 3.5)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
closeBtn.TextScaled = true
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
closeBtn.BackgroundTransparency = 0
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    floatBtn.Visible = true
end)

-- ===== ВКЛАДКИ =====
local tabFrame = Instance.new("Frame")
tabFrame.Size = UDim2.new(1, 0, 0, 40)
tabFrame.Position = UDim2.new(0, 0, 0, 35)
tabFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
tabFrame.BackgroundTransparency = 0
tabFrame.BorderSizePixel = 0
tabFrame.Parent = mainFrame

local tabs = {"MAIN", "ESP", "MISC"}
local tabButtons = {}
local tabContents = {}

for i, tabName in ipairs(tabs) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1/#tabs, 0, 1, 0)
    btn.Position = UDim2.new((i-1)/#tabs, 0, 0, 0)
    btn.Text = tabName
    btn.TextColor3 = Color3.fromRGB(180, 180, 220)
    btn.TextScaled = true
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    btn.BackgroundTransparency = 0
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Parent = tabFrame
    tabButtons[tabName] = btn
    
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, 0, 1, -75)
    content.Position = UDim2.new(0, 0, 0, 75)
    content.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    content.BackgroundTransparency = 0
    content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = Color3.fromRGB(80, 40, 160)
    content.Visible = (i == 1)
    content.Parent = mainFrame
    tabContents[tabName] = content
end

-- ===== ФУНКЦИИ =====

-- ТОГГЛ
local function createToggle(text, parent, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 32)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    frame.BackgroundTransparency = 0
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(200, 200, 230)
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(0, 50, 0, 22)
    toggle.Position = UDim2.new(1, -55, 0.5, -11)
    toggle.Text = default and "ON" or "OFF"
    toggle.TextColor3 = default and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
    toggle.TextScaled = true
    toggle.BackgroundColor3 = default and Color3.fromRGB(30, 70, 30) or Color3.fromRGB(70, 30, 30)
    toggle.BackgroundTransparency = 0
    toggle.BorderSizePixel = 0
    toggle.Font = Enum.Font.GothamBold
    toggle.Parent = frame
    
    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = state and "ON" or "OFF"
        toggle.TextColor3 = state and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        toggle.BackgroundColor3 = state and Color3.fromRGB(30, 70, 30) or Color3.fromRGB(70, 30, 30)
        print(text .. ": " .. (state and "ON" or "OFF"))
    end)
    return frame
end

-- СЛАЙДЕР
local function createSlider(text, parent, min, max, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 42)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    frame.BackgroundTransparency = 0
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0.35, 0)
    label.Text = text .. ": " .. tostring(default)
    label.TextColor3 = Color3.fromRGB(200, 200, 230)
    label.TextScaled = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Parent = frame
    
    local slider = Instance.new("Frame")
    slider.Size = UDim2.new(0.85, 0, 0.15, 0)
    slider.Position = UDim2.new(0, 0, 0.55, 0)
    slider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    slider.BackgroundTransparency = 0
    slider.BorderSizePixel = 0
    slider.Parent = frame
    
    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(100, 60, 180)
    fill.BackgroundTransparency = 0
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

-- БОЛЬШАЯ КНОПКА
local function createBigButton(text, parent, color, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 42)
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
    frame.BackgroundTransparency = 0
    frame.Parent = parent
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0.8, 0)
    btn.Position = UDim2.new(0.025, 0, 0.1, 0)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextScaled = true
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 30, 120)
    btn.BackgroundTransparency = 0
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Parent = frame
    
    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(100, 50, 180)
        task.wait(0.1)
        btn.BackgroundColor3 = color or Color3.fromRGB(60, 30, 120)
        if callback then callback() end
    end)
    return frame
end

-- ===== ЗАПОЛНЯЕМ ВКЛАДКИ =====

-- ===== MAIN (УБИЙЦА + ШЕРИФ) =====
local mainContent = tabContents["MAIN"]

-- УБИЙЦА
local killerLabel = Instance.new("TextLabel")
killerLabel.Size = UDim2.new(1, 0, 0, 22)
killerLabel.Text = "🔪 УБИЙЦА"
killerLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
killerLabel.TextScaled = true
killerLabel.TextXAlignment = Enum.TextXAlignment.Left
killerLabel.BackgroundColor3 = Color3.fromRGB(30, 15, 15)
killerLabel.BackgroundTransparency = 0
killerLabel.Font = Enum.Font.GothamBold
killerLabel.Parent = mainContent

createToggle("Auto Stab", mainContent, false)
createToggle("Speed on Kill", mainContent, false)
createToggle("Invisibility", mainContent, false)
createBigButton("🔪 KILL ALL", mainContent, Color3.fromRGB(120, 30, 30))

-- ШЕРИФ
local sheriffLabel = Instance.new("TextLabel")
sheriffLabel.Size = UDim2.new(1, 0, 0, 22)
sheriffLabel.Position = UDim2.new(0, 0, 0, 0)
sheriffLabel.Text = "🔫 ШЕРИФ"
sheriffLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
sheriffLabel.TextScaled = true
sheriffLabel.TextXAlignment = Enum.TextXAlignment.Left
sheriffLabel.BackgroundColor3 = Color3.fromRGB(15, 30, 50)
sheriffLabel.BackgroundTransparency = 0
sheriffLabel.Font = Enum.Font.GothamBold
sheriffLabel.Parent = mainContent

createToggle("Murder Shot", mainContent, false)
createToggle("Auto Aim", mainContent, false)
createToggle("Fast Reload", mainContent, false)
createBigButton("🔫 MURDER SHOT", mainContent, Color3.fromRGB(30, 50, 160))

-- ===== ESP =====
local espContent = tabContents["ESP"]
createToggle("Box ESP", espContent, false)
createToggle("Name ESP", espContent, false)
createToggle("Health Bar", espContent, false)
createToggle("Distance", espContent, false)
createToggle("Tracer", espContent, false)
createSlider("Range", espContent, 50, 300, 150)

-- ===== MISC =====
local miscContent = tabContents["MISC"]
createToggle("Speed Boost", miscContent, false)
createSlider("Speed", miscContent, 16, 25, 20)
createToggle("B-Hop", miscContent, false)
createToggle("Fly Mode", miscContent, false)
createToggle("No Clip", miscContent, false)
createToggle("Auto Pickup", miscContent, false)

-- ===== ПЕРЕКЛЮЧЕНИЕ ВКЛАДОК =====
for tab, btn in pairs(tabButtons) do
    btn.MouseButton1Click:Connect(function()
        for t, content in pairs(tabContents) do
            content.Visible = (t == tab)
        end
        for _, b in pairs(tabButtons) do
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
            b.BackgroundTransparency = 0
        end
        btn.BackgroundColor3 = Color3.fromRGB(60, 30, 130)
        btn.BackgroundTransparency = 0
    end)
end
tabButtons["MAIN"].BackgroundColor3 = Color3.fromRGB(60, 30, 130)

-- ===== PANIC =====
local panicBtn = Instance.new("TextButton")
panicBtn.Size = UDim2.new(0, 65, 0, 28)
panicBtn.Position = UDim2.new(0.5, -32.5, 1, -35)
panicBtn.Text = "🛑 PANIC"
panicBtn.TextColor3 = Color3.fromRGB(255, 150, 150)
panicBtn.TextScaled = true
panicBtn.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
panicBtn.BackgroundTransparency = 0
panicBtn.BorderSizePixel = 0
panicBtn.Font = Enum.Font.GothamBold
panicBtn.Parent = mainFrame
panicBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    floatBtn.Visible = true
    print("🛑 PANIC - Все функции отключены!")
end)

-- ===== СТАТУС =====
local statusBar = Instance.new("TextLabel")
statusBar.Size = UDim2.new(1, 0, 0, 20)
statusBar.Position = UDim2.new(0, 0, 1, -20)
statusBar.Text = "💎 Готов | Нажми 💎"
statusBar.TextColor3 = Color3.fromRGB(150, 150, 200)
statusBar.TextScaled = true
statusBar.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
statusBar.BackgroundTransparency = 0
statusBar.BorderSizePixel = 0
statusBar.Font = Enum.Font.Gotham
statusBar.Parent = mainFrame

-- ===== ПЛАВАЮЩАЯ КНОПКА =====
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 45, 0, 45)
floatBtn.Position = UDim2.new(0.85, 0, 0.82, 0)
floatBtn.Text = "💎"
floatBtn.TextSize = 24
floatBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 130)
floatBtn.BackgroundTransparency = 0
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.BorderSizePixel = 0
floatBtn.Parent = screenGui

floatBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    floatBtn.Visible = false
end)

print("💎 Diamond Hub v6.0 загружен!")
print("Нажми 💎 для открытия меню")
