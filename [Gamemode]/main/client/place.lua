-- DESACTIVER LE CHANGEMENT DE PLACE AUTO
local disableShuffle = true
function disableSeatShuffle(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsPedInAnyVehicle(plyPed, false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(plyPed, false), 0) == plyPed then
				if GetIsTaskActive(plyPed, 165) then
					SetPedIntoVehicle(plyPed, GetVehiclePedIsIn(plyPed, false), 0)
				end
			end
		end
	end
end)

-- MONTER A L'ARRIERE DU VEHICULE

local doors = {
	{"seat_dside_f", -1},
	{"seat_pside_f", 0},
	{"seat_dside_r", 1},
	{"seat_pside_r", 2}
}

function VehicleInFront(plyPed)
    local pos = GetEntityCoords(plyPed)
    local entityWorld = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 5.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, plyPed, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
	
    return result
end

Citizen.CreateThread(function()
	while true do
    	Citizen.Wait(0)
			
   		if IsControlJustReleased(0, 23) and running ~= true and GetVehiclePedIsIn(plyPed, false) == 0 then
      		local vehicle = VehicleInFront(plyPed)
				
      		running = true
				
      		if vehicle ~= nil then
				local plyCoords = GetEntityCoords(plyPed, false)
        		local doorDistances = {}
					
        		for k, door in pairs(doors) do
          			local doorBone = GetEntityBoneIndexByName(vehicle, door[1])
          			local doorPos = GetWorldPositionOfEntityBone(vehicle, doorBone)
          			local distance = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, doorPos.x, doorPos.y, doorPos.z)
						
          			table.insert(doorDistances, distance)
        		end
					
        		local key, min = 1, doorDistances[1]
					
        		for k, v in ipairs(doorDistances) do
          			if doorDistances[k] < min then
           				key, min = k, v
          			end
        		end
					
        		TaskEnterVehicle(plyPed, vehicle, -1, doors[key][2], 1.5, 1, 0)
     		end
				
      		running = false
    	end
  	end
end)

-- KEYBIND CHANGEMENT PLACE VEHICLE
Citizen.CreateThread(function()
    while true do
        if IsPedSittingInAnyVehicle(plyPed) then
			if IsControlJustReleased(0, 157) then -- conducteur
				TriggerEvent('main:update')
				SetPedIntoVehicle(plyPed, plyVeh, -1)
				Citizen.Wait(10)
			end
			if IsControlJustReleased(0, 158) then -- avant droit
				TriggerEvent('main:update')
				SetPedIntoVehicle(plyPed, plyVeh, 0)
				Citizen.Wait(10)
			end
			if IsControlJustReleased(0, 160) then -- arriere gauche
				TriggerEvent('main:update')
				SetPedIntoVehicle(plyPed, plyVeh, 1)
				Citizen.Wait(10)
			end
			if IsControlJustReleased(0, 164) then -- arriere droit
				TriggerEvent('main:update')
				SetPedIntoVehicle(plyPed, plyVeh, 2)
				Citizen.Wait(10)
			end
			if IsControlJustReleased(0, 165) then -- exterieur gauche
				TriggerEvent('main:update')
				SetPedIntoVehicle(plyPed, plyVeh, 3)
				Citizen.Wait(10)
			end
			if IsControlJustReleased(0, 159) then -- exterieur droit
				TriggerEvent('main:update')
				SetPedIntoVehicle(plyPed, plyVeh, 4)
				Citizen.Wait(10)
			end
		end
		Citizen.Wait(10) -- anti crash
	end
end)