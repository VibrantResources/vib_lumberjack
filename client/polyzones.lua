local alreadyActive = false

CreateThread(function()
    for _, zoneCoords in pairs(Config.Lumberyard.Processing.bark.barkSellingAreas) do
        lib.zones.poly({
            points = zoneCoords,
            thickness = 5,
            debug = Config.CoreInfo.Debug,
            inside = function()
                local barkAmount = exports.ox_inventory:Search('count', Config.Lumberyard.Processing.bark.item)

                if IsControlJustPressed(0, 38) then
                    if alreadyActive then
                        lib.notify({
                            title = 'Unable',
                            description = "You're already shoveling",
                            type = 'inform'
                        })
                        return
                    end

                    if barkAmount <= 0 then
                        lib.notify({
                            title = 'Unable',
                            description = "Why don't you leave and come back when you have enough bark to shovel off",
                            type = 'error'
                        })
                        StopShovelingWithProp()
                    end
                    
                    ShovelingAnimationWithProp()

                    CreateThread(function()
                        while true do
                            Wait(250)
                            local barkPayment = lib.callback.await('lumberjack:server:SellBark', false)

                            if not alreadyActive then
                                return
                            end

                            if not barkPayment then
                                lib.notify({
                                    title = 'Unable',
                                    description = "You've run out of bark",
                                    type = 'inform'
                                }) 
                                StopShovelingWithProp()

                                return
                            end
                        end
                    end)
                end

                if IsControlJustPressed(0, 47) then
                    alreadyActive = false
                    StopShovelingWithProp()
                end
            end,
            onEnter = function()
                lib.showTextUI("[E] - Start shoveling bark\n[G] - Cancel")
            end,
            onExit = function()
                alreadyActive = false
                StopShovelingWithProp()
            end,
        })
    end
end)

function StopShovelingWithProp()
    lib.hideTextUI()
    ClearPedTasksImmediately(cache.ped)
    DeleteObject(shovel)
    alreadyActive = false
end

function ShovelingAnimationWithProp()
    local player = cache.ped
    local playerCoords = GetEntityCoords(player)

    lib.requestAnimDict('random@burial')
    lib.RequestModel('prop_tool_shovel')
    TaskPlayAnim(player, 'random@burial', 'a_burial', 1.0, 1.0, -1, 01, 0, true, true, true)
    shovel = CreateObject('prop_tool_shovel', playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
    AttachEntityToEntity(shovel, player, GetPedBoneIndex(player, 28422), 0.0, 0.0, 0.240, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    alreadyActive = true
end