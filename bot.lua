local API_URL = "http://localhost:3000"
local HttpService = game:GetService("HttpService")

function scanItems()
    local itemsFound = {}
    -- Tutaj bot szuka obiektów na mapie (przykład dla Steal a Brainrot)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj.Name == "BrainrotItem" or obj:FindFirstChild("Value") then 
            table.insert(itemsFound, obj.Name)
        end
    end
    return itemsFound
end

print("Bot skanuje serwer...")
wait(5) -- Czas na zaladowanie mapy

local data = {
    id = game.JobId,
    items = scanItems(),
    players = #game.Players:GetPlayers()
}

-- Wysylka do laptopa
pcall(function()
    HttpService:PostAsync(API_URL.."/report-items", HttpService:JSONEncode(data))
end)

-- Teleportacja na nowy serwer
local success, res = pcall(function() return HttpService:GetAsync(API_URL.."/get-new-server") end)
if success then
    local srv = HttpService:JSONDecode(res)
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, srv.id)
end
