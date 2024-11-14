QBCore = exports['qb-core']:GetCoreObject()

----------
--Events--
----------

RegisterNetEvent('lumberjack:server:PurchaseEquipment', function(data)
	if exports.ox_inventory:CanCarryItem(source, data.Item, 1) then
        if exports.ox_inventory:RemoveItem(source, 'money', data.Price) then
            exports.ox_inventory:AddItem(source, data.Item, 1)
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
	if exports.ox_inventory:CanCarryItem(source, Config.Lumberyard.Processing.Planks.Item, Config.Lumberyard.Processing.Planks.AmountOfPlanksMade) then
        if exports.ox_inventory:RemoveItem(source, Config.Lumberyard.Processing.Logs.Item, Config.Lumberyard.Processing.Logs.AmountRequiredToMakePlank) then
            exports.ox_inventory:AddItem(source, Config.Lumberyard.Processing.Planks.Item, Config.Lumberyard.Processing.Planks.AmountOfPlanksMade)
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
    if exports.ox_inventory:CanCarryItem(source, Config.Lumberyard.Processing.Pallets.Item, Config.Lumberyard.Processing.Planks.AmountOfPalletsMade) then
        if exports.ox_inventory:RemoveItem(source, Config.Lumberyard.Processing.Planks.Item, Config.Lumberyard.Processing.Planks.AmountOfPlanksPerPallet) then
            exports.ox_inventory:AddItem(source, Config.Lumberyard.Processing.Pallets.Item, Config.Lumberyard.Processing.Pallets.AmountOfPalletsMade)
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
    local itemAmount = exports.ox_inventory:Search(source, 'count', data.Item)

    if itemAmount <= 0 then
        lib.notify(source, {
            title = 'Unable',
            description = "You tryna sell me wood dust?",
            type = 'error'
        })
        return
    end

    local salesValue = (itemAmount * data.ValuePerItem)

    if exports.ox_inventory:CanCarryItem(source, 'money', salesValue) then
        if exports.ox_inventory:RemoveItem(source, data.Item, itemAmount) then
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

    if not exports.ox_inventory:RemoveItem(source, Config.Lumberyard.EquipmentBuying.TableSawItem.Item, 1) then
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
    if exports.ox_inventory:CanCarryItem(source, Config.Lumberyard.EquipmentBuying.TableSawItem.Item, 1) then
        DeleteEntity(data.args.object)
        exports.ox_inventory:AddItem(source, Config.Lumberyard.EquipmentBuying.TableSawItem.Item, 1)
    else
        lib.notify(source, {
            title = 'Unable',
            description = "Inventory full",
            type = 'error'
        })
    end
end)

RegisterNetEvent('lumberjack:server:RecieveTreeLumber', function()
    local lumberAmount = math.random(1, 4) -- Amount of logs acquired after cutting a tree
    local barkAmount = math.random(2, 5) -- Amount of bark acquired after cutting a tree
    local barkChance = math.random(1, 100)

    if exports.ox_inventory:CanCarryItem(source, 'tree_lumber', lumberAmount) then
        exports.ox_inventory:AddItem(source, 'tree_lumber', lumberAmount)

        if barkChance < Config.GenericStuff.ChanceForBark then
            if exports.ox_inventory:CanCarryItem(source, 'tree_bark', barkAmount) then
                exports.ox_inventory:AddItem(source, 'tree_bark', barkAmount)
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

QBCore.Functions.CreateUseableItem(Config.Lumberyard.EquipmentBuying.TableSawItem.Item, function(source)
    TriggerClientEvent('lumberjack:client:PlaceTablesaw', source)
end)

-------------
--Callbacks--
-------------

lib.callback.register('lumberjack:server:RemoveVehicleSpawnCost', function(source, data)
    local removedMoney = exports.ox_inventory:RemoveItem(source, 'money', data)

    return removedMoney
end)

-- lib.addCommand('relog', { -- Literally just a relog command for testing
-- 	help = 'Reload your character',
-- }, function(source, args)
-- 	TriggerClientEvent('QBCore:Client:OnPlayerLoaded', source)
-- end)