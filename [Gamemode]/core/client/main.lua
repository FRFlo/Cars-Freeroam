local pickups = {}

Citizen.CreateThread(function()
	while NetworkIsPlayerActive(PlayerId()) and not Config.Multichar do
		Citizen.Wait(5)
		DoScreenFadeOut(0)
		TriggerServerEvent('esx:onPlayerJoined')
		break
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData, isNew, skin)
	ESX.PlayerLoaded = true
	ESX.PlayerData = playerData

	FreezeEntityPosition(PlayerPedId(), true)

	if Config.Multichar then
		Citizen.Wait(3000)
	else
		exports.spawnmanager:spawnPlayer({
			x = playerData.coords.x,
			y = playerData.coords.y,
			z = playerData.coords.z + 0.25,
			heading = playerData.coords.heading,
			model = `mp_m_freemode_01`,
			skipFade = false
		}, function()
			TriggerServerEvent('esx:onPlayerSpawn')
			TriggerEvent('esx:onPlayerSpawn')
			TriggerEvent('playerSpawned') -- compatibility with old scripts
			if isNew then
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadDefaultModel', true)
				else
					TriggerEvent('skinchanger:loadDefaultModel', false)
				end
			elseif skin then TriggerEvent('skinchanger:loadSkin', skin) end
			TriggerEvent('esx:loadingScreenOff')
			ShutdownLoadingScreen()
			ShutdownLoadingScreenNui()
			FreezeEntityPosition(ESX.PlayerData.ped, false)
		end)
	end

	while ESX.PlayerData.ped == nil do Citizen.Wait(20) end

	if Config.EnableHud then

		local teamTpl = '<div>{{team_label}} - {{grade_label}}</div>'

		if playerData.team.grade_label == '' or playerData.team.grade_label == playerData.team.label then
			teamTpl = '<div>{{team_label}}</div>'
		end
	end
	StartServerSyncLoops()
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	if Config.EnableHud then ESX.UI.HUD.Reset() end
end)

AddEventHandler('esx:onPlayerSpawn', function()
	local playerPed = PlayerPedId()
	if ESX.PlayerData.ped ~= playerPed then ESX.SetPlayerData('ped', playerPed) end
	if ESX.PlayerData.dead ~= false then ESX.SetPlayerData('dead', false) end
end)

AddEventHandler('esx:onPlayerDeath', function()
	local playerPed = PlayerPedId()
	if ESX.PlayerData.ped ~= playerPed then ESX.SetPlayerData('ped', playerPed) end
	if ESX.PlayerData.dead ~= false then ESX.SetPlayerData('dead', true) end
end)

AddEventHandler('skinchanger:modelLoaded', function()
	while not ESX.PlayerLoaded do
		Citizen.Wait(100)
	end
end)

RegisterNetEvent('esx:teleport')
AddEventHandler('esx:teleport', function(coords)
	ESX.Game.Teleport(ESX.PlayerData.ped, coords)
end)

RegisterNetEvent('esx:setTeam')
AddEventHandler('esx:setTeam', function(Team)
	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('team', {
			team_label = Team.label,
			grade_label = Team.grade_label
		})
	end
	ESX.SetPlayerData('team', Team)
end)

RegisterNetEvent('esx:spawnVehicle')
AddEventHandler('esx:spawnVehicle', function(vehicle)
	local model = (type(vehicle) == 'number' and vehicle or GetHashKey(vehicle))

	if IsModelInCdimage(model) then
		local playerCoords, playerHeading = GetEntityCoords(ESX.PlayerData.ped), GetEntityHeading(ESX.PlayerData.ped)

		ESX.Game.SpawnVehicle(model, playerCoords, playerHeading, function(vehicle)
			TaskWarpPedIntoVehicle(ESX.PlayerData.ped, vehicle, -1)
		end)
	else
		TriggerEvent('chat:addMessage', { args = { '^1SYSTEM', 'Invalid vehicle model.' } })
	end
end)
RegisterNetEvent('esx:createPickup')
AddEventHandler('esx:createPickup', function(pickupId, label, coords, type, name, components, tintIndex)
	local function setObjectProperties(object)
		SetEntityAsMissionEntity(object, true, false)
		PlaceObjectOnGroundProperly(object)
		FreezeEntityPosition(object, true)
		SetEntityCollision(object, false, true)

		pickups[pickupId] = {
			obj = object,
			label = label,
			inRange = false,
			coords = vector3(coords.x, coords.y, coords.z)
		}
	end

end)

