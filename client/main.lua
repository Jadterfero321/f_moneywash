
------------------------
----------BLIP----------
------------------------

Citizen.CreateThread(function ()
    if Config.blip == true then
        blipp = CreateBlip(Config.blipc.x, Config.blipc.y, Config.blipc.z, Config.blipSprite, 11, Config.blipName)
    end
end)

Citizen.CreateThread(function ()
    SpawnNPC1()
    SpawnNPC()
end)

------------------------
-------SPAWN-NPC--------
------------------------

function SpawnNPC1()
    local peds = {
        { type=4, model=Config.npc}
    }

    for k, v in pairs(peds) do
        local hash = GetHashKey(v.model)
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(1)
        end

        --- SPAWN NPC---
        startNPC = CreatePed(v.type, hash, Config.blipc.x, Config.blipc.y, Config.blipc.z -1, Config.bliph, true, true)

        SetEntityInvincible(startNPC, true)
        SetEntityAsMissionEntity(startNPC, true)
        SetBlockingOfNonTemporaryEvents(startNPC, true)
        FreezeEntityPosition(startNPC, true)
    end
end

function SpawnNPC()
    local peds = {
        { type=4, model=Config.washerNPC}
    }

    for k, v in pairs(peds) do
        local hash = GetHashKey(v.model)
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(1)
        end

        --- SPAWN NPC---
        startNPC = CreatePed(v.type, hash, Config.washer.x, Config.washer.y, Config.washer.z -1, Config.washer, true, true)

        SetEntityInvincible(startNPC, true)
        SetEntityAsMissionEntity(startNPC, true)
        SetBlockingOfNonTemporaryEvents(startNPC, true)
        FreezeEntityPosition(startNPC, true)
    end
end

RegisterNetEvent('moneywash_start', function (arg)
    lib.registerContext({
        id = 'moneywash_start',
        title = 'Money Launering',
        options = {
            {
                title = 'Money Launering',
                description = 'Wash your dirty money to get legal money',
                icon = 'dollar',
                event = 'money'
            },
        
        }
    })
    lib.showContext('moneywash_start')
end)
------------------------
-------ORDER-NPC--------
------------------------

function Npc1()
    local peds = {
        { type=4, model=Config.npc}
    }

    for k, v in pairs(peds) do
        local hash = GetHashKey(v.model)
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(1)
        end

        --- SPAWN NPC---
        Npc1 = CreatePed(v.type, hash, Config.order1.x, Config.order1.y, Config.order1.z -1, Config.order1h, true, true)
        npcc1 = true


        SetEntityInvincible(Npc1, true)
        SetEntityAsMissionEntity(Npc1, true)
        SetBlockingOfNonTemporaryEvents(Npc1, true)
        FreezeEntityPosition(Npc1, true)
    end
end

function Npc2()
    local peds = {
        { type=4, model=Config.npc}
    }

    for k, v in pairs(peds) do
        local hash = GetHashKey(v.model)
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(1)
        end

        --- SPAWN NPC---
        Npc2 = CreatePed(v.type, hash, Config.order2.x, Config.order2.y, Config.order2.z -1, Config.order2h, true, true)
        npcc2 = true

        SetEntityInvincible(Npc2, true)
        SetEntityAsMissionEntity(Npc2, true)
        SetBlockingOfNonTemporaryEvents(Npc2, true)
        FreezeEntityPosition(Npc2, true)
    end
end

function Npc3()
    local peds = {
        { type=4, model=Config.npc}
    }

    for k, v in pairs(peds) do
        local hash = GetHashKey(v.model)
        RequestModel(hash)

        while not HasModelLoaded(hash) do
            Citizen.Wait(1)
        end

        --- SPAWN NPC---
        Npc3 = CreatePed(v.type, hash, Config.order3.x, Config.order3.y, Config.order3.z -1, Config.order3h, true, true)
        npcc3 = true

        SetEntityInvincible(Npc3, true)
        SetEntityAsMissionEntity(Npc3, true)
        SetBlockingOfNonTemporaryEvents(Npc3, true)
        FreezeEntityPosition(Npc3, true)
    end
end


------------------------
-------BLIP CREATE------
------------------------

function CreateBlip(x, y, z, sprite, color, name)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
    SetBlipDisplay(blip, 6)
    return blip
end

------------------------
        --------
------------------------

function money()
    if not IsModelInCdimage(ModelHash) then return end
    RequestModel(ModelHash) -- Request the model
    while not HasModelLoaded(ModelHash) do -- Waits for the model to load
      Wait(0)
    end
    local MyPed = PlayerPedId()
    SetModelAsNoLongerNeeded(ModelHash)
end

function wash()
    SetNewWaypoint(Config.washer.x, Config.washer.y)
    lib.notify({
        title = 'Go to the GPS Mark',
        description = 'GPS was set to the point',
        type = 'You started the laundering'
    })
end

function startwashing()
    
    gps = math.random(Config.random)
    if gps == 1 then
        SetNewWaypoint(Config.order1.x, Config.order1.y)
        if npcc1 == false then
            Npc1()    
        end 
    end
    if gps == 2 then
        SetNewWaypoint(Config.order2.x, Config.order2.y)
        if npcc2 == false then
            Npc2()
        end
        
    end
    if gps == 3 then
        SetNewWaypoint(Config.order3.x, Config.order3.y)
        if npcc3 == false then
            Npc3()
        end
        
    end
    
    
    
end


AddEventHandler('startmoney', function()
    money()
    wash()
end)

AddEventHandler('ownCar', function()
    wash()
end)

AddEventHandler('moneyLoad', function ()
    startwashing()
end)

AddEventHandler('giveD', function ()
    dGive()
end)
------------------------
        --QTARGET ZONES--
------------------------
RegisterNetEvent('moneywash_start_menu', function (arg)
    lib.registerContext({
        id = 'moneywash_start_menu',
        title = 'Dirty Money ',
        options = {
            {
                title = 'Money Laundering'
            },
            {
                title = 'start money laundering',
                description = 'Press to start',
                icon = 'car',
                event = 'startmoney',
            },

        
        }
    })
    lib.showContext('moneywash_start_menu')
end)

exports.ox_target:addBoxZone({
    coords = vector3(247.2944, -3315.7124, 5.7860),
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'start laundering',
            event = 'moneywash_start_menu',
            icon = 'fa-solid fa-money-bill',
            label = 'start laundering',
        }
    }

    
})

exports.ox_target:addBoxZone({
    coords = vector3(1042.5142, -1957.3120, 35.1342),
    size = vec3(2, 2, 2),
    rotation = 45,
    debug = drawZones,
    options = {
        {
            name = 'start laundering',
            event = 'moneywash_start',
            icon = 'fa-solid fa-cube',
            label = 'Wash money!',
        }
    }
})
