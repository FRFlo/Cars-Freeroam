ESX.RegisterCommand('setcoords', {"user", "admin"}, function(xPlayer, args, showError)
	xPlayer.setCoords({x = args.x, y = args.y, z = args.z})
end, false, {help = _U('command_setcoords'), validate = true, arguments = {
	{name = 'x', help = _U('command_setcoords_x'), type = 'number'},
	{name = 'y', help = _U('command_setcoords_y'), type = 'number'},
	{name = 'z', help = _U('command_setcoords_z'), type = 'number'}
}})

ESX.RegisterCommand('setteam', 'admin', function(xPlayer, args, showError)
	if ESX.DoesTeamExist(args.team, args.grade) then
		args.playerId.setTeam(args.team, args.grade)
	else
		showError(_U('command_setteam_invalid'))
	end
end, true, {help = _U('command_setteam'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'team', help = _U('command_setteam_team'), type = 'string'},
	{name = 'grade', help = _U('command_setteam_grade'), type = 'number'}
}})

ESX.RegisterCommand('car', 'admin', function(xPlayer, args, showError)
	if not args.car then args.car = "sultanrs" end
	xPlayer.triggerEvent('esx:spawnVehicle', args.car)
end, false, {help = _U('command_car'), validate = false, arguments = {
	{name = 'car', help = _U('command_car_car'), type = 'any'}
}})

ESX.RegisterCommand({'cardel', 'dv'}, {"user", "admin"}, function(xPlayer, args, showError)
	if not args.radius then args.radius = 4 end
	xPlayer.triggerEvent('esx:deleteVehicle', args.radius)
end, false, {help = _U('command_cardel'), validate = false, arguments = {
	{name = 'radius', help = _U('command_cardel_radius'), type = 'any'}
}})

ESX.RegisterCommand({'clear', 'cls'}, 'user', function(xPlayer, args, showError)
	xPlayer.triggerEvent('chat:clear')
end, false, {help = _U('command_clear')})

ESX.RegisterCommand({'clearall', 'clsall'}, 'admin', function(xPlayer, args, showError)
	TriggerClientEvent('chat:clear', -1)
end, false, {help = _U('command_clearall')})

ESX.RegisterCommand('setgroup', 'admin', function(xPlayer, args, showError)
	if not args.playerId then args.playerId = xPlayer.source end
	if args.group == "superadmin" then args.group = "admin" end
	args.playerId.setGroup(args.group)
end, true, {help = _U('command_setgroup'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'},
	{name = 'group', help = _U('command_setgroup_group'), type = 'string'},
}})

ESX.RegisterCommand('save', 'admin', function(xPlayer, args, showError)
	ESX.SavePlayer(args.playerId)
end, true, {help = _U('command_save'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('saveall', 'admin', function(xPlayer, args, showError)
	ESX.SavePlayers()
end, true, {help = _U('command_saveall')})

ESX.RegisterCommand('group', {"user", "admin"}, function(xPlayer, args, showError)
	print(xPlayer.getName()..", Vous faites actuellement partie du groupe: ^5".. xPlayer.getGroup())
end, true)

ESX.RegisterCommand('team', {"user", "admin"}, function(xPlayer, args, showError)
print(xPlayer.getName()..", Vous faites actuellement partie de l'équipe: ^5".. xPlayer.getTeam().name.. "^0 - ^5".. xPlayer.getTeam().grade_label)
end, true)

ESX.RegisterCommand('info', {"user", "admin"}, function(xPlayer, args, showError)
	local team = xPlayer.getTeam().name
	local teamgrade = xPlayer.getTeam().grade_name
	print("^2ID : ^5"..xPlayer.source.." ^0| ^2Nom:^5"..xPlayer.getName().." ^0 | ^2Groupe:^5"..xPlayer.getGroup().."^0 | ^2Team:^5".. team.."")
	end, true)

ESX.RegisterCommand('coords', "admin", function(xPlayer, args, showError)
	print("".. xPlayer.getName().. ": ^5".. xPlayer.getCoords(true))
end, true)

ESX.RegisterCommand('tpm', {"user", "admin"}, function(xPlayer, args, showError)
	xPlayer.triggerEvent("esx:tpm")
end, true)

ESX.RegisterCommand('goto', "admin", function(xPlayer, args, showError)
		local targetCoords = args.playerId.getCoords()
		xPlayer.setCoords(targetCoords)
end, true, {help = _U('goto'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('bring', "admin", function(xPlayer, args, showError)
		local playerCoords = xPlayer.getCoords()
		args.playerId.setCoords(playerCoords)
end, true, {help = _U('bring'), validate = true, arguments = {
	{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('kill', "admin", function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx:killPlayer')
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('freeze', "admin", function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx:freezePlayer', "freeze")
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('unfreeze', "admin", function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx:freezePlayer', "unfreeze")
end, true, {help = _U('kill'), validate = true, arguments = {
{name = 'playerId', help = _U('commandgeneric_playerid'), type = 'player'}
}})

ESX.RegisterCommand('reviveall', "admin", function(xPlayer, args, showError)
	for _, playerId in ipairs(GetPlayers()) do
		TriggerClientEvent('esx:revive', playerId)
	end
end, false)

ESX.RegisterCommand("noclip", 'admin', function(xPlayer, args, showError)
	xPlayer.triggerEvent('esx:noclip')
end, false)

ESX.RegisterCommand('players', "admin", function(xPlayer, args, showError)
	local xAll = ESX.GetPlayers()
	print("^5"..#xAll.." ^2online player(s)^0")
	for i=1, #xAll, 1 do
		local xPlayer = ESX.GetPlayerFromId(xAll[i])
		print("^1[ ^2ID : ^5"..xPlayer.source.." ^0| ^2Nom : ^5"..xPlayer.getName().." ^0 | ^2Groupe : ^5"..xPlayer.getGroup().." ^0 | ^2Identifier : ^5".. xPlayer.identifier .."^1]^0\n")
	end
end, true)
