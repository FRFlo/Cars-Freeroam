RegisterCommand('debugped', function(source, args, rawCommand)
    TriggerEvent('main:update')
    print(json.encode(plyPed))
    TriggerEvent('chatMessage', 'ID du Ped : ' .. plyPed)
end)

RegisterCommand('debugveh', function(source, args, rawCommand)
    TriggerEvent('main:update')
    local vehicleProps = ESX.Game.GetVehicleProperties(plyVeh)
    print(json.encode(vehicleProps))
    TriggerEvent('chatMessage', 'ID du Véhicule : ' .. plyVeh)
end)

RegisterCommand('request', function(source, args, rawCommand)
    ESX.Streaming.RequestModel(args[1])
    TriggerEvent('chatMessage', 'Modèle chargé : ' .. args[1])
end)