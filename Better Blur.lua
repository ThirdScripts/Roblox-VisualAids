local blur = Instance.new("BlurEffect")
blur.Parent = game.Lighting
blur.Size = 0

local lastLookVector = workspace.CurrentCamera.CFrame.LookVector

game:GetService("RunService").RenderStepped:Connect(function()
    local cam = workspace.CurrentCamera
    local currentLookVector = cam.CFrame.LookVector
    local rotationSpeed = (currentLookVector - lastLookVector).Magnitude * 130

    blur.Size = math.clamp(rotationSpeed, 0, 20)
    lastLookVector = currentLookVector
end)
