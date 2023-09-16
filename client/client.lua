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
                text = "MOT ID #", -- text you want to be displayed as a place holder
                name = "motID", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true, -- Optional [accepted values: true | false] but will submit the form if no value is inputted
            },
            {
                text = "MOT Pass/Fail",
                name = "motSuccess",
                type = "radio",
                options = {
                    { value = "pass", text = "Pass" },
                    { value = "fail", text = "Fail" },
                },
            },
            {
                text = "Expiry Date",
                name = "expiryDate",
                type = "text",
                isRequired = true,
            },
        }
    }) 

    if motResult ~= nil then
        if not motResult.motID == nil then
            QBCore.Functions.Notify('You must enter an MOT identification number', 'fail')
            return
        elseif not motResult.expiryDate == nil then
            QBCore.Functions.Notify('You must enter an expiry date', 'fail')
        end
        TriggerServerEvent("as-commands:motHandlerQB", motResult, getPlate)
    end

    else if Config.MOTMenu == "ox" then
        local mot = lib.inputDialog('MOT Testing', {
            {type = 'input', label = 'MOT ID #', required = true, icon = 'id-card'},
            {type = 'select', label = 'MOT Pass/Fail', required = true, icon = 'check', options = {
            { value = "pass", label = "Pass" },
            { value = "fail", label = "Fail" }}
            },
            {type = 'input', label = 'Expiry Date', required = true, icon = 'hourglass-start'},
        })
        if not mot then return end

        if mot[1] ~= nil then
            if not mot[1] == nil then
                QBCore.Functions.Notify('You must enter an MOT identification number', 'primary')
                return
            elseif not mot[3] == nil then
                QBCore.Functions.Notify('You must enter an expiry date', 'fail')
            end
            TriggerServerEvent("as-commands:motHandlerOX", mot[1], mot[2], mot[3], getPlate)
        end
    end
end
end)

if Config.TriggerType == "cmd" then
    TriggerEvent('chat:addSuggestion', '/mot', 'Pass or Fail an MOT')
    RegisterCommand('mot', function()
        local Player = QBCore.Functions.GetPlayerData()
        local jobName = Player.job.name
        if jobName == Config.MOTJobs then
            TriggerEvent("as-commands:motmenu")
        else
            QBCore.Functions.Notify('You are not an official MOT technician!', 'primary')
        end
    end)
elseif Config.TriggerType == "ped" then
    exports['qb-target']:SpawnPed({
        model = 'mp_m_waremech_01', -- This is the ped model that is going to be spawning at the given coords
        coords = Config.PedLocation, -- This is the coords that the ped is going to spawn at, always has to be a vector4 and the w value is the heading
        minusOne = true, -- Set this to true if your ped is hovering above the ground but you want it on the ground (OPTIONAL)
        freeze = true, -- Set this to true if you want the ped to be frozen at the given coords (OPTIONAL)
        invincible = true, -- Set this to true if you want the ped to not take any damage from any source (OPTIONAL)
        blockevents = true, -- Set this to true if you don't want the ped to react the to the environment (OPTIONAL)
        scenario = 'WORLD_HUMAN_CLIPBOARD', -- This is the scenario that will play the whole time the ped is spawned, this cannot pair with anim and animDict (OPTIONAL)
        target = { -- This is the target options table, here you can specify all the options to display when targeting the ped (OPTIONAL)
          useModel = false, -- This is the option for which target function to use, when this is set to true it'll use AddTargetModel and add these to al models of the given ped model, if it is false it will only add the options to this specific ped
          options = { -- This is your options table, in this table all the options will be specified for the target to accept
            { -- This is the first table with options, you can make as many options inside the options table as you want
              num = 1, -- This is the position number of your option in the list of options in the qb-target context menu (OPTIONAL)
              type = "client", -- This specifies the type of event the target has to trigger on click, this can be "client", "server", "command" or "qbcommand", this is OPTIONAL and will only work if the event is also specified
              event = "as-commands:motmenu", -- This is the event it will trigger on click, this can be a client event, server event, command or qbcore registered command, NOTICE: Normal command can't have arguments passed through, QBCore registered ones can have arguments passed through
              icon = 'fas fa-address-book', -- This is the icon that will display next to this trigger option
              label = 'MOT Testing', -- This is the label of this option which you would be able to click on to trigger everything, this has to be a string
              job = Config.MOTJobs, -- This is the job, this option won't show up if the player doesn't have this job, this can also be done with multiple jobs and grades, if you want multiple jobs you always need a grade with it: job = {["police"] = 0, ["ambulance"] = 2},
            }
          },
          distance = 3.5, -- This is the distance for you to be at for the target to turn blue, this is in GTA units and has to be a float value
        },
    })
end