print("==========================================")
print("================SU-SCRIPTS================")
print("==========================================")
--Rasenmähen--
    ESX = nil

    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

    RegisterNetEvent("rasen:pay")
    AddEventHandler("rasen:pay", function(points)
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)		
        xPlayer.addMoney(points * 12)
    end)
--Rasenmähen--
--sperrzone--
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    --LAPD
    RegisterCommand('pd', function(source, args, rawCommand)
        local xPlayers = ESX.GetPlayers()
        local radius = tonumber(args[1])
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getJob().name == "police" then
            for i=1, #xPlayers, 1 do 
            TriggerClientEvent("sperrzone:setSperrzoneLAPD", -1, source, radius)
            end
        end
    end)

    RegisterNetEvent('sperrzone:notify')
    AddEventHandler('sperrzone:notify', function(lSa)
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do 
            TriggerClientEvent('okokNotify:Alert', xPlayers[i], "LAPD Rundruf:", "Sperrzone wurde erstellt bei: " ..lSa, 6000, 'info')
        end
    end)

    RegisterCommand('pdrm', function(source, args, rawCommand)
        local xPlayers = ESX.GetPlayers()
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getJob().name == "police" then
            for i=1, #xPlayers, 1 do 
            TriggerClientEvent("sperrzone:clearSperrzoneLAPD", -1, source)
            end
        end
    end)

    RegisterNetEvent('sperrzone:notifyrm')
    AddEventHandler('sperrzone:notifyrm', function(lSa)
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do 
            TriggerClientEvent('okokNotify:Alert', xPlayers[i], "LAPD Rundruf:", "Sperrzone wurde entfernt bei: " ..lSa, 6000, 'info')
        end
    end)

    --FIB
    RegisterCommand('fib', function(source, args, rawCommand)
        local xPlayers = ESX.GetPlayers()
        local radius = tonumber(args[1])
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getJob().name == "fib" then
            for i=1, #xPlayers, 1 do 
            TriggerClientEvent("sperrzone:setSperrzoneFIB", -1, source, radius)
            end
        end
    end)
    RegisterNetEvent('sperrzone:fbinotify')
    AddEventHandler('sperrzone:fbinotify', function(lSa)
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do 
            TriggerClientEvent('okokNotify:Alert', xPlayers[i], "FBI Rundruf:", "Sperrzone wurde erstellt bei: " ..lSa, 6000, 'info')
        end
    end)

    RegisterCommand('fibrm', function(source, args, rawCommand)
        local xPlayers = ESX.GetPlayers()
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getJob().name == "fib" then
            for i=1, #xPlayers, 1 do 
            TriggerClientEvent("sperrzone:clearSperrzoneFIB", -1, source)
            end
        end
    end)
    RegisterNetEvent('sperrzone:fbinotifyrm')
    AddEventHandler('sperrzone:fbinotifyrm', function(lSa)
        local xPlayers = ESX.GetPlayers()
        for i=1, #xPlayers, 1 do 
            TriggerClientEvent('okokNotify:Alert', xPlayers[i], "FBI Rundruf:", "Sperrzone wurde entfernt bei: " ..lSa, 6000, 'info')
        end
    end)
--sperrzone--
--vendingm--
    Citizen.CreateThread(function()
        if Config.ESXlagacy == true then
        ESX = exports["es_extended"]:getSharedObject()
        elseif Config.ESXlagacy == false then
        ESX = nil
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
        end
    end)


    ESX.RegisterServerCallback("vending_machines:validatepurchase", function(source, callback)
        local player = ESX.GetPlayerFromId(source)

        if player then
            if player.getMoney() >= Config.preis then
                player.removeMoney(Config.preis)

                callback(true)
            else
                callback(false)
            end
        else
            callback(false)
        end
    end)
--vendingm--
