RegisterCommand('repair', function()
    TriggerEvent('main:update')
    if IsPedSittingInAnyVehicle(plyPed) then
        if (GetPedInVehicleSeat(GetVehiclePedIsIn(plyPed, false), -1) == plyPed) then
			local plyVeh = GetVehiclePedIsIn(plyPed, false)
			SetVehicleFixed(plyVeh)
			SetVehicleDirtLevel(plyVeh, 0.0)
        end
    end
end, false)

RegisterCommand('revive', function()
    TriggerEvent('main:update')
    if GetEntityCoords(plyPed) == vector3(0, 0, 0) then
        --print('Respawn en coordonées fictives : ' + coords)
        coords = ESX.PlayerData.coords
    else
        --print('Respawn en coordonées réelles : ' + coords)
        coords = GetEntityCoords(plyPed)
    end
    if isDead then
        NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, 180.00, true, true, false)
        SetPlayerInvincible(plyPed, false)
        ClearPedBloodDamage(plyPed)
        isDead = false
    end
end, false)

RegisterCommand('setdead', function()
    TriggerEvent('main:update')
    isDead = true
end, false)

RegisterCommand('pvp', function()
    TriggerEvent('main:update')
    TriggerEvent('main:pvp')
end, false)

isDead = false

AddEventHandler('esx:onPlayerDeath', function()
    TriggerEvent('main:update')
    isDead = true
end)

RegisterKeyMapping('repair', 'Réparer le véhicule', 'keyboard', 'A')
RegisterKeyMapping('pvp', 'Activer / Désactiver le PvP', 'keyboard', 'P')
RegisterKeyMapping('revive', 'Se réanimer', 'keyboard', 'E')
RegisterKeyMapping('radio', 'Menu Radio', 'keyboard', 'F5')
RegisterKeyMapping('cycleproximity', 'Mode de parole', 'keyboard', 'F4')
RegisterKeyMapping('+radiotalk', 'Parler sur la radio', 'keyboard', 'LMENU')