local rand = "BRAK"

local canGuess = true

ESX = exports["es_extended"]:getSharedObject()

CreateThread(function()
    while true do
        Citizen.Wait(Config.AnswerInterval * 1000)
        rand = Config.Texts[math.random(1, #Config.Texts)]
        canGuess = true
        TriggerClientEvent("chat:addMessage", -1, { 
            template = '<div style="padding: 0.3vw; max-width:60%; border-right: 2.5px rgb(22, 137, 142) solid; border-left: 2.5px rgb(22, 137, 142) solid; border-radius: 5px; background: rgba(0, 0, 0, 0.4);">{0}</div>',
            args = { "Przepisz jak naszybciej '" .. rand .. "' aby wygrać!" }
        })
    end
end)

AddEventHandler('chatMessage', function(source, name, message)
    if message == rand and canGuess then
        canGuess = false
        local xPlayer = ESX.GetPlayerFromId(source)
        xPlayer.addMoney(Config.RewardMoney)
        for k, v in pairs(Config.RewardItems) do
            xPlayer.addInventoryItem(k, v)
        end
        TriggerClientEvent("chat:addMessage", -1, { 
            template = '<div style="padding: 0.3vw; max-width:60%; border-right: 2.5px rgb(22, 137, 142) solid; border-left: 2.5px rgb(22, 137, 142) solid; border-radius: 5px; background: rgba(0, 0, 0, 0.4);">{0}</div>',
            args = { "Użytkownik " .. GetPlayerName(source) .. " przepisał jak najszybciej i otrzymał nagrody!" }
        })
    end
end)
