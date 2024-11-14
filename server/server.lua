QBCore = exports['qb-core']:GetCoreObject()

----------
--Events--
----------

RegisterNetEvent('lumberjack:server:PurchaseEquipment', function(data)
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end

	if exports.ox_inventory:CanCarryItem(source, data.item, 1) then
        if exports.ox_inventory:RemoveItem(source, 'money', data.price) then
            exports.ox_inventory:AddItem(source, data.item, 1)
        end
    else
        lib.notify(source, {
            title = 'Unable',
            description = "Inventory full",
            type = 'error'
        })
    end
end)

RegisterNetEvent('lumberjack:server:ProcessLumber', function()
    local player = QBCore.Functions.GetPlayer(source)
    local planks = Config.Lumberyard.Processing.planks
    local logs = Config.Lumberyard.Processing.logs

    if not player then
        return
    end

	if exports.ox_inventory:CanCarryItem(source, planks.item, planks.amountOfPlanksMade) then
        if exports.ox_inventory:RemoveItem(source, logs.item, logs.amountRequiredToMakePlank) then
            exports.ox_inventory:AddItem(source, planks.item, planks.amountOfPlanksMade)
        end
    else
        lib.notify(source, {
            title = 'Unable',
            description = "Inventory full",
            type = 'error'
        })
    end
end)

RegisterNetEvent('lumberjack:server:ProcessPlanks', function()
    local player = QBCore.Functions.GetPlayer(source)
    local planks = Config.Lumberyard.Processing.planks
    local pallets = Config.Lumberyard.Processing.pallets

    if not player then
        return
    end
    
    if exports.ox_inventory:CanCarryItem(source, pallets.item, planks.amountOfPalletsMade) then
        if exports.ox_inventory:RemoveItem(source, planks.item, planks.amountOfPlanksPerPallet) then
            exports.ox_inventory:AddItem(source, pallets.item, pallets.amountOfPalletsMade)
        end
    else
        lib.notify(source, {
            title = 'Unable',
            description = "Inventory full",
            type = 'error'
        })
    end
end)

RegisterNetEvent('lumberjack:server:SellItem', function(data)
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end
    
    local itemAmount = exports.ox_inventory:Search(source, 'count', data.item)

    if itemAmount <= 0 then
        lib.notify(source, {
            title = 'Unable',
            description = "You don't have anything to sell",
            type = 'inform'
        })
        return
    end

    local salesValue = (itemAmount * data.value)

    if exports.ox_inventory:CanCarryItem(source, 'money', salesValue) then
        if exports.ox_inventory:RemoveItem(source, data.item, itemAmount) then
            exports.ox_inventory:AddItem(source, 'money', salesValue)
        end
    else
        lib.notify(source, {
            title = 'Unable',
            description = "Inventory full",
            type = 'error'
        })
    end
end)

RegisterNetEvent('lumberjack:server:PlaceTableSaw', function(itemCoords, newHeading)
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end

    if not exports.ox_inventory:RemoveItem(source, Config.Lumberyard.EquipmentBuying.tableSawItem.item, 1) then
        return
    end

    local objectPlaced = CreateObjectNoOffset('prop_crosssaw_01', itemCoords.x, itemCoords.y, itemCoords.z, true, true, false)
    SetEntityHeading(objectPlaced, newHeading)
    FreezeEntityPosition(objectPlaced, true)

    Wait(500)
    local newEntity = NetworkGetNetworkIdFromEntity(objectPlaced)
    
    TriggerClientEvent('lumberjack:client:CreateEntityTarget', -1, newEntity, objectPlaced, itemCoords)

end)

RegisterNetEvent('lumberjack:server:CollectTableSaw', function(data)
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end
    
    if exports.ox_inventory:CanCarryItem(source, Config.Lumberyard.EquipmentBuying.tableSawItem.item, 1) then
        DeleteEntity(data.args.object)
        exports.ox_inventory:AddItem(source, Config.Lumberyard.EquipmentBuying.tableSawItem.item, 1)
    else
        lib.notify(source, {
            title = 'Unable',
            description = "Inventory full",
            type = 'error'
        })
    end
end)

RegisterNetEvent('lumberjack:server:RecieveTreeLumber', function()
    local player = QBCore.Functions.GetPlayer(source)

    if not player then
        return
    end
    
    local lumberAmount = math.random(1, 4) -- Amount of logs acquired after cutting a tree
    local barkAmount = math.random(2, 5) -- Amount of bark acquired after cutting a tree
    local barkChance = math.random(1, 100)

    if exports.ox_inventory:CanCarryItem(source, 'lumber', lumberAmount) then
        exports.ox_inventory:AddItem(source, 'lumber', lumberAmount)

        if barkChance < Config.CoreInfo.ChanceForBark then
            if exports.ox_inventory:CanCarryItem(source, 'bark', barkAmount) then
                exports.ox_inventory:AddItem(source, 'bark', barkAmount)
            end
        end
    else
        lib.notify(source, {
            title = 'Unable',
            description = "Inventory full",
            type = 'error'
        })
    end
end)

-----------------
--Useable Items--
-----------------

QBCore.Functions.CreateUseableItem(Config.Lumberyard.EquipmentBuying.tableSawItem.item, function(source)
    TriggerClientEvent('lumberjack:client:PlaceTablesaw', source)
end)