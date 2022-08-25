--[[ print("Hello world, from server!")
local Toolibs = game.ReplicatedStorage:FindFirstChild("ToolibsUtils")

print("Testing InstanceUtil")
local object = InstanceUtil.Instanciate("SpawnLocation", game.Workspace, {["Name"] = "Door", ["Size"] = Vector3.new(2,2,2), ["Anchored"] = true, ["TopSurface"] = Enum.SurfaceType.Smooth, ["BottomSurface"] = Enum.SurfaceType.Smooth, ["Position"] = Vector3.new(0,0,0)})
wait(2)
InstanceUtil.ChangeProperties(object, {["Color"] = Color3.fromRGB(255, 0, 0), ["Size"] = Vector3.new(4,4,4)})
wait(2)
local f = InstanceUtil.Instanciate("Folder", game.Workspace, {["Name"] = "PartFolder"})
for i = 1, 500 do
    InstanceUtil.Instanciate("Part", f, {["Name"] = "GeneratedPart", ["Size"] = Vector3.new(math.random(1,50), math.random(1,50), math.random(1,50)), ["Position"] = Vector3.new(math.random(-200,200), math.random(-200,200), math.random(-200,200)), ["TopSurface"] = Enum.SurfaceType.Smooth, ["BottomSurface"] = Enum.SurfaceType.Smooth, ["Color"] = Color3.new(math.random(1,255),math.random(1,255),math.random(1,255)), ["Anchored"] = true})
    wait()
end
wait(1)
InstanceUtil.Weld(object, f)
local T = game.TweenService:Create(object, TweenInfo.new(15, Enum.EasingStyle.Elastic, Enum.EasingDirection.InOut, 0, false, 0), {CFrame = object.CFrame + Vector3.new(math.random(-255,255), math.random(-255,255), math.random(-255,255))})
T:Play() ]]--


local Toolibs = game.ReplicatedStorage:FindFirstChild("ToolibsUtils")
local ModuleUtil = require(Toolibs.ModuleLoaderUtil)
local InstanceUtil = require(Toolibs.InstanceUtil)
local CamReady = InstanceUtil.Instanciate("BoolValue", game.ReplicatedStorage, {["Name"] = "CamReady", ["Value"] = false})
local CanStart = InstanceUtil.Instanciate("BoolValue", game.ReplicatedStorage, {["Name"] = "CanStart", ["Value"] = false})
local SnakeLenght = InstanceUtil.Instanciate("NumberValue", game.ReplicatedStorage, {["Name"] = "SnakeLenght", ["Value"] = 2})
local InputRemote = InstanceUtil.Instanciate("RemoteEvent", game.ReplicatedStorage, {["Name"] = "PlayerInput"})
local CurrentInput = InstanceUtil.Instanciate("StringValue", game.ReplicatedStorage, {["Name"] = "CurrentInput", ["Value"] = "D"})

ModuleUtil.Load(script, true)

InputRemote.OnServerEvent:Connect(function(player, direction)
    CurrentInput.Value = direction
    CanStart.Value = true
end)