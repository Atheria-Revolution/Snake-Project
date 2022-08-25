print("Hello world, from client!")

local Toolibs = game.ReplicatedStorage:FindFirstChild("ToolibsUtils")
local MusicUtils = require(Toolibs.MusicUtil)
local cam = game.Workspace.CurrentCamera
local player = game.Players.LocalPlayer
local d = true
local UIService = game:GetService("UserInputService")

MusicUtils.Enable()

MusicUtils.LoadMusic(1)

wait(1.5)
player.Character.HumanoidRootPart.Anchored = true
repeat wait(0.1) until game.ReplicatedStorage:FindFirstChild("CamReady").Value == true
print("CamFounded")
local CamP = game.Workspace:FindFirstChild("CamPart")
if CamP then
    print("Cam Get")
    repeat cam.CameraType = Enum.CameraType.Scriptable until cam.CameraType == Enum.CameraType.Scriptable
    cam.CFrame = CamP.CFrame
    player.Character.HumanoidRootPart.Anchored = false
    player.Character.HumanoidRootPart.CFrame = CamP.CFrame + Vector3.new(0,5,0)
    player.Character.HumanoidRootPart.Anchored = true
    d = false
end


UIService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.W and d == false then
        d = true
        game.ReplicatedStorage:FindFirstChild("PlayerInput"):FireServer("Z")
        wait(0.2)
        d = false
    end
end)

UIService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.A and d == false then
        d = true
        game.ReplicatedStorage:FindFirstChild("PlayerInput"):FireServer("Q")
        wait(0.2)
        d = false
    end
end)

UIService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.S and d == false then
        d = true
        game.ReplicatedStorage:FindFirstChild("PlayerInput"):FireServer("S")
        wait(0.2)
        d = false
    end
end)

UIService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.D and d == false then
        d = true
        game.ReplicatedStorage:FindFirstChild("PlayerInput"):FireServer("D")
        wait(0.2)
        d = false
    end
end)

