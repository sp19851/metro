Config = {}
Config.metro = {}
Config.metro = {
    pedmodel = 's_m_m_lsmetro_01',
    scenario = 'WORLD_HUMAN_COP_IDLES',
    ticketMachine = 'prop_train_ticket_02',
    price = 15
}

Config.blips = {}
Config.blips = {
    need = true,
    label = 'Станция метро',
    sprite = 78,
    color = 64,
    scale = 0.4,
    stations = {
       [1] = {
        name = 'Airoport',
        coords = vector3(-1041.17, -2743.15, 13.95)
       }, 
       [2] = {
        name = 'Puerto del Sol',
        coords = vector3(-537.14, -1277.99, 26.9)
       }, 
       [3] = {
        name = 'RockFordPlaza',
        coords = vector3(-245.41, -335.77, 29.98)
       }, 
       [4] = {
        name = 'NorthRockfordDrive',
        coords = vector3(-1368.56, -528.05, 30.32)
       }, 
       [5] = {
        name = 'LittleSeul',
        coords = vector3(-491.18, -695.18, 33.21)
       } ,
       [5] = {
        name = 'AltaStreet',
        coords = vector3(-212.67, -1023.66, 30.14)
       } 
    }
}

Config.metro.lines = {
    [1] = {
        [1] = {
            id = 1,
            name = 'airport',
            label = 'Аэропорт Лос-Сантос',
            coordsPed = vector4(-1061.52, -2695.06, -7.41, 132.27),
            coordsTrainStart = vector4(-1112.84, -2762.55, -8.32, 312.52),
            coordsTrainStop = vector4(-1058.47, -2697.6, -8.28, 316.41),
            coordsExit = vector4(-1065.4, -2699.78, -7.41, 93.02)
        },
        [2] = {
            id = 2,
            name = 'b_innosenc',
            label = 'Бульвар Инносенс',
            coordsPed = vector4(-533.91, -1269.94, 26.9, 248.07),
            coordsTrainStop = vector4(-531.33, -1273.31, 25.9, 333.84),
            coordsTrainStart = vector4(-568.7, -1346.02, 23.5, 335.34),
            coordsExit = vector4(-535.73, -1276.31, 26.9, 3.81)
        },

        [3] = {
            id = 3,
            name = 'b_san_vitus',
            label = 'Бульвар Сан-Витус',
            coordsPed = vector4(-290.51, -298.28, 10.06, 179.12),
            coordsTrainStop = vector4(-287.18, -301.93, 8.67, 359.64),
            coordsTrainStart = vector4(-287.43, -370.68, 8.64, 1.17),
            coordsExit = vector4(-289.32, -309.97, 10.06, 63.73)
        },
        [4] = {
            id = 4,
            name = 'n-rockf-drive',
            label = 'Норт-Рокфорд-Драйв',
            coordsPed = vector4(-1338.73, -494.22, 15.05, 26.51),
            coordsTrainStop = vector4(-1342.95, -494.59, 13.65, 208.54),
            coordsTrainStart = vector4(-1377.65, -434.55, 13.62, 209.97),
            coordsExit = vector4(-1344.66, -485.88, 15.05, 341.6)
        },
        [5] = {
            id = 5,
            name = 'sa-avenu',
            label = 'Сан-Андреас Авеню(молл)',
            coordsPed = vector4(-469.25, -676.64, 11.81, 93.44),
            coordsTrainStop = vector4(-470.41, -680.2, 10.41, 269.85),
            coordsTrainStart = vector4(-567.57, -678.09, 10.46, 261.06),
            coordsExit = vector4(-481.88, -678.39, 11.81, 350.4)
        },
        [6] = {
            id = 6,
            name = 'alta-street',
            label = 'Альта-стрит(мэрия)',
            coordsPed = vector4(-219.91, -1046.5, 30.14, 344.26),
            coordsTrainStop = vector4(-222.59, -1045.03, 29.33, 162.91),
            coordsTrainStart = vector4(-169.71, -894.99, 20.19, 175.74),
            coordsExit = vector4(-218.42, -1039.45, 30.14, 250.0)
        },
    }
}