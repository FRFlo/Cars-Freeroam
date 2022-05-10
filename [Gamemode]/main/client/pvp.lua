local canPvP = false

RegisterNetEvent('main:pvp')
AddEventHandler('main:pvp', function()
    canPvP = not canPvP
    SetCanAttackFriendly(plyPed, canPvP, false)
    NetworkSetFriendlyFireOption(canPvP)

    if canPvP then
        ESX.ShowNotification('~w~Vous avez ~g~activé ~w~le pvp')
    else
        ESX.ShowNotification('~w~Vous avez ~r~désactivé ~w~le pvp')
    end
end)