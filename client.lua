local QBCore = exports['qb-core']:GetCoreObject()

local Keys = {
    ['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
    ['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
    ['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
    ['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
    ['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
    ['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
    ['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
    ['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
}

local loaded = false
local train = nil
local trainDr = nil
local inTrain = false
local MetroBlipsSt = {}

--functions--
local function CrPed(model, coords)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end
    local ped = CreatePed(0, model, coords.x, coords.y, coords.z-1.0, coords.w, false, false)
    return ped
end

local function LoadTrainModels() -- f*ck your rails, too!
	local tempmodel = GetHashKey("freight")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end

	tempmodel = GetHashKey("freightcar")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end

	tempmodel = GetHashKey("freightgrain")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end

	tempmodel = GetHashKey("freightcont1")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end

	tempmodel = GetHashKey("freightcont2")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end

	tempmodel = GetHashKey("freighttrailer")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end

	tempmodel = GetHashKey("tankercar")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end

	tempmodel = GetHashKey("metrotrain")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end

	tempmodel = GetHashKey("s_m_m_lsmetro_01")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end

	--[[tempmodel = GetHashKey("lasubway")
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end]]

	if Debug then
		if Debug then print("FiveM-Trains: Train Models Loaded" ) end
	end
end

local function RequestModelSync(mod) -- eh
	tempmodel = GetHashKey(mod)
	RequestModel(tempmodel)
	while not HasModelLoaded(tempmodel) do
		RequestModel(tempmodel)
		Citizen.Wait(0)
	end
end

local function openMenu(data)
    if QBCore.Functions.HasItem('ticketmetro') then
        local metroMenu = {
            {
                header = "Линия №" ..data.currentLine,
                txt = ""
            }
        }
        for i, v in pairs(Config.metro.lines[data.currentLine]) do
            if v.id > data.currentStop then
                metroMenu[#metroMenu+1] = {
                    header = v.label,
                    txt = v.id,
                    params = {
                        event = "metro:client:takeTrain",
                        args = {
                            targetStation = v.name,
                            targetLabel = v.label,
                            targerCoords = v.coordsTrainStop,
                            startCoords = data.startCoords,
                            stopCoords = data.stopCoords,
                            exitCoords = v.coordsExit
                        }
                    }
                }
            end
        end
        metroMenu[#metroMenu+1] = {
            header = "⬅ Закрыть меню",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }
    
        }
        exports['qb-menu']:openMenu(metroMenu)
    else
        QBCore.Functions.Notify('У вас нет билета, купите его в автомате', 'error', 7500)
    end
end


local function LeaveTrain(train, exit)
    --[[while IsPedInVehicle(PlayerPedId(), train, false) do
        Wait(100)
    end]]
    SetEntityCoords(PlayerPedId(), exit.x, exit.y, exit.z, 1, 1, 1, 1)
    Wait(20000)
    SetTrainCruiseSpeed(train, 5.0) 
    Wait(20000)
    DeleteEntity(trainDr)
    DeleteMissionTrain(train)
    train = nil
    trainDr = nil
end

local function gotoStop(train, target, exit)
    local go = true
    while go do
        
        local dist = #(GetEntityCoords(train) - vec3(target.x, target.y, target.z))
        --print('156 go dist', dist)
        if dist < 100.0 and dist > 2.0 then
            SetTrainCruiseSpeed(train, 10.0) 
        end
        if dist <= 2.0 then
            
            SetTrainCruiseSpeed(train, 0.0) 
           
            inTrain = false
            Wait(1500)
            QBCore.Functions.Notify('Ваша остановка')
            go = false
            LeaveTrain(train, exit)
        end 
        Wait(100)
    end
end

local function train_feed(train, stop, target, exit)
    local feed = true
    while feed do
        local dist = #(GetEntityCoords(train) - vec3(stop.x, stop.y, stop.z))
        if dist <= 2.0 then
            feed = false
            SetTrainCruiseSpeed(train, 0.0) 
            QBCore.Functions.Notify('Поезд подан')
            Wait(1500)
            
            TaskWarpPedIntoVehicle(PlayerPedId(),  train,  0)
            inTrain = true
            Wait(1500)
            SetTrainCruiseSpeed(train, 30.0) 
            gotoStop(train, target, exit)
           
            --FreezeEntityPosition(PlayerPedId(), true)
        end 
        Wait(100)
    end
end

local function DisableActions(disableMouse, disableMovement, disableCarMovement, disableCombat)
    if disableMouse then
        DisableControlAction(0, 1, true) -- LookLeftRight
        DisableControlAction(0, 2, true) -- LookUpDown
        DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
    end

    if disableMovement then
        DisableControlAction(0, 30, true) -- disable left/right
        DisableControlAction(0, 31, true) -- disable forward/back
        DisableControlAction(0, 36, true) -- INPUT_DUCK
        DisableControlAction(0, 21, true) -- disable sprint
    end

    if disableCarMovement then
        DisableControlAction(0, 63, true) -- veh turn left
        DisableControlAction(0, 64, true) -- veh turn right
        DisableControlAction(0, 71, true) -- veh forward
        DisableControlAction(0, 72, true) -- veh backwards
        DisableControlAction(0, 75, true) -- disable exit vehicle
    end

    if disableCombat then
        
        DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing

        


        DisableControlAction(0, 24, true) -- disable attack
        DisableControlAction(0, 25, true) -- disable aim
        DisableControlAction(1, 37, true) -- disable weapon select
        DisableControlAction(0, 47, true) -- disable weapon
        DisableControlAction(0, 58, true) -- disable weapon
        DisableControlAction(0, 140, true) -- disable melee
        DisableControlAction(0, 141, true) -- disable melee
        DisableControlAction(0, 142, true) -- disable melee
        DisableControlAction(0, 143, true) -- disable melee

        DisableControlAction(0, 20, true) -- Z
        DisableControlAction(0, 48, true) -- Z
        DisableControlAction(1, 20, true) -- Z
        DisableControlAction(1, 48, true) -- Z
        DisableControlAction(0, 200, true) -- pause menu 
        DisableControlAction(0, 244, true) -- phone
        DisableControlAction(0, 288, true) -- Disable phone

        DisableControlAction(0, 263, true) -- disable melee
        DisableControlAction(0, 264, true) -- disable melee
        DisableControlAction(0, 257, true) -- disable melee
        --print('disable', GetDisabledControlNormal(0, 244))
       
    end
    --DisableAllControlActions(0)
end

local function createBlip(coords, sprite, color, label, scale)
    --print('createBlip', coords, sprite, color, label)
    local blip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(blip, sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, true)
    SetBlipColour(blip, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName(label)
    EndTextCommandSetBlipName(blip)
    return blip
end


--events--

AddEventHandler('onClientResourceStart', function (resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    exports["qb-target"]:AddTargetModel(Config.metro.ticketMachine, {
        options = {
                {type = "server",
                event = "metro:server:buyTicket",
                icon = "fa-solid fa-ticket",
                label = "Купить билет за $"..Config.metro.price,
                
               }
           },
           distance = 1.5
    })

    local model = Config.metro.pedmodel
    for k, line in pairs(Config.metro.lines) do
        for indexstop, stop in pairs(line) do
           
            
            local coords = stop.coordsPed 
            local ped = CrPed(model, coords)
            while not DoesEntityExist(ped) do
                Wait(500)
            end
            --vehiclePolicePeds[i] = ped
            FreezeEntityPosition(ped, true)
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, true)
            TaskStartScenarioInPlace(ped, Config.metro.scenario, true, true)
            local args = {
                currentLine = k,
                currentStop = indexstop,
                startCoords = stop.coordsTrainStart,
                stopCoords = stop.coordsTrainStop,
                --exitCoords = stop.coordsExit
                
            }
            exports['qb-target']:AddTargetEntity(ped, {
                options = {
                    {
                        label = 'Показать билет',
                        icon = 'fa-solid fa-ticket',
                        action = function() -- This is the action it has to perform, this REPLACES the event and this is OPTIONAL
                            openMenu(args)
                        end,
                        --item = 'ticketmetro'
                        
                    }
                },
                distance = 2.0
            })
        end
    end

    for _, v in pairs(MetroBlipsSt) do
        if DoesBlipExist(v) then
            RemoveBlip(v)
        end
   end
   for index, value in pairs(Config.blips.stations) do
        print('349', index, vec3(value.coords.x, value.coords.y, value.coords.z), Config.blips.sprite, Config.blips.color, Config.blips.label,  Config.blips.scale)
        local blip = createBlip(vec3(value.coords.x, value.coords.y, value.coords.z), Config.blips.sprite, Config.blips.color, Config.blips.label,  Config.blips.scale)
        MetroBlipsSt[#MetroBlipsSt+1] = blip
        
   end
end)

RegisterNetEvent("metro:client:takeTrain")
AddEventHandler("metro:client:takeTrain", function(data)
    LoadTrainModels()
	--print('2', loaded)
	if loaded == false then
        RequestModelSync("freight")
        RequestModelSync("freightcar")
        RequestModelSync("freightgrain")
        RequestModelSync("freightcont1")
        RequestModelSync("freightcont2")
        RequestModelSync("freighttrailer")
        RequestModelSync("tankercar")
        RequestModelSync("metrotrain")
        RequestModelSync("s_m_m_lsmetro_01")
        loaded = true
	end
	
	--print('guanta:train rez', rez)
	if train == nil then 
        TriggerServerEvent("QBCore:Server:RemoveItem", "ticketmetro", 1, false)
		TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["ticketmetro"], "remove")
		--local coords = data.startCoords.x - 
		train = CreateMissionTrain(25, data.startCoords.x, data.startCoords.y,data.startCoords.z, true)
        QBCore.Functions.Notify('Ваш поезд сейчас подадут')

        local ped = Config.metro.pedmodel
        RequestModel(ped)
        while not HasModelLoaded(ped) do
            Wait(1)
        end
        trainDr =  CreatePedInsideVehicle(train, 26, GetHashKey(ped), -1, true, true) 


		--print('1')
		SetTrainSpeed(train, 5.0)
		SetTrainCruiseSpeed(train, 5.0)
		train_feed(train, data.stopCoords, data.targerCoords, data.exitCoords)
    else
        QBCore.Functions.Notify('Поезд уже в пути, ожидайте', 'error', 7500)
    end
end)



---threads-
CreateThread(function()
   while true do
        local sleep = 1500 
        if inTrain then
            sleep = 100
            DisableActions(false, true, true, true)
        end
        Wait(sleep)
   end
end)