--= Snake BodyScript Addition by Danael_21 X StarShadow64 =--

if script.Parent:IsA("Part") then
    local WaitLenght
    local SnakeLenght = game.ReplicatedStorage:FindFirstChild("SnakeLenght")



    WaitLenght = SnakeLenght.Value

    wait(WaitLenght/10)
    script.Parent.Color = Color3.fromRGB(255,255,255)
    script:Destroy()
else
    script.Disabled = true
    print("Disabled")
end

