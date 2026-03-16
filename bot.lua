local API_URL = "http://localhost:3000"
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")

print("🤖 BOT URUCHOMIONY...")

function scanAndReport()
    local itemsFound = {}
    -- SZUKANIE OBIEKTÓW (Dopasuj nazwy!)
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj.Name == "BrainrotItem" or obj:FindFirstChild("Value") then
            table.insert(itemsFound, obj.Name)
        end
    end

    if #itemsFound > 0 then
        print("✅ Znaleziono przedmioty! Wysyłam raport...")
        local data = {
            id = game.JobId,
            items = itemsFound,
            players = #game.Players:GetPlayers()
        }
        pcall(function()
            HttpService:PostAsync(API_URL.."/report-items", HttpService:JSONEncode(data))
        end)
    else
        print("❌ Nic nie znaleziono na tym serwerze.")
    end
end

-- 1. Skanuj serwer
task.wait(5) -- Czeka na załadowanie mapy
scanAndReport()

-- 2. Przeskocz na inny serwer (Server Hop)
task.wait(2)
print("🚀 Szukam nowego serwera...")

local function joinNewServer()
    local success, res = pcall(function()
        return HttpService:GetAsync(API_URL.."/get-new-server")
    end)
    
    if success and res then
        local srv = HttpService:JSONDecode(res)
        if srv and srv.id then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, srv.id)
        end
    end
end

joinNewServer()

-- Jeśli teleportacja zawiedzie, spróbuj ponownie za 10 sekund
while task.wait(10) do
    joinNewServer()
end
