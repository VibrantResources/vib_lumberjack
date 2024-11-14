RegisterNetEvent('lumberjack:client:EquipmentMenu', function()
	local headerMenu = {}
    local moneyAmount = exports.ox_inventory:Search('count', 'money')

    headerMenu[#headerMenu + 1] = {
        title = "Cutting axe",
        description = "Start felling trees!",
        serverEvent = 'lumberjack:server:PurchaseEquipment',
        args = Config.Lumberyard.EquipmentBuying.TreeChoppingItem,
        icon = 'fa-solid fa-tree',
        iconColor = "yellow",
        disabled = moneyAmount < Config.Lumberyard.EquipmentBuying.TreeChoppingItem.Price,
    }

    headerMenu[#headerMenu + 1] = {
        title = "Table Saw",
        description = "Place this down and start turning your lumber into finely cut planks",
        serverEvent = 'lumberjack:server:PurchaseEquipment',
        args = Config.Lumberyard.EquipmentBuying.TableSawItem,
        icon = 'fa-solid fa-fan',
        iconColor = "yellow",
        disabled = moneyAmount < Config.Lumberyard.EquipmentBuying.TableSawItem.Price,
    }

    lib.registerContext({
        id = 'equipment_menu',
        title = "Lumberjacking Equipment",
        options = headerMenu,
    })

    lib.showContext('equipment_menu')
end)