local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('metro:server:buyTicket')
AddEventHandler('metro:server:buyTicket', function()
	local src = source
    local price = Config.metro.price
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.money.cash >= price then
		Player.Functions.RemoveMoney('cash', price)
		exports['qb-management']:AddMoney('cityhall', price)
        Player.Functions.AddItem('ticketmetro', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['ticketmetro'], "add")

	elseif Player.PlayerData.money.bank >= price then
		Player.Functions.RemoveMoney('bank', price)
		exports['qb-management']:AddMoney('cityhall',price)
        Player.Functions.AddItem('ticketmetro', 1)
        TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['ticketmetro'], "add")
	else
		TriggerClientEvent('QBCore:Notify', src, "У Вас недостаточно денег, что бы оплатить стоимоть поездки $" ..price, "error") 
	end
end)