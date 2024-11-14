lib.callback.register('lumberjack:server:SellBark', function(source)
    local player = QBCore.Functions.GetPlayer(source)
    local barkInfo = Config.Lumberyard.Processing.bark

    if exports.ox_inventory:CanCarryItem(source, 'money', barkInfo.value) then
        if exports.ox_inventory:RemoveItem(source, barkInfo.item, 1) then
            exports.ox_inventory:AddItem(source, 'money', barkInfo.value)
            return true
        end
    else
        return false
    end
end)

lib.callback.register('lumberjack:server:RemoveVehicleSpawnCost', function(source, amount)
    local removedMoney = exports.ox_inventory:RemoveItem(source, 'money', amount)

    return removedMoney
end)