RegisterNetEvent('esx:createMissingPickups')
AddEventHandler('esx:createMissingPickups', function(missingPickups)
	for pickupId,pickup in pairs(missingPickups) do
		TriggerEvent('esx:createPickup', pickupId, pickup.label, pickup.coords, pickup.type, pickup.name, pickup.components, pickup.tintIndex)
	end
end)

RegisterNetEvent('esx:registerSuggestions')
AddEventHandler('esx:registerSuggestions', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('chat:addSuggestion', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)

RegisterNetEvent('esx:removePickup')
AddEventHandler('esx:removePickup', function(pickupId)
	if pickups[pickupId] and pickups[pickupId].obj then
		ESX.Game.DeleteObject(pickups[pickupId].obj)
		pickups[pickupId] = nil
	end
end)

RegisterNetEvent('esx:deleteVehicle')
AddEventHandler('esx:deleteVehicle', function(radius)
	if radius and tonumber(radius) then
		radius = tonumber(radius) + 0.01
		local vehicles = ESX.Game.GetVehiclesInArea(GetEntityCoords(ESX.PlayerData.ped), radius)

		for k,entity in ipairs(vehicles) do
			local attempt = 0

			while not NetworkHasControlOfEntity(entity) and attempt < 100 and DoesEntityExist(entity) do
				Citizen.Wait(100)
				NetworkRequestControlOfEntity(entity)
				attempt = attempt + 1
			end

			if DoesEntityExist(entity) and NetworkHasControlOfEntity(entity) then
				ESX.Game.DeleteVehicle(entity)
			end
		end
	else
		local vehicle, attempt = ESX.Game.GetVehicleInDirection(), 0

		if IsPedInAnyVehicle(ESX.PlayerData.ped, true) then
			vehicle = GetVehiclePedIsIn(ESX.PlayerData.ped, false)
		end

		while not NetworkHasControlOfEntity(vehicle) and attempt < 100 and DoesEntityExist(vehicle) do
			Citizen.Wait(100)
			NetworkRequestControlOfEntity(vehicle)
			attempt = attempt + 1
		end

		if DoesEntityExist(vehicle) and NetworkHasControlOfEntity(vehicle) then
			ESX.Game.DeleteVehicle(vehicle)
		end
	end
end)

-- Pause menu disables HUD display
if Config.EnableHud then
	Citizen.CreateThread(function()
		local isPaused = false
		while true do
			Citizen.Wait(300)

			if IsPauseMenuActive() and not isPaused then
				isPaused = true
				ESX.UI.HUD.SetDisplay(0.0)
			elseif not IsPauseMenuActive() and isPaused then
				isPaused = false
				ESX.UI.HUD.SetDisplay(1.0)
			end
		end
	end)

	AddEventHandler('esx:loadingScreenOff', function()
		ESX.UI.HUD.SetDisplay(1.0)
	end)
end

function StartServerSyncLoops()
	-- sync current player coords with server
	Citizen.CreateThread(function()
		local previousCoords = vector3(ESX.PlayerData.coords.x, ESX.PlayerData.coords.y, ESX.PlayerData.coords.z)

		while ESX.PlayerLoaded do
			local playerPed = PlayerPedId()
			if ESX.PlayerData.ped ~= playerPed then ESX.SetPlayerData('ped', playerPed) end

			if DoesEntityExist(ESX.PlayerData.ped) then
				local playerCoords = GetEntityCoords(ESX.PlayerData.ped)
				local distance = #(playerCoords - previousCoords)

				if distance > 1 then
					previousCoords = playerCoords
					local playerHeading = ESX.Math.Round(GetEntityHeading(ESX.PlayerData.ped), 1)
					local formattedCoords = {x = ESX.Math.Round(playerCoords.x, 1), y = ESX.Math.Round(playerCoords.y, 1), z = ESX.Math.Round(playerCoords.z, 1), heading = playerHeading}
					TriggerServerEvent('esx:updateCoords', formattedCoords)
				end
			end
			Citizen.Wait(1500)
		end
	end)
end

-- disable wanted level
if not Config.EnableWantedLevel then
	ClearPlayerWantedLevel(PlayerId())
	SetMaxWantedLevel(0)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, letSleep = GetEntityCoords(ESX.PlayerData.ped), true
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer(playerCoords)

		for pickupId,pickup in pairs(pickups) do
			local distance = #(playerCoords - pickup.coords)

			if distance < 5 then
				local label = pickup.label
				letSleep = false

				if distance < 1 then
					if IsControlJustReleased(0, 38) then
						if IsPedOnFoot(ESX.PlayerData.ped) and (closestDistance == -1 or closestDistance > 3) and not pickup.inRange then
							pickup.inRange = true

							local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
							ESX.Streaming.RequestAnimDict(dict)
							TaskPlayAnim(ESX.PlayerData.ped, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
							Citizen.Wait(1000)

							TriggerServerEvent('esx:onPickup', pickupId)
							PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
						end
					end

					label = ('%s~n~%s'):format(label, _U('threw_pickup_prompt'))
				end

				ESX.Game.Utils.DrawText3D({
					x = pickup.coords.x,
					y = pickup.coords.y,
					z = pickup.coords.z + 0.25
				}, label, 1.2, 1)
			elseif pickup.inRange then
				pickup.inRange = false
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

----- Admin commnads from esx_adminplus

RegisterNetEvent("esx:tpm")
AddEventHandler("esx:tpm", function()
    local WaypointHandle = GetFirstBlipInfoId(8)
    if DoesBlipExist(WaypointHandle) then
        local waypointCoords = GetBlipInfoIdCoord(WaypointHandle)

        for height = 1, 1000 do
            SetPedCoordsKeepVehicle(ESX.PlayerData.ped, waypointCoords["x"], waypointCoords["y"], height + 0.0)

            local foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords["x"], waypointCoords["y"], height + 0.0)

            if foundGround then
                SetPedCoordsKeepVehicle(ESX.PlayerData.ped, waypointCoords["x"], waypointCoords["y"], height + 0.0)

                break
            end

            Citizen.Wait(5)
        end
        TriggerEvent('chatMessage', "Successfully Teleported")
    else
        TriggerEvent('chatMessage', "No Waypoint Set")
    end
end)

local noclip = false
RegisterNetEvent("esx:noclip")
AddEventHandler("esx:noclip", function(input)
    local player = PlayerId()
	
    local msg = "désactivé"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(ESX.PlayerData.ped, false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "activé"
	end

	TriggerEvent("chatMessage", "Le noclip a été ^2^*" .. msg)
	end)
	
	local heading = 0
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if(noclip)then
			SetEntityCoordsNoOffset(ESX.PlayerData.ped, noclip_pos.x, noclip_pos.y, noclip_pos.z, 0, 0, 0)

			if(IsControlPressed(1, 34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end

				SetEntityHeading(ESX.PlayerData.ped, heading)
			end

			if(IsControlPressed(1, 9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end

				SetEntityHeading(ESX.PlayerData.ped, heading)
			end

			if(IsControlPressed(1, 8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(ESX.PlayerData.ped, 0.0, 1.0, 0.0)
			end

			if(IsControlPressed(1, 32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(ESX.PlayerData.ped, 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1, 27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(ESX.PlayerData.ped, 0.0, 0.0, 1.0)
			end

			if(IsControlPressed(1, 173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(ESX.PlayerData.ped, 0.0, 0.0, -1.0)
			end
		else
			Citizen.Wait(200)
		end
	end
end)

RegisterNetEvent("esx:killPlayer")
AddEventHandler("esx:killPlayer", function()
  SetEntityHealth(ESX.PlayerData.ped, 0)
end)

RegisterNetEvent("esx:freezePlayer")
AddEventHandler("esx:freezePlayer", function(input)
    local player = PlayerId()
    if input == 'freeze' then
        SetEntityCollision(ESX.PlayerData.ped, false)
        FreezeEntityPosition(ESX.PlayerData.ped, true)
        SetPlayerInvincible(player, true)
    elseif input == 'unfreeze' then
        SetEntityCollision(ESX.PlayerData.ped, true)
	    FreezeEntityPosition(ESX.PlayerData.ped, false)
        SetPlayerInvincible(player, false)
    end
end)

RegisterNetEvent("esx:revive")
AddEventHandler("esx:revive", function()
  SetEntityHealth(ESX.PlayerData.ped, 200)
end)