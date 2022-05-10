local NewPlayer, LoadPlayer = -1, -1
Citizen.CreateThread(function()
	SetMapName('Los Santos')
	SetGameType('Cars Freeroam')
	
	local query = '`team`, `team_grade`, `group`' -- Select these fields from the database

	if Config.Multichar then -- insert identity data with creation
		MySQL.Async.store("INSERT INTO `users` SET `identifier` = ?, `group` = ?", function(storeId)
			NewPlayer = storeId
		end)
	else
		MySQL.Async.store("INSERT INTO `users` SET `identifier` = ?, `group` = ?", function(storeId)
			NewPlayer = storeId
		end)
	end

	MySQL.Async.store("SELECT "..query.." FROM `users` WHERE identifier = ?", function(storeId)
		LoadPlayer = storeId
	end)
end)

if Config.Multichar then
	AddEventHandler('esx:onPlayerJoined', function(src, char, data)
		if not ESX.Players[src] then
			local identifier = char..':'..ESX.GetIdentifier(src)
			if data then
				createESXPlayer(identifier, src, data)
			else
				loadESXPlayer(identifier, src, false)
			end
		end
	end)
else
	RegisterNetEvent('esx:onPlayerJoined')
	AddEventHandler('esx:onPlayerJoined', function()
		if not ESX.Players[source] then
			onPlayerJoined(source)
		end
	end)
end

function onPlayerJoined(playerId)
	local identifier = ESX.GetIdentifier(playerId)
	if char then identifier = char..':'..identifier end

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			DropPlayer(playerId, ('there was an error loading your character!\nError code: identifier-active-ingame\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same Rockstar account.\n\nYour Rockstar identifier: %s'):format(identifier))
		else
			MySQL.Async.fetchScalar('SELECT 1 FROM users WHERE identifier = @identifier', {
				['@identifier'] = identifier
			}, function(result)
				if result then
					loadESXPlayer(identifier, playerId, false)
				else createESXPlayer(identifier, playerId) end
			end)
		end
	else
		DropPlayer(playerId, 'there was an error loading your character!\nError code: identifier-missing-ingame\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end

function createESXPlayer(identifier, playerId, data)

	if IsPlayerAceAllowed(playerId, "command") then
		print(('^2[INFO] ^0 Player ^5%s ^0Has been granted admin permissions via ^5Ace Perms.^7'):format(playerId))
		defaultGroup = "admin"
	else
		defaultGroup = "user"
	end

	if not Config.Multichar then
		MySQL.Async.execute(NewPlayer, {
				identifier,
				defaultGroup,
		}, function(rowsChanged)
			loadESXPlayer(identifier, playerId, true)
		end)
	else
		MySQL.Async.execute(NewPlayer, {
				identifier,
				defaultGroup,
		}, function(rowsChanged)
			loadESXPlayer(identifier, playerId, true)
		end)
	end
end

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	deferrals.defer()
	local playerId = source
	local identifier = ESX.GetIdentifier(playerId)
	Citizen.Wait(100)

	if identifier then
		if ESX.GetPlayerFromIdentifier(identifier) then
			deferrals.done(('There was an error loading your character!\nError code: identifier-active\n\nThis error is caused by a player on this server who has the same identifier as you have. Make sure you are not playing on the same account.\n\nYour identifier: %s'):format(identifier))
		else
			deferrals.done()
		end
	else
		deferrals.done('There was an error loading your character!\nError code: identifier-missing\n\nThe cause of this error is not known, your identifier could not be found. Please come back later or report this problem to the server administration team.')
	end
end)

