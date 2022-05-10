local Teams     = {}
local LastTime = nil

function RunAt(h, m, cb)

	table.insert(Teams, {
		h  = h,
		m  = m,
		cb = cb
	})

end

function GetTime()

	local timestamp = os.time()
	local d         = os.date('*t', timestamp).wday
	local h         = tonumber(os.date('%H', timestamp))
	local m         = tonumber(os.date('%M', timestamp))

	return {d = d, h = h, m = m}

end

function OnTime(d, h, m)

	for i=1, #Teams, 1 do
		if Teams[i].h == h and Teams[i].m == m then
			Teams[i].cb(d, h, m)
		end
	end

end

function Tick()

	local time = GetTime()

	if time.h ~= LastTime.h or time.m ~= LastTime.m then
		OnTime(time.d, time.h, time.m)
		LastTime = time
	end

	SetTimeout(60000, Tick)
end

LastTime = GetTime()

Tick()

AddEventHandler('cron:runAt', function(h, m, cb)
	RunAt(h, m, cb)
end)

print('CRON STARTED [' .. os.date('%H:%M', os.time()) .. ']')
