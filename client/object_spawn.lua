RegisterNetEvent('lumberjack:client:PlaceTablesaw', function()
    local player = cache.ped
    local playerCoords = cache.coords
    local finalHeading = nil

    if placeableItemUsed then
        return
    end

    if GetVehiclePedIsIn(player, false) ~= 0 then
        return
    end

    local itemModel = lib.requestModel('prop_crosssaw_01')
    local itemShadow = CreateObject(itemModel, playerCoords, false, true, true)

    SetEntityAlpha(itemShadow, 170, false)
    SetEntityCollision(itemShadow, false, false)
    FreezeEntityPosition(itemShadow, true)
    SetModelAsNoLongerNeeded(itemModel)
    placeableItemUsed = true

    lib.showTextUI("[E] - place\n[X] - rotate\n[G] - cancel")

    while not placeableItemPlaced do
        local hit, entityHit, itemCoords, surface, hash = lib.raycast.cam(1, 7, 10)
        if not hit then return end

        SetEntityCoords(itemShadow, itemCoords)
        PlaceObjectOnGroundProperly(itemShadow)
        DisableControlAction(0, 24, true)

        if IsControlPressed(0, 105) then -- Hold X to Rotate
            local currentHeading = GetEntityHeading(itemShadow)
            newHeading = (currentHeading + 1.5)

            SetEntityHeading(itemShadow, newHeading)
        end

        if IsControlJustPressed(0, 47) then -- Press G to cancel
            lib.hideTextUI()
            DeleteEntity(itemShadow)
            placeableItemPlaced = false
            placeableItemUsed = false
            break
        end

        if IsControlJustPressed(0, 38) then -- Press E to place
			lib.hideTextUI()
            DeleteEntity(itemShadow)
            TriggerServerEvent('lumberjack:server:PlaceTableSaw', itemCoords, newHeading)
            placeableItemPlaced = false
            placeableItemUsed = false
            break
        end

        Wait(0)
    end
end)