local QBCore = exports['qb-core']:GetCoreObject()

if Config.CoreInfo.UseBlips then
    local lumberyard = Config.Lumberyard.Foreman.blip
    local lumberSeller = Config.LumberSelling.Blip

    CreateThread(function()
        local lumberyardBlip = AddBlipForCoord(lumberyard.location)
        SetBlipSprite (lumberyardBlip, lumberyard.sprite)
        SetBlipDisplay(lumberyardBlip, lumberyard.display)
        SetBlipScale  (lumberyardBlip, lumberyard.scale)
        SetBlipAsShortRange(lumberyardBlip, true)
        SetBlipColour(lumberyardBlip, lumberyard.color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(lumberyard.label)
        EndTextCommandSetBlipName(lumberyardBlip)

        local lumberSellerBlip = AddBlipForCoord(lumberSeller.location)
        SetBlipSprite (lumberSellerBlip, lumberyard.sprite)
        SetBlipDisplay(lumberSellerBlip, lumberyard.display)
        SetBlipScale  (lumberSellerBlip, lumberyard.scale)
        SetBlipAsShortRange(lumberSellerBlip, true)
        SetBlipColour(lumberSellerBlip, lumberyard.color)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(lumberyard.label)
        EndTextCommandSetBlipName(lumberSellerBlip)
    end)
end