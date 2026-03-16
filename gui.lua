local HttpService = game:GetService("HttpService")
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 200, 0, 80)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.new(0,0,0)

local txt = Instance.new("TextLabel", frame)
txt.Size = UDim2.new(1,0,0.5,0)
txt.Text = "Szukanie okazji..."
txt.TextColor3 = Color3.new(1,1,1)

local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(1,0,0.5,0)
btn.Position = UDim2.new(0,0,0.5,0)
btn.Text = "DOŁĄCZ"
btn.Visible = false

spawn(function()
    while wait(2) do
        local ok, res = pcall(function() return HttpService:GetAsync("http://localhost:3000/gui-data") end)
        if ok and res ~= "null" then
            local data = HttpService:JSONDecode(res)
            txt.Text = "ZNALEZIONO ITEMY!"
            btn.Visible = true
            btn.MouseButton1Click:Connect(function()
                game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, data.id)
            end)
        end
    end
end)
