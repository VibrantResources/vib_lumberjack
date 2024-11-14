RegisterNetEvent('lumberjack:client:SellMenu', function(data)
    PlayPedAmbientSpeechNative(data.entity, 'GENERIC_HOWS_IT_GOING', 'Speech_Params_Force')
	local headerMenu = {}

    headerMenu[#headerMenu + 1] = {
        title = "Sell Wood Pallets",
        description = "Sell all of your pallets of cut planks",
        serverEvent = 'lumberjack:server:SellItem',
        args = Config.LumberSelling.SellableItems.pallets,
        icon = 'fa-solid fa-hammer',
        iconColor = "yellow",
    }

    headerMenu[#headerMenu + 1] = {
        title = "Sell Wood Logs",
        description = "Sell all of you raw logs",
        serverEvent = 'lumberjack:server:SellItem',
        args = Config.LumberSelling.SellableItems.lumber,
        icon = 'fa-solid fa-toolbox',
        iconColor = "yellow",
    }

    headerMenu[#headerMenu + 1] = {
        title = "Return Vehicle",
        description = "Return depot vehicle",
        event = 'lumberjack:client:RemoveSpawnedVehicle',
        icon = 'fa-solid fa-truck',
        iconColor = "yellow",
        args = data,
    }

    lib.registerContext({
        id = 'selling_menu',
        title = "Lumber Sales",
        options = headerMenu
    })

    lib.showContext('selling_menu')
end)