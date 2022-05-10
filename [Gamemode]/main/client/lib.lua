PlayerData = {}

Citizen.CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    Citizen.Wait(5000)
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerLoaded = true
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('main:update')
AddEventHandler('main:update', function()
    plyPed = PlayerPedId()
    plyVeh = GetVehiclePedIsIn(plyPed, false)
end)

plyPed = PlayerPedId()
plyVeh = GetVehiclePedIsIn(plyPed, false)