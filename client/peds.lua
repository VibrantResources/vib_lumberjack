CreateThread(function()
    local foremanModel = lib.requestModel(Config.Lumberyard.Foreman.model)

    local foreman = CreatePed(1, foremanModel, Config.Lumberyard.Foreman.location, false, true)
    SetEntityInvincible(foreman, true)
    FreezeEntityPosition(foreman, true)
    SetBlockingOfNonTemporaryEvents(foreman, true)

    exports.ox_target:addLocalEntity(foreman, {
        {
            label = "Speak to Foreman",
            event = 'lumberjack:client:ForemanMenu',
            icon = "fa-solid fa-basket-shopping",
            iconColor = "green",
            distance = 2,
        },
    })

    local lumberSellingModel = lib.requestModel(Config.LumberSelling.Ped.model)

    local salesPed = CreatePed(1, lumberSellingModel, Config.LumberSelling.Ped.location, false, true)
    SetEntityInvincible(salesPed, true)
    FreezeEntityPosition(salesPed, true)
    SetBlockingOfNonTemporaryEvents(salesPed, true)

    exports.ox_target:addLocalEntity(salesPed, {
        {
            label = "Speak to Lumber Buyer",
            event = 'lumberjack:client:SellMenu',
            icon = "fa-solid fa-basket-shopping",
            args = salesPed,
            iconColor = "green",
            distance = 2,
        },
    })
end)