function loadESXPlayer(identifier, playerId, isNew)
	local tasks = {}

	local userData = {
		team = {},
		playerName = GetPlayerName(playerId),
	}

	table.insert(tasks, function(cb)
		MySQL.Async.fetchAll(LoadPlayer, { identifier
		}, function(result)
			local team, grade, teamObject, gradeObject = result[1].team, tostring(result[1].team_grade)

			-- Team
			if ESX.DoesTeamExist(team, grade) then
				teamObject, gradeObject = ESX.Teams[team], ESX.Teams[team].grades[grade]
			else
				print(('[^3WARNING^7] Ignoring invalid team for %s [team: %s, grade: %s]'):format(identifier, team, grade))
				team, grade = 'unemployed', '0'
				teamObject, gradeObject = ESX.Teams[team], ESX.Teams[team].grades[grade]
			end

			userData.team.id = teamObject.id
			userData.team.name = teamObject.name
			userData.team.label = teamObject.label

			userData.team.grade = tonumber(grade)
			userData.team.grade_name = gradeObject.name
			userData.team.grade_label = gradeObject.label

			-- Group
			if result[1].group then
				if result[1].group == "superadmin" then
					userData.group = "admin"
				else
					userData.group = result[1].group
				end
			else
				userData.group = 'user'
			end

			-- Position
			userData.coords = {x = 389.57, y = -356.06, z = 48.02, heading = 276.23}

			cb()
		end)
	end)

	Async.parallel(tasks, function(results)
		local xPlayer = CreateExtendedPlayer(playerId, identifier, userData.group, userData.team, userData.playerName, userData.coords)
		ESX.Players[playerId] = xPlayer

		TriggerEvent('esx:playerLoaded', playerId, xPlayer, isNew)

		xPlayer.triggerEvent('esx:playerLoaded', {
			coords = xPlayer.getCoords(),
			identifier = xPlayer.getIdentifier(),
			team = xPlayer.getTeam(),
			dead = false
		}, isNew, userData.skin)

		xPlayer.triggerEvent('esx:createMissingPickups', ESX.Pickups)
		xPlayer.triggerEvent('esx:registerSuggestions', ESX.RegisteredCommands)
		print(('[^2INFO^0] Player ^5"%s" ^0has connected to the server. ID: ^5%s^7'):format(xPlayer.getName(), playerId))
	end)
end

AddEventHandler('chatMessage', function(playerId, author, message)
	if message:sub(1, 1) == '/' and playerId > 0 then
		CancelEvent()
		local commandName = message:sub(1):gmatch("%w+")()
		TriggerClientEvent('chat:addMessage', playerId, {args = {'^1SYSTEM', _U('commanderror_invalidcommand', commandName)}})
	end
end)

AddEventHandler('playerDropped', function(reason)
	local playerId = source
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if xPlayer then
		TriggerEvent('esx:playerDropped', playerId, reason)

		ESX.SavePlayer(xPlayer, function()
			ESX.Players[playerId] = nil
		end)
	end
end)

if Config.Multichar then
	AddEventHandler('esx:playerLogout', function(playerId)
		local xPlayer = ESX.GetPlayerFromId(playerId)
		if xPlayer then
			TriggerEvent('esx:playerDropped', playerId, reason)

			ESX.SavePlayer(xPlayer, function()
				ESX.Players[playerId] = nil
			end)
		end
		TriggerClientEvent("esx:onPlayerLogout", playerId)
	end)
end

RegisterNetEvent('esx:updateCoords')
AddEventHandler('esx:updateCoords', function(coords)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateCoords(coords)
	end
end)

RegisterNetEvent('esx:updateWeaponAmmo')
AddEventHandler('esx:updateWeaponAmmo', function(weaponName, ammoCount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer then
		xPlayer.updateWeaponAmmo(weaponName, ammoCount)
	end
end)

ESX.RegisterServerCallback('esx:getPlayerData', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		identifier   = xPlayer.identifier,
		team          = xPlayer.getTeam()
	})
end)

ESX.RegisterServerCallback('esx:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	cb({
		identifier   = xPlayer.identifier,
		team          = xPlayer.getTeam()
	})
end)

ESX.RegisterServerCallback('esx:getPlayerNames', function(source, cb, players)
	players[source] = nil

	for playerId,v in pairs(players) do
		local xPlayer = ESX.GetPlayerFromId(playerId)

		if xPlayer then
			players[playerId] = xPlayer.getName()
		else
			players[playerId] = nil
		end
	end

	cb(players)
end)

AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
	if eventData.secondsRemaining == 60 then
		Citizen.CreateThread(function()
			Citizen.Wait(50000)
			ESX.SavePlayers()
		end)
	end
end)