local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("as-commands:motHandler", function(motInfo,plate)
    local Player = QBCore.Functions.GetPlayer(source) -- local tables are only temporary so dont need clearing
    local info = {
        firstname = Player.PlayerData.charinfo.firstname,
        lastname = Player.PlayerData.charinfo.lastname,
        motid = motInfo.motID,
        vehicleplate = plate
    }

    if motInfo.motSuccess == "pass" then
        Player.Functions.AddItem("motpass", 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["motpass"], 'add')
    else
        Player.Functions.AddItem("motfail", 1, nil, info)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["motfail"], 'add')
    end
end)