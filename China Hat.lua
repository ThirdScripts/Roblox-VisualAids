local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Функция для создания конуса
local function createCone(character)
    local head = character:FindFirstChild("Head")
    if not head then return end

    local cone = Instance.new("Part")
    cone.Size = Vector3.new(1, 1, 1)
    cone.BrickColor = BrickColor.new("White")
    cone.Transparency = 0.3
    cone.Anchored = false
    cone.CanCollide = false

    local mesh = Instance.new("SpecialMesh", cone)
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId = "rbxassetid://1033714"
    mesh.Scale = Vector3.new(1.7, 1.1, 1.7)

    local weld = Instance.new("Weld")
    weld.Part0 = head
    weld.Part1 = cone
    weld.C0 = CFrame.new(0, 0.9, 0)

    cone.Parent = character
    weld.Parent = cone

    local highlight = Instance.new("Highlight", cone)
    highlight.FillColor = Color3.fromRGB(255, 105, 180)
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.fromRGB(255, 105, 180)
    highlight.OutlineTransparency = 0
end

-- Пересоздаем конус после респавна
local function onCharacterAdded(character)
    character:WaitForChild("Head")
    createCone(character)
end

player.CharacterAdded:Connect(onCharacterAdded)

-- Если персонаж уже существует
if player.Character then
    onCharacterAdded(player.Character)
end
