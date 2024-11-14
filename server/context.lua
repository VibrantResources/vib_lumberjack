Context = {
    TreeCooldowns = {},
}

RegisterNetEvent("lumberjack:server:TreeCooldown", function(data)
    Context.TreeCooldowns[data] = os.time()
end)

lib.callback.register("lumberjack:server:GetTreeCooldown", function(_, data)
	local washtime = 0
	local savedTimestamp = Context.TreeCooldowns[data]


	if savedTimestamp == nil then
		savedTimestamp = -1
	end

	local treeCooldownInSeconds = Config.CoreInfo.TreeCooldown * 60
	local timeExpires = savedTimestamp + treeCooldownInSeconds
	local remainingTime = timeExpires - os.time()

	washtime = remainingTime > 0 and remainingTime or 0

	if washtime <= 0 then
		Context.TreeCooldowns[data] = -1
	end
	
	return washtime
end)