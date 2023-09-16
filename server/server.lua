local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("as-commands:motHandlerQB", function(motInfo, plate)
    local Player = QBCore.Functions.GetPlayer(source)
    local info = {
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        motid = motInfo.motID,
        vehicleplate = plate,
        expiry = motInfo.expiryDate
    }

    if motInfo.motSuccess == "pass" then
        Player.Functions.AddItem("motpass", 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["motpass"], 'add')
    else
        Player.Functions.AddItem("motfail", 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["motfail"], 'add')
    end
end)

RegisterNetEvent("as-commands:motHandlerOX", function(motInfo, status, expiryDate, plate)
    local Player = QBCore.Functions.GetPlayer(source)
    local info = {
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        motid = motInfo,
        vehicleplate = plate,
        expiry = expiryDate
    }

    if status == "pass" then
        Player.Functions.AddItem("motpass", 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["motpass"], 'add')
    else
        Player.Functions.AddItem("motfail", 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["motfail"], 'add')
    end
end)
