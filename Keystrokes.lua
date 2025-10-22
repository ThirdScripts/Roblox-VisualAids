-- Создаем ScreenGui для отображения
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PlayerControlHUD"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Функция для создания кнопок
local function createControlButtons()
    local controlsFrame = Instance.new("Frame")
    controlsFrame.Size = UDim2.new(0, 200, 0, 200)
    controlsFrame.Position = UDim2.new(0, 10, 0, 300)
    controlsFrame.BackgroundTransparency = 1
    controlsFrame.Parent = screenGui
    
    -- Функция для создания отдельных кнопок (W, A, S, D)
    local function createButton(name, position)
        local button = Instance.new("TextLabel")
        button.Size = UDim2.new(0, 50, 0, 50)
        button.Position = position
        button.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        button.BackgroundTransparency = 0.5
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.Font = Enum.Font.SourceSans
        button.TextSize = 30
        button.Text = name
        button.Parent = controlsFrame
        
        -- Добавляем закругленные углы
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 12)  -- Устанавливаем радиус углов
        corner.Parent = button
        
        return button
    end

    -- Создаем кнопки W, A, S, D с измененным расположением
    local wButton = createButton("W", UDim2.new(0, 75, 0, 25))    -- W на верхней части
    local aButton = createButton("A", UDim2.new(0, 25, 0, 75))    -- A на левой стороне
    local sButton = createButton("S", UDim2.new(0, 75, 0, 75))    -- S между A и D
    local dButton = createButton("D", UDim2.new(0, 125, 0, 75))   -- D на правой стороне

    return wButton, aButton, sButton, dButton, controlsFrame
end

-- Создаем кнопки управления и сам Frame для перемещения
local wButton, aButton, sButton, dButton, controlsFrame = createControlButtons()

-- Массив для отслеживания состояния клавиш (нажата или нет)
local keyState = {
    [Enum.KeyCode.W] = false,
    [Enum.KeyCode.A] = false,
    [Enum.KeyCode.S] = false,
    [Enum.KeyCode.D] = false
}

-- Функция для отслеживания нажатий клавиш
local function updateButtonPress(key)
    keyState[key] = true  -- Устанавливаем состояние клавиши как "нажата"
    
    if key == Enum.KeyCode.W then
        wButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Белый фон для W
    elseif key == Enum.KeyCode.A then
        aButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Белый фон для A
    elseif key == Enum.KeyCode.S then
        sButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Белый фон для S
    elseif key == Enum.KeyCode.D then
        dButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)  -- Белый фон для D
    end
end

-- Функция для сброса фона на кнопках, если клавиша не нажата
local function resetButtonBackground()
    if not keyState[Enum.KeyCode.W] then
        wButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Черный фон для W
    end
    if not keyState[Enum.KeyCode.A] then
        aButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Черный фон для A
    end
    if not keyState[Enum.KeyCode.S] then
        sButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Черный фон для S
    end
    if not keyState[Enum.KeyCode.D] then
        dButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)  -- Черный фон для D
    end
end

-- Слушаем нажатия клавиш
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end  -- Если это обработано игрой (например, чат), игнорируем

    if input.UserInputType == Enum.UserInputType.Keyboard then
        -- Обновляем фон кнопки при нажатии клавиши
        updateButtonPress(input.KeyCode)
    end
end)

-- Слушаем отпускание клавиш для сброса
game:GetService("UserInputService").InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        -- Сбрасываем состояние клавиши
        keyState[input.KeyCode] = false
        -- Сбрасываем фон на кнопке, когда клавиша отпускается
        resetButtonBackground()
    end
end)

-- Перемещение HUD
local dragging = false
local dragInput
local dragStart
local startPos

controlsFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = controlsFrame.Position
    end
end)

controlsFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        controlsFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

controlsFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
