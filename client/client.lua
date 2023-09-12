local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("as-commands:motmenu", function()
    local motResult = nil
    local getPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())) -- Get the plate here otherwise we call it twice
    if Config.MOTMenu == "qb" then
    motResult = exports['qb-input']:ShowInput({
        header = "MOT Testing",
        submitText = "Submit",
        inputs = {
            {
                text = "MOT ID +#", -- text you want to be displayed as a place holder
                name = "motID", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            },
            {
                text = "MOT Pass/Fail", -- text you want to be displayed as a input header
                name = "motSuccess", -- name of the input should be unique otherwise it might override
                type = "radio", -- type of the input - Radio is useful for "or" options e.g; billtype = Cash OR Bill OR bank
                options = { -- The options (in this case for a radio) you want displayed, more than 6 is not recommended
                    { value = "pass", text = "Pass" }, -- Options MUST include a value and a text option
                    { value = "fail", text = "Fail" }, -- Options MUST include a value and a text option
                },
            },
        }
    }) 

    if motResult ~= nil then
        if not motResult.motID == nil then
            QBCore.Functions.Notify('You must enter an MOT identification number', 'primary')
            return
        end
        TriggerServerEvent("as-commands:motHandlerQB",motResult,getPlate)
    end

    else if Config.MOTMenu == "ox" then
        local mot = lib.inputDialog('MOT Testing', {
            {type = 'input', label = 'MOT ID +#', required = true, icon = 'id-card'},
            {type = 'select', label = 'MOT Pass/Fail', required = true, icon = 'check', options = {
            { value = "pass", label = "Pass" },
            { value = "fail", label = "Fail" }}
            }
        })
        if not mot then return end

        if mot[1] ~= nil then
            if not mot[1] == nil then
                QBCore.Functions.Notify('You must enter an MOT identification number', 'primary')
                return
            end
            TriggerServerEvent("as-commands:motHandlerOX",mot[1],mot[2],getPlate)
        end
    end
end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', (Config.MOTCMDSuggestion), 'Pass or Fail an MOT')
    RegisterCommand(Config.MOTCMD, function()
        local Player = QBCore.Functions.GetPlayerData()
        local jobName = Player.job.name
        if jobName == Config.MOTJobs then
            TriggerEvent("as-commands:motmenu")
        else
            QBCore.Functions.Notify('You are not an official MOT technician!', 'primary')
        end
    end)
end)
