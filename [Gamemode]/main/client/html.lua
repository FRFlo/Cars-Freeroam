RegisterCommand('coords', function(source, args, rawCommand)
	local coords = GetEntityCoords(PlayerPedId())
	SendNUIMessage({
        action = 'coords',
		coords = ""..ESX.Math.Round(coords.x, 2)..","..ESX.Math.Round(coords.y, 2)..","..ESX.Math.Round(coords.z, 2)..""
	})
end)

--[[RegisterCommand('discord', function(source, args, rawCommand)
	SendNUIMessage({
        action = 'discord'
	})
end)]]--