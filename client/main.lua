QBCore = exports['qb-core']:GetCoreObject()

-------------
--Variables--
-------------

local placeableItemUsed = false
local placeableItemPlaced = false
cuttingWood = false

RegisterNetEvent('lumberjack:client:ProcessWoodIntoPlanks', function(data)
    local player = cache.ped
    local treeLumberAmount = exports.ox_inventory:Search('count', Config.Lumberyard.Processing.logs.item)

    if treeLumberAmount < Config.Lumberyard.Processing.logs.amountRequiredToMakePlank then
        lib.notify({
            title = 'Unable',
            description = "You don't have enough logs to make any planks",
            type = 'error'
        })
        return
    end

    cuttingWood = true
    CreateThread(function()
        while cuttingWood do
            lib.requestNamedPtfxAsset('core')
            UseParticleFxAsset("core")
            -- StartNetworkedParticleFxLoopedOnEntity(effectName, entity, xOffset, yOffset, zOffset, xRot, yRot, zRot, scale, xAxis, yAxis, zAxis)
            local tableSawPTX = StartNetworkedParticleFxLoopedOnEntity("ent_brk_tree_trunk_bark", data.args.entity, 0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.5)
            Wait(300)
        end
    end)

    lib.requestAnimDict('mini@repair')

    repeat
        if lib.progressCircle({
            duration = 5000,
            label = 'Cutting planks',
            useWhileDead = false,
            canCancel = true,
            disable = {
                car = true,
                move = true,
                combat = true,
            },
            animation = {
                dict = "mini@repair",
                clip = "fixing_a_ped",
            },
        }) then
            TriggerServerEvent('lumberjack:server:ProcessLumber')
            ClearPedTasks(player)
        else
            cuttingWood = false
            ClearPedTasks(player)
            lib.notify({
                title = "Canceled",
                description = 'You stopped cutting wood',
                type = 'inform'
            })
        end
        Wait(100)
        treeLumberAmount = exports.ox_inventory:Search('count', Config.Lumberyard.Processing.logs.item)

        if treeLumberAmount <= 0 then
            cuttingWood = false
            ClearPedTasks(player)

            return
        end
    until cuttingWood == false
end)

RegisterNetEvent('lumberjack:client:PackagePlanks', function()
    local plankAmount = exports.ox_inventory:Search('count', Config.Lumberyard.Processing.planks.item)

    if plankAmount < Config.Lumberyard.Processing.planks.amountOfPlanksPerPallet then
        lib.notify({
            title = 'Unable',
            description = "You don't have enough planks to make a pallet",
            type = 'error'
        })

        return
    end

    if lib.progressCircle({
        duration = 7500,
        label = 'Bundling planks',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true,
        },
        anim = {
			dict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@",
			clip = "machinic_loop_mechandplayer",
        },
    }) then
        TriggerServerEvent('lumberjack:server:ProcessPlanks')
    else
        lib.notify({
            title = "Canceled",
            description = 'Canceled',
            type = 'error'
        })
    end
end)

-------------
--Functions--
-------------

RegisterNetEvent('lumberjack:client:HarvestTree', function(data)
    local player = cache.ped
    local playerCoords = GetEntityCoords(player)

    if #(playerCoords - data.coords) > 5 then
        return
    end

    local cooldown = lib.callback.await('lumberjack:server:GetTreeCooldown', false, data.args.treeNumber)

    if cooldown > 0 then 
        lib.notify({
            title = 'Unable',
            description = 'This tree has been harvested already',
            type = 'error'
        })
        return
    end

    local playerWeapon = GetSelectedPedWeapon(player)

    if playerWeapon ~= Config.ChoppingItem then
        lib.notify({
            title = 'Missing Tools',
            description = "You don't have the right equipment for this",
            type = 'error'
        })
        return
    end
    
    TaskTurnPedToFaceEntity(player, data.entity, 2500)

    if lib.progressCircle({
        duration = 5000,
        label = 'Chopping Tree',
        useWhileDead = false,
        canCancel = true,
        disable = {
            move = true,
            car = true,
            combat = true,
            mouse = false,
        },
        anim = {
            dict = 'melee@hatchet@streamed_core',
            clip = 'plyr_rear_takedown_b'
        },
    }) then
        TriggerServerEvent('lumberjack:server:RecieveTreeLumber')
        TriggerServerEvent('lumberjack:server:TreeCooldown', data.args.treeNumber)
    else
        lib.notify({
            title = 'Canceled',
            description = 'Canceled',
            type = 'error'
        })
    end
end)