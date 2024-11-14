RegisterNetEvent('lumberjack:client:SpawnVehicle', function(data)
    local player = cache.ped
    local lumberVehicle = lib.requestModel(data.Model)

    for k, v in pairs(Config.Lumberyard.Vehicles.SpawnLocations) do
        if not IsAnyVehicleNearPoint(v.x, v.y, v.z, 5.0) then
            local moneyRemoved = lib.callback.await('lumberjack:server:RemoveVehicleSpawnCost', false, data.Cost)

            if not moneyRemoved then
                lib.notify({
                    title = 'Unable',
                    description = "You don't have the enough cash to rent this vehicle",
                    type = 'error'
                })
                return
            end
    
            QBCore.Functions.SpawnVehicle(lumberVehicle, function(jobVehicle)
                local plate = "LUMB"..tostring(math.random(1000, 9999))
    
                SetVehicleNumberPlateText(jobVehicle, plate)
                SetEntityHeading(jobVehicle, v.w)
                Entity(jobVehicle).state.fuel = 100
                TaskWarpPedIntoVehicle(player, jobVehicle, -1)
                TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(jobVehicle))
                SetVehicleEngineOn(jobVehicle, true, true)
            end, v, true)
    
            local alert = lib.alertDialog({
                header = 'Foreman:',
                content = "Time to get to work!\n\nGrab your axe and start hacking at those trees! Whatever you bring back, I'll buy at a fair price"
                .."or you can process it yourself!",
                centered = true,
                cancel = false
            })
            return
        end
    end

    lib.notify({
        title = "Attention",
        description = "Vehicle blocking depot",
        type = 'inform'
    })
end)

RegisterNetEvent("lumberjack:client:RemoveSpawnedVehicle", function(data)
    local currentVehicle = GetLastDrivenVehicle(cache.ped)
	local vehicleCoords = GetEntityCoords(currentVehicle)
	local foremanCoords = GetEntityCoords(data.entity)
	local distance = #(vehicleCoords - foremanCoords)

    if currentVehicle == nil then
        lib.notify({
            title = 'Missing',
            description = "You don't have a vehicle to return",
            type = 'error'
        })
        return
    end

    if distance < 15 then
        QBCore.Functions.DeleteVehicle(currentVehicle)
        lib.notify({
            title = 'Returned',
            description = 'You returned the vehicle!',
            type = 'error'
        })
    else
        lib.notify({
            title = 'Unable',
            description = 'Your vehicle is too far away',
            type = 'error'
        })
        return
    end
end)