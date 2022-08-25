--= Snake Game by Danael_21 X StarShadow64 =--

local Toolibs = game.ReplicatedStorage:FindFirstChild("ToolibsUtils")
local InstanceUtil = require(Toolibs.InstanceUtil)
local tilesize = 4
local plateSize = 17
local cameraReady = game.ReplicatedStorage:FindFirstChild("CamReady")
local Folder = InstanceUtil.Instanciate("Folder", game.Workspace, {["Name"] = "SnakeInstance"})
local FirstLine = true
local WallFolder = InstanceUtil.Instanciate("Folder", game.Workspace, {["Name"] = "WallFolder"})
local CurrentInput = game.ReplicatedStorage:FindFirstChild("CurrentInput")
local SnakeHead
local GameOver = false
local CanStart = game.ReplicatedStorage:FindFirstChild("CanStart")
local SnakeLenght = game.ReplicatedStorage:FindFirstChild("SnakeLenght")
local Apple = nil

function createBoard()
    local mainTile = game.ReplicatedStorage:FindFirstChild("MTile")
    if not mainTile then
        mainTile = InstanceUtil.Instanciate("Part", game.ReplicatedStorage, {["Name"] = "MTile", ["Size"] = Vector3.new(tilesize, tilesize, tilesize), ["Anchored"] = true, ["TopSurface"] = Enum.SurfaceType.Smooth, ["BottomSurface"] = Enum.SurfaceType.Smooth, ["Color"] = Color3.fromRGB(255,255,255), ["Orientation"] = Vector3.new(0,180,0)})
    end

    local FT = InstanceUtil.CloneP(mainTile, {["Parent"] = WallFolder, ["Name"] = 1, ["Position"] = Vector3.new(-(tilesize*(plateSize/2)), 0, -(tilesize*(plateSize/2))), ["Color"] = Color3.fromRGB(77, 77, 77)})
    local SV = InstanceUtil.Instanciate("BoolValue", FT, {["Name"] = "Wall"})
    for i=1, plateSize do
        for v=1, plateSize-1 do
            if not LT then LT = FT end
            local NT = InstanceUtil.CloneP(LT, {["Name"] = tonumber(LT.Name) + 1, ["Parent"] = Folder, ["Position"] = LT.Position + Vector3.new(0,0,tilesize), ["Color"] = Color3.fromRGB(255, 255, 255)})
            if FirstLine == true then
                NT.Color = Color3.fromRGB(77,77,77)
                local SV = InstanceUtil.Instanciate("BoolValue", NT, {["Name"] = "Wall"})
                NT.Parent = WallFolder
            end
            if NT.Name == tostring(((plateSize*plateSize)/2) + 0.5) then
                print("CamReady")
                local CamP = InstanceUtil.CloneP(mainTile, {["Name"] = "CamPart", ["Parent"] = game.Workspace, ["Position"] = NT.Position + Vector3.new(0, (plateSize-5)*4, 0), ["Orientation"] = Vector3.new(-90,-90,0), ["Transparency"] = 1, ["CanCollide"] = false})
                cameraReady.Value = true
                SnakeHead = NT
                NT.Color = Color3.fromRGB(9, 131, 15)
                --NT.Name = "MiddlePart"
            end
            LT = NT
        end

        if i==plateSize then
        else
            FirstLine = false
            LT.Color = Color3.fromRGB(77,77,77)
            local SV = InstanceUtil.Instanciate("BoolValue", LT, {["Name"] = "Wall"})
            LT.Parent = WallFolder
            local NT = InstanceUtil.CloneP(LT, {["Name"] = tonumber(LT.Name) + 1, ["Parent"] = Folder, ["Position"] = Vector3.new(-(tilesize*(plateSize/2)), 0, -(tilesize*(plateSize/2))) - Vector3.new(i*tilesize,0,0), ["Color"] = Color3.fromRGB(77, 77, 77)})
            local SV2 = InstanceUtil.Instanciate("BoolValue", NT, {["Name"] = "Wall"})
            NT.Parent = WallFolder
            LT = NT
        end
        if i==plateSize-1 then
            FirstLine = true
        end
    end

    for i, finishedTiles in pairs(Folder:GetChildren()) do
        finishedTiles.Size = Vector3.new(tilesize-0.5, tilesize-0.5, tilesize-0.5)
    end
end

function FindNewHead(BasePos, Direction)
    for i, parts in pairs(Folder:GetChildren()) do
        if parts.Position == BasePos + Direction then
            return parts
        end
    end

    return nil
end



return function()
    createBoard()

    repeat wait(0.1) until CanStart.Value == true
    print("Start")
    while GameOver == false do
        wait(0.1)
        if not Apple then
            local Tiles = Folder:GetChildren()
            local r = math.random(1, #Folder:GetChildren())
            if Tiles[r] then
                local AV = InstanceUtil.Instanciate("BoolValue", Tiles[r], {["Name"] = "Apple"})
                Tiles[r].Color = Color3.fromRGB(255, 0, 0)
                Apple = Tiles[r]
            end
        end
        local Dir
        if CurrentInput.Value == "Z" then
            Dir = Vector3.new(4,0,0)
        elseif CurrentInput.Value == "S" then
            Dir = Vector3.new(-4,0,0)
        elseif CurrentInput.Value == "Q" then
            Dir = Vector3.new(0,0,-4)
        elseif CurrentInput.Value == "D" then
            Dir = Vector3.new(0,0,4)
        end

        local NewHead = FindNewHead(SnakeHead.Position, Dir)
        if NewHead then
            if NewHead:FindFirstChild("BodyScript") then
                GameOver = true
            elseif NewHead:FindFirstChild("Apple") then
                NewHead.Color = Color3.fromRGB(9, 131, 15)
                NewHead:FindFirstChild("Apple"):Destroy()
                SnakeLenght.Value = SnakeLenght.Value + 1
                Apple = nil
                SnakeHead.Color = Color3.fromRGB(9, 189, 18)
                local NewSc = script.Parent:FindFirstChild("BodyScript")
                if NewSc then
                    InstanceUtil.CloneP(NewSc, {["Parent"] = SnakeHead, ["Disabled"] = false})
                    SnakeHead = NewHead
                end
            else
                NewHead.Color = Color3.fromRGB(9, 131, 15)
                SnakeHead.Color = Color3.fromRGB(9, 189, 18)
                local NewSc = script.Parent:FindFirstChild("BodyScript")
                if NewSc then
                    InstanceUtil.CloneP(NewSc, {["Parent"] = SnakeHead, ["Disabled"] = false})
                    SnakeHead = NewHead
                end
            end
        else
            GameOver = true
        end
    end
end