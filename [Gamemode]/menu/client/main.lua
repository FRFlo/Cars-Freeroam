Player = {
    isDead = false,
    handsup = false,
    pointing = false,
    group = 'user'
}

Citizen.CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    while ESX.GetPlayerData().team == nil do
		Citizen.Wait(10)
	end

    ESX.PlayerData = ESX.GetPlayerData()

    RMenu.Add('rageui', 'personal', RageUI.CreateMenu('Cars Freeroam', '', 0, 0, 'RageUI', 'cars', 255, 255, 255, 255))

    RMenu.Add('personal', 'test', RageUI.CreateSubMenu(RMenu.Get('rageui', 'personal'), 'Menu de test', 'oé oé oé', 0, 0, 'RageUI', 'cars', 255, 255, 255, 255))
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

AddEventHandler('esx:onPlayerDeath', function()
	Player.isDead = true
	RageUI.CloseAll()
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('playerSpawned', function()
	Player.isDead = false
end)

RegisterNetEvent('esx:setTeam')
AddEventHandler('esx:setTeam', function(team)
	ESX.PlayerData.team = team
	RefreshMoney()
end)

function RenderPersonalMenu()
    for i = 1, #RMenu['personal'], 1 do
        local buttonLabel = RMenu['personal'][i].ButtonLabel or RMenu['personal'][i].Menu.Title

        if type(RMenu['personal'][i].Restriction) == 'function' then
            if RMenu['personal'][i].Restriction() then
                RageUI.Button(buttonLabel, nil, {RightLabel = "→→→"}, true, function() end, RMenu['personal'][i].Menu)
            else
                RageUI.Button(buttonLabel, nil, {RightBadge = RageUI.BadgeStyle.Lock}, false, function() end, RMenu['personal'][i].Menu)
            end
        else
            RageUI.Button(buttonLabel, nil, {RightLabel = "→→→"}, true, function() end, RMenu['personal'][i].Menu)
        end
    end
end

function RenderTestMenu()
    RageUI.Button('youpiii', 'parait-il que ça marche', Style, Enabled, Callback, Submenu)
end

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)

        if IsControlJustReleased(0, 288) and not Player.isDead then
			if not RageUI.Visible() then
				ESX.TriggerServerCallback('menu:getgroup', function(plyGroup)
					Player.group = plyGroup
                    ESX.PlayerData = ESX.GetPlayerData()
                    RageUI.Visible(RMenu.Get('rageui', 'personal'), true)
				end)
			end
		end

		if RageUI.Visible(RMenu.Get('personal', 'test')) then
			RenderTestMenu()
		end
    end
end)

RegisterCommand('menu', function()
    if not RageUI.Visible() then
        ESX.TriggerServerCallback('menu:getgroup', function(plyGroup)
            Player.group = plyGroup
            ESX.PlayerData = ESX.GetPlayerData()
            RageUI.Visible(RMenu.Get('rageui', 'personal'), true)
        end)
    end
end)