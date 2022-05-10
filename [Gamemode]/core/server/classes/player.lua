function CreateExtendedPlayer(playerId, identifier, group, team, name, coords)
	local self = {}

	self.coords = coords
	self.group = group
	self.identifier = identifier
	self.team = team
	self.name = name
	self.playerId = playerId
	self.source = playerId
	self.variables = {}
	if Config.Multichar then self.license = 'license'..string.sub(identifier, 6) else self.license = 'license:'..identifier end

	ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.license, self.group))

	self.triggerEvent = function(eventName, ...)
		TriggerClientEvent(eventName, self.source, ...)
	end

	self.setCoords = function(coords)
		self.updateCoords(coords)
		self.triggerEvent('esx:teleport', coords)
	end

	self.updateCoords = function(coords)
		self.coords = {x = ESX.Math.Round(coords.x, 1), y = ESX.Math.Round(coords.y, 1), z = ESX.Math.Round(coords.z, 1), heading = ESX.Math.Round(coords.heading or 0.0, 1)}
	end

	self.getCoords = function(vector)
		if vector then
			return vector3(self.coords.x, self.coords.y, self.coords.z)
		else
			return self.coords
		end
	end

	self.kick = function(reason)
		DropPlayer(self.source, reason)
	end

	self.getIdentifier = function()
		return self.identifier
	end

	self.setGroup = function(newGroup)
		ExecuteCommand(('remove_principal identifier.%s group.%s'):format(self.license, self.group))
		self.group = newGroup
		ExecuteCommand(('add_principal identifier.%s group.%s'):format(self.license, self.group))
	end

	self.getGroup = function()
		return self.group
	end

	self.set = function(k, v)
		self.variables[k] = v
	end

	self.get = function(k)
		return self.variables[k]
	end

	self.getTeam = function()
		return self.team
	end

	self.getName = function()
		return self.name
	end

	self.setName = function(newName)
		self.name = newName
	end

	self.setTeam = function(team, grade)
		grade = tostring(grade)
		local lastTeam = json.decode(json.encode(self.team))

		if ESX.DoesTeamExist(team, grade) then
			local teamObject, gradeObject = ESX.Teams[team], ESX.Teams[team].grades[grade]

			self.team.id    = teamObject.id
			self.team.name  = teamObject.name
			self.team.label = teamObject.label

			self.team.grade        = tonumber(grade)
			self.team.grade_name   = gradeObject.name
			self.team.grade_label  = gradeObject.label

			TriggerEvent('esx:setTeam', self.source, self.team, lastTeam)
			self.triggerEvent('esx:setTeam', self.team)
		else
			print(('[es_extended] [^3WARNING^7] Ignoring invalid .setTeam() usage for "%s"'):format(self.identifier))
		end
	end

	self.showNotification = function(msg)
		self.triggerEvent('esx:showNotification', msg)
	end

	self.showHelpNotification = function(msg, thisFrame, beep, duration)
		self.triggerEvent('esx:showHelpNotification', msg, thisFrame, beep, duration)
	end

	return self
end
