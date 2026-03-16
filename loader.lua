local type = ... -- Przekazujemy czy to "bot" czy "player"
local key = _G.Key or ""

if type == "player" then
    -- Sprawdzanie klucza tylko dla gracza
    local res = game:HttpGet("http://localhost:3000/check-key?key="..key)
    if not res:find("true") then return print("Brak licencji!") end
    
    -- KOD GUI DLA GRACZA
    loadstring(game:HttpGet("LINK_DO_TWOJEGO_KODU_GUI"))()
    print("Witaj Graczu! GUI zaladowane.")

elseif type == "bot" then
    -- KOD DLA BOTA (BEZ SPRAWDZANIA KLUCZA)
    loadstring(game:HttpGet("LINK_DO_TWOJEGO_KODU_BOTA"))()
    print("Bot uruchomiony bez klucza.")
end
