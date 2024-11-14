lib.callback.register('lumberjack:server:SellBark', function(source)
    local player = QBCore.Functions.GetPlayer(source)
    local barkInfo = Config.Lumberyard.Processing.Bark

    if exports.ox_inventory:CanCarryItem(source, 'money', barkInfo.ValuePerBark) then
        if exports.ox_inventory:RemoveItem(source, barkInfo.Item, 1) then
            exports.ox_inventory:AddItem(source, 'money', barkInfo.ValuePerBark)
            return true
        end
    else
        return false
    end
end)