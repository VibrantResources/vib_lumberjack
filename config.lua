Config = Config or {}

Config.GenericStuff = {
    Debug = false,
    UseBlips = true,
    TreeCooldown =  1, -- Cooldown of each tree after being chopped in minutes
    ChanceForBark = 50, -- % chance to get bark when chopping a tree
}

Config.Lumberyard = {
    Foreman = { -- Ped where players can buy equipment and vehicles
        Model = "s_m_y_construct_01",
        Location = vector4(-554.62, 5349.31, 73.74, 68.4),
        Blip = {
            Location = vector3(-554.62, 5349.31, 74.74),
            Sprite = 85,
            Display = 6,
            Scale = 1.0,
            Color = 25,
            Label = 'Lumberyard',
        },
    },
    Vehicles = { -- Vehicles that display in the menu for players to spawn
        SpawnLocations = {
            vector4(-574.87, 5369.26, 69.77, 249.71),
            vector4(-569.26, 5378.38, 69.72, 288.39),
            vector4(-547.68, 5379.04, 70.03, 85.77),
        },
        RentableVehicles = {
            {
                Model = 'tiptruck',
                Cost = 50,
            },
            {
                Model = 'blazer6',
                Cost = 50,
            },
        },
    },
    Processing = {
        Bark = {
            BarkSellingAreas = {
                {
                    vec3(-550.0, 5326.0, 74.0),
                    vec3(-550.0, 5325.0, 74.0),
                    vec3(-556.0, 5327.0, 74.0),
                    vec3(-554.0, 5332.0, 74.0),
                    vec3(-548.0, 5330.0, 74.0),
                },
            },
            Item = 'tree_bark',
            ProcessAmountPerTick = 10, -- Amount of [tree_bark] it takes off the player per interaction if they have enough
            ValuePerBark = 1, -- How much each piece is worth
        },
        Logs = {
            Item = 'tree_lumber',
            AmountRequiredToMakePlank = 2, -- Amount of [tree_lumber] required to make [AmountOfPlanksMade]
        },
        Planks = {
            Item = 'wood_plank',
            AmountOfPlanksMade = 1, -- Amount of [wood_plank] recieved per [AmountRequiredToMakePlank]
            AmountOfPlanksPerPallet = 8,
        },
        Pallets = {
            PalletTargets = {
                vector3(-518.07, 5258.04, 80.45),
                vector3(-516.29, 5263.64, 80.44),
            },
            Item = 'wood_pallet',
            AmountOfPalletsMade = 1,
        },
    },
    EquipmentBuying = {
        TreeChoppingItem = {
            Item = 'WEAPON_Hatchet',
            Price = 175,
        },
        TableSawItem = {
            Item = 'table_saw',
            Price = 325,
        },
    },
}

Config.LumberSelling = { -- Where players sell [tree_lumber] & [wood_pallet]
    Ped = {
        Model = "s_m_y_construct_01",
        Location = vector4(1197.03, -3253.55, 6.09, 87.25)
    },
    Blip = {
        Location = vector3(1197.03, -3253.55, 6.09),
        Sprite = 477,
        Display = 6,
        Scale = 1.0,
        Color = 25,
        Label = 'Lumber Sales',
    },
    SellableItems = {
        Lumber = {
            Item = 'tree_lumber',
            ValuePerItem = math.random(2, 4),
        },
        Pallets = {
            Item = 'wood_pallet',
            ValuePerItem = math.random(70, 95),
        },
    },
}

Config.ChoppingItem = `WEAPON_Hatchet` -- Item needed in hand to chop a tree

Config.Trees = { -- Locations of trees (Add as many more as you like, there's 100 by default)
    vector3(-504.47, 5392.09, 75.82),
    vector3(-510.08, 5389.15, 73.71),
    vector3(-558.32, 5418.98, 62.78),
    vector3(-561.47, 5420.32, 62.39),
    vector3(-600.28, 5397.03, 52.48),
    vector3(-614.04, 5399.73, 50.86),
    vector3(-616.38, 5403.72, 50.59),
    vector3(-553.08, 5445.65, 64.16),
    vector3(-500.53, 5401.34, 75.05),
    vector3(-491.78, 5395.47, 77.57),
    vector3(-457.24, 5398.19, 79.35),
    vector3(-456.87, 5408.32, 79.26),
    vector3(-627.6, 5322.19, 59.86),
    vector3(-578.9, 5427.22, 58.54),
    vector3(-626.05, 5315.49, 60.87),
    vector3(-604.23, 5243.57, 71.53),
    vector3(-599.94, 5239.87, 71.87),
    vector3(-556.65, 5233.61, 72.53),
    vector3(-557.92, 5224.02, 77.24),
    vector3(-546.26, 5219.38, 77.94),
    vector3(-537.93, 5226.47, 78.52),
    vector3(-628.32, 5286.04, 63.76),
    vector3(-633.1, 5275.56, 69.11),
    vector3(-646.03, 5269.73, 74.01),
    vector3(-644.29, 5241.2, 76.3),
    vector3(-657.02, 5296.15, 69.35),
    vector3(-659.05, 5293.48, 70.02),
    vector3(-664.32, 5277.7, 74.4),
    vector3(-648.03, 5263.12, 75.24),
    vector3(-577.17, 5434.42, 59.81),
    vector3(-588.66, 5425.53, 56.88),
    vector3(-589.74, 5418.09, 55.6),
    vector3(-583.18, 5417.23, 56.64),
    vector3(-575.87, 5409.96, 56.77),
    vector3(-593.67, 5400.66, 52.85),
    vector3(-574.74, 5399.07, 55.67),
    vector3(-530.58, 5419.81, 63.72),
    vector3(-519.4, 5420.62, 65.17),
    vector3(-509.87, 5420.38, 66.31),
    vector3(-501.22, 5420.93, 67.7),
    vector3(-489.5, 5421.11, 68.77),
    vector3(-481.7, 5423.07, 68.68),
    vector3(-544.69, 5446.47, 66.73),
    vector3(-551.85, 5454.14, 65.85),
    vector3(-560.75, 5460.63, 63.96),
    vector3(-575.46, 5475.84, 60.08),
    vector3(-584.13, 5477.86, 57.81),
    vector3(-597.48, 5473.92, 56.71),
    vector3(-606.13, 5468.13, 57.07),
    vector3(-615.4, 5480.4, 52.84),
    vector3(-625.79, 5473.93, 53.46),
    vector3(-628.39, 5471.19, 53.53),
    vector3(-631.26, 5466.98, 53.47),
    vector3(-629.64, 5460.28, 53.85),
    vector3(-611.27, 5487.5, 52.83),
    vector3(-608.88, 5500.18, 51.5),
    vector3(-603.38, 5507.43, 50.56),
    vector3(-577.56, 5501.17, 55.34),
    vector3(-569.39, 5489.33, 58.98),
    vector3(-591.54, 5483.13, 56.0),
    vector3(-615.89, 5248.89, 72.29),
    vector3(-611.93, 5240.25, 72.86),
    vector3(-611.54, 5231.39, 73.43),
    vector3(-619.35, 5232.2, 74.16),
    vector3(-627.97, 5233.69, 75.15),
    vector3(-629.57, 5243.6, 74.35),
    vector3(-632.79, 5264.29, 72.5),
    vector3(-652.28, 5253.12, 75.81),
    vector3(-665.95, 5253.79, 76.24),
    vector3(-675.4, 5275.31, 74.99),
    vector3(-667.66, 5288.72, 71.73),
    vector3(-668.59, 5296.45, 69.08),
    vector3(-674.28, 5292.1, 69.68),
    vector3(-674.85, 5284.96, 72.51),
    vector3(-702.07, 5322.98, 70.73),
    vector3(-715.67, 5329.15, 71.06),
    vector3(-718.88, 5341.0, 67.82),
    vector3(-706.54, 5346.41, 67.99),
    vector3(-697.05, 5340.85, 68.56),
    vector3(-698.59, 5333.31, 69.8),
    vector3(-665.43, 5333.3, 63.66),
    vector3(-662.1, 5343.94, 61.94),
    vector3(-664.61, 5351.97, 61.49),
    vector3(-660.55, 5359.52, 58.77),
    vector3(-670.83, 5357.5, 62.81),
    vector3(-665.84, 5367.71, 58.24),
    vector3(-663.97, 5373.5, 55.97),
    vector3(-675.95, 5369.4, 60.64),
    vector3(-682.92, 5374.96, 59.65),
    vector3(-691.23, 5383.92, 57.57),
    vector3(-686.56, 5388.01, 55.77),
    vector3(-680.06, 5391.14, 53.83),
    vector3(-678.6, 5399.31, 51.18),
    vector3(-664.15, 5399.2, 51.99),
    vector3(-657.22, 5388.12, 53.9),
    vector3(-653.01, 5383.52, 53.49),
    vector3(-643.87, 5388.48, 49.99),
    vector3(-647.15, 5400.5, 48.95),
    vector3(-651.07, 5414.01, 45.25),
    vector3(-652.65, 5421.79, 44.9),
    vector3(-654.89, 5424.0, 45.07),
    vector3(-532.14, 5401.74, 71.36),
    vector3(-525.83, 5393.45, 71.22),
    vector3(-521.86, 5401.28, 73.53),
    vector3(-517.74, 5393.62, 72.58),
    vector3(-511.91, 5401.09, 75.07),
    vector3(-788.95, 5438.24, 35.66),
    vector3(-767.62, 5429.01, 37.18),
    vector3(-611.17, 5286.03, 62.09),
    vector3(-630.43, 5293.14, 61.55),
    vector3(-623.09, 5282.14, 62.62),
    vector3(-591.64, 5269.36, 66.0),
    vector3(-591.83, 5247.19, 69.1),
    vector3(-645.87, 5314.66, 58.82),
    vector3(-659.28, 5301.63, 67.24),
    vector3(-650.48, 5299.66, 67.22),
    vector3(-655.46, 5310.45, 61.09),
    vector3(-660.42, 5288.22, 71.33),
    vector3(-709.3, 5335.23, 69.72),
    vector3(-577.17, 5444.13, 60.64),
    vector3(-568.86, 5432.15, 61.0),
    vector3(-614.95, 5445.98, 55.1),
    vector3(-624.81, 5443.25, 53.45),
    vector3(-484.65, 5395.48, 77.51),
    vector3(-452.8, 5403.6, 78.87),
    vector3(-648.32, 5436.17, 50.82),
    vector3(-645.17, 5453.61, 52.18),
    vector3(-643.15, 5460.36, 52.61),
    vector3(-643.18, 5467.84, 52.61),
    vector3(-648.74, 5474.2, 51.51),
    vector3(-655.76, 5468.04, 51.41),
    vector3(-650.28, 5463.76, 51.78),
    vector3(-482.97, 5389.86, 78.16),
    vector3(-475.02, 5394.18, 78.31),
    vector3(-468.63, 5401.35, 78.32),
    vector3(-597.71, 5422.75, 53.88),
    vector3(-597.64, 5422.61, 53.84),
    vector3(-602.47, 5425.54, 53.28),
    vector3(-606.59, 5432.36, 53.82),
    vector3(-606.04, 5439.76, 54.9),
    vector3(-598.96, 5443.2, 56.91),
    vector3(-586.32, 5446.95, 59.56),
    








}