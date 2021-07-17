local spawncode = 'r6'

local ESX = nil

Citizen.CreateThread( function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local oncooldown = false

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        if oncooldown == true then
            Citizen.Wait(30000)
            oncooldown = false
        end
    end
end)

RegisterCommand('motor', function()
    if oncooldown == false then
        oncooldown = true
        local vehicleName = spawncode
        local model = (type(vehicleName) == 'number' and vehicleName or GetHashKey(vehicleName))
        local playerPed = PlayerPedId()
	    local playerCoords, playerHeading = GetEntityCoords(playerPed), GetEntityHeading(playerPed)

	    ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
		    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
	    end)
    else
        ESX.ShowNotification('Je zit op een cooldown van 30 sec')
    end
end)