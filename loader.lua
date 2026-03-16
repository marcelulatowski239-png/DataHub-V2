local type = ... -- Przekazujemy "bot" lub "player"
local key = _G.Key or ""

-- TWOJE LINKI Z GITHUBA
local bot_script = "https://raw.githubusercontent.com/marcelulatowski239-png/DataHub-V2/refs/heads/main/bot.lua"
local gui_script = "https://raw.githubusercontent.com/marcelulatowski239-png/DataHub-V2/refs/heads/main/gui.lua"

if type == "player" then
    -- Sprawdzanie klucza przez Twój serwer Node.js
    local res = game:HttpGet("http://localhost:3000/check-key?key="..key)
    if not res:find("true") then 
        return warn("Błąd licencji! Sprawdź klucz w KeyAuth.") 
    end
    
    loadstring(game:HttpGet(gui_script))()
    print("✅ GUI Gracza załadowane!")

elseif type == "bot" then
    -- Boty wchodzą bez klucza
    loadstring(game:HttpGet(bot_script))()
    print("🤖 Bot skaner uruchomiony!")
end
