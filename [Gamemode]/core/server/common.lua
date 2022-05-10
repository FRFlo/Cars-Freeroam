ESX = {}
ESX.Players = {}
ESX.UsableItemsCallbacks = {}
ESX.Items = {}
ESX.ServerCallbacks = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}
ESX.Pickups = {}
ESX.PickupId = 0
ESX.Teams = {}
ESX.RegisteredCommands = {}

AddEventHandler('esx:getSharedObject', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

MySQL.ready(function()
	local Teams = {}
	MySQL.Async.fetchAll('SELECT * FROM teams', {}, function(teams)
		for k,v in ipairs(teams) do
			Teams[v.name] = v
			Teams[v.name].grades = {}
		end

		MySQL.Async.fetchAll('SELECT * FROM team_grades', {}, function(teamGrades)
			for k,v in ipairs(teamGrades) do
				if Teams[v.team_name] then
					Teams[v.team_name].grades[tostring(v.grade)] = v
				else
					print(('[^3WARNING^7] Ignoring team grades for ^5"%s"^0 due to missing team'):format(v.team_name))
				end
			end

			for k2,v2 in pairs(Teams) do
				if ESX.Table.SizeOf(v2.grades) == 0 then
					Teams[v2.name] = nil
					print(('[^3WARNING^7] Ignoring team ^5"%s"^0due to no team grades found'):format(v2.name))
				end
			end
			ESX.Teams = Teams
			print('[^2INFO^7] ESX ^5Legacy^0 initialized')
			ESX.StartDBSync()
		end)
	end)
end)

RegisterServerEvent('esx:DB')
AddEventHandler('esx:DB', function()
	local Teams = {}
	MySQL.Async.fetchAll('SELECT * FROM teams', {}, function(teams)
		for k,v in ipairs(teams) do
			Teams[v.name] = v
			Teams[v.name].grades = {}
		end

		MySQL.Async.fetchAll('SELECT * FROM team_grades', {}, function(teamGrades)
			for k,v in ipairs(teamGrades) do
				if Teams[v.team_name] then
					Teams[v.team_name].grades[tostring(v.grade)] = v
				else
					print(('[^3WARNING^7] Ignoring team grades for ^5"%s"^0 due to missing team'):format(v.team_name))
				end
			end

			for k2,v2 in pairs(Teams) do
				if ESX.Table.SizeOf(v2.grades) == 0 then
					Teams[v2.name] = nil
					print(('[^3WARNING^7] Ignoring team ^5"%s"^0due to no team grades found'):format(v2.name))
				end
			end
			ESX.Teams = Teams
		end)
	end)
end)

RegisterServerEvent('esx:clientLog')
AddEventHandler('esx:clientLog', function(msg)
	if Config.EnableDebug then
		print(('[^2TRACE^7] %s^7'):format(msg))
	end
end)

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
	local playerId = source

	ESX.TriggerServerCallback(name, requestId, playerId, function(...)
		TriggerClientEvent('esx:serverCallback', playerId, requestId, ...)
	end, ...)
end)
