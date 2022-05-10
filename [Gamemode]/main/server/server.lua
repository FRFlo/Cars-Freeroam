msg = ""

ESX.RegisterCommand('annonce', 'admin', function(xPlayer, args, showError)
	for i,v in pairs(args) do
		msg = msg .. " " .. v
	end
	TriggerClientEvent("announce", -1, msg)
	msg = ""
end, false, {help = 'Faire une annonce', validate = false, arguments = {
	{name = 'annonce', help = 'Texte de l\'annonce', type = 'any'}
}})
