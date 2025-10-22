local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ESP_GUI"
screenGui.Parent = localPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0.3, 0, 0.4, 0)
frame.Position = UDim2.new(0.35, 0, 0.5, 0)
frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
frame.BorderSizePixel = 2
frame.Active = true 
frame.Draggable = true 
frame.Parent = screenGui

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0.8, 0, 0.15, 0)
textBox.Position = UDim2.new(0.1, 0, 0.05, 0)
textBox.PlaceholderText = "Enter object name"
textBox.Text = ""
textBox.Font = Enum.Font.SourceSans
textBox.TextScaled = true
textBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
textBox.TextColor3 = Color3.new(1, 1, 1)
textBox.Parent = frame

local function createSlider(labelText, positionY, defaultValue)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(0.8, 0, 0.1, 0)
    sliderFrame.Position = UDim2.new(0.1, 0, positionY, 0)
    sliderFrame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    sliderFrame.Parent = frame

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.3, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.Text = labelText
    label.Font = Enum.Font.SourceSans
    label.TextScaled = true
    label.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Parent = sliderFrame

    local slider = Instance.new("TextBox")
    slider.Size = UDim2.new(0.7, 0, 1, 0)
    slider.Position = UDim2.new(0.3, 0, 0, 0)
    slider.Text = tostring(defaultValue)
    slider.Font = Enum.Font.SourceSans
    slider.TextScaled = true
    slider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
    slider.TextColor3 = Color3.new(1, 1, 1)
    slider.Parent = sliderFrame

    return slider
end

local redSlider = createSlider("Red", 0.25, 255)
local greenSlider = createSlider("Green", 0.4, 0)
local blueSlider = createSlider("Blue", 0.55, 0)

local confirmButton = Instance.new("TextButton")
confirmButton.Size = UDim2.new(0.8, 0, 0.15, 0)
confirmButton.Position = UDim2.new(0.1, 0, 0.75, 0)
confirmButton.Text = "Highlight"
confirmButton.Font = Enum.Font.SourceSans
confirmButton.TextScaled = true
confirmButton.BackgroundColor3 = Color3.new(0.2, 0.4, 0.2)
confirmButton.TextColor3 = Color3.new(1, 1, 1)
confirmButton.Parent = frame

local signature = Instance.new("TextLabel")
signature.Size = UDim2.new(1, 0, 0.1, 0)
signature.Position = UDim2.new(0, 0, 0.9, 0)
signature.Text = "by: GertigetrFunPay"
signature.Font = Enum.Font.SourceSans
signature.TextScaled = true
signature.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
signature.TextColor3 = Color3.new(1, 1, 1)
signature.Parent = frame

local function createHighlight(target, color)
    if not target:FindFirstChild("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Adornee = target
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = color 
        highlight.FillTransparency = 0.5 
        highlight.OutlineColor = Color3.new(1, 1, 1) 
        highlight.OutlineTransparency = 0 
        highlight.Parent = target
    end
end

local function updateHighlights(targetName, color)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == targetName then
            createHighlight(obj, color)
        end
    end
end

confirmButton.MouseButton1Click:Connect(function()
    local targetName = textBox.Text
    if targetName ~= "" then
        
        local red = tonumber(redSlider.Text) or 255
        local green = tonumber(greenSlider.Text) or 0
        local blue = tonumber(blueSlider.Text) or 0
        local color = Color3.new(red / 255, green / 255, blue / 255)

        
        updateHighlights(targetName, color)
    end
end)
