RegisterServerEvent('main:addVehicle')
AddEventHandler('main:addVehicle', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicule) VALUES (@owner, @vehicule)',
	{
		['@owner']   = xPlayer.identifier,
		['@vehicule'] = json.encode(vehicleProps)
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source, 'Le véhicule avec l\'ID ~b~' .. rowsChanged.id .. 'a été sauvegardé avec succès')
	end)
end)