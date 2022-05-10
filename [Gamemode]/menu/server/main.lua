TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('menu:getgroup', function(source, cb)
	cb(ESX.GetPlayerFromId(source).getGroup() or 'user')
end)