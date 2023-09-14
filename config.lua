Config = {}

Config.MOTJobs = "mechanic" -- Job that is allowed to do the command listed under Config.MOTCMD

Config.MOTMenu = "qb" -- If ox it will use the ox_lib menu, if qb then it will use the qb-menu

Config.TriggerType = "cmd" -- Type of activator. cmd for a Chat Command, ped for a Spawnable Ped that uses qb-target
Config.PedLocation = vector4(897.73, -2129.84, 30.46, 358.82) -- MUST be a Vector4 location! Ignored if Config.TriggerType = "cmd"