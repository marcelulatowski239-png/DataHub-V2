local type = ... -- Przekazujemy "bot" lub "player"
local key = _G.Key or ""

if type == "player" then
    -- Sprawdzanie klucza tylko dla Ciebie
    local res = game:HttpGet("http://localhost:3000/check-key?key="..key)
    if not res:find("true") then 
        return print("BŁĄD: Brak licencji! Wygeneruj klucz w KeyAuth.") 
    end
    
    -- Ładowanie Twojego GUI
    loadstring(game:HttpGet("LINK_RAW_DO_TWOJEGO_GUI_LUA"))()
    print("✅ GUI Gracza załadowane pomyślnie!")

elseif type == "bot" then
    -- Boty wchodzą bez sprawdzania klucza
    loadstring(game:HttpGet("LINK_RAW_DO_TWOJEGO_BOTA_LUA"))()
    print("🤖 Bot uruchomiony w trybie skanowania.")
end
