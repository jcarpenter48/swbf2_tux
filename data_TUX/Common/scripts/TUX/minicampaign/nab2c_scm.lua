-- nab2c_scm.lua
-- PSP Mission Script; 'Rebel Raider' Namboo level
ScriptCB_DoFile("ObjectiveCTF")
ScriptCB_DoFile("setup_teams")
ALL = 1
IMP = 2
ATT = ALL
DEF = IMP
local numPlayers = ScriptCB_GetNumCameras() --better than checking number of plugged in controllers

function ScriptPostLoad()
    missiontimer = CreateTimer("missiontimer")
    SetTimerValue(missiontimer, 330)
    timelimit = 330
    fiveminremains = CreateTimer("fiveminremains")
    SetTimerValue(fiveminremains, 30)
    fourminremains = CreateTimer("fourminremains")
    SetTimerValue(fourminremains, 90)
    threeminremains = CreateTimer("threeminremains")
    SetTimerValue(threeminremains, 150)
    twominremains = CreateTimer("twominremains")
    SetTimerValue(twominremains, 210)
    oneminremains = CreateTimer("oneminremains")
    SetTimerValue(oneminremains, 270)
    thirtysecremains = CreateTimer("thirtysecremains")
    SetTimerValue(thirtysecremains, 300)
    tensecremains = CreateTimer("tensecremains")
    SetTimerValue(tensecremains, 320)

    StartTimer(missiontimer)
    StartTimer(fiveminremains)
    StartTimer(fourminremains)
    StartTimer(threeminremains)
    StartTimer(twominremains)
    StartTimer(oneminremains)
    StartTimer(thirtysecremains)
    StartTimer(tensecremains)
    ShowTimer(missiontimer)

    SetProperty("flag1", "GeometryName", "tan4_prop_console")
    SetProperty("flag1", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag1", "AllowAIPickup", 0)
    SetProperty("flag2", "GeometryName", "tan4_prop_console")
    SetProperty("flag2", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag2", "AllowAIPickup", 0)
    SetProperty("flag3", "GeometryName", "tan4_prop_console")
    SetProperty("flag3", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag3", "AllowAIPickup", 0)
    SetProperty("flag4", "GeometryName", "tan4_prop_console")
    SetProperty("flag4", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag4", "AllowAIPickup", 0)
    SetProperty("flag5", "GeometryName", "tan4_prop_console")
    SetProperty("flag5", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag5", "AllowAIPickup", 0)
    SetProperty("flag6", "GeometryName", "tan4_prop_console")
    SetProperty("flag6", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag6", "AllowAIPickup", 0)
    SetProperty("flag7", "GeometryName", "tan4_prop_console")
    SetProperty("flag7", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag7", "AllowAIPickup", 0)
    SetClassProperty("myg1_prop_shield_generator", "DroppedColorize", 1)

	SetProperty("com_bldg_ctfbase3", "IsVisible", 0)	
	
    ctf =
        ObjectiveCTF:New(
        {
            teamATT = ATT,
            teamDEF = DEF,
            captureLimit = 4,
            popupText = "level.nab2c_s.objectives.detail",
            text = "level.nab2c_s.objectives.1",
            hideCPs = false,
            multiplayerRules = true
        }
    )
    ctf:AddFlag(
        {
            name = "flag1",
            homeRegion = "",
            captureRegion = "togozone1",
            capRegionMarker = "hud_objective_icon_circle",
            capRegionMarkerScale = 3,
            icon = "",
            mapIcon = "hud_target_flag_onscreen2",
            mapIconScale = 3
        }
    )
    ctf:AddFlag(
        {
            name = "flag2",
            homeRegion = "",
            captureRegion = "togozone2",
            capRegionMarker = "hud_objective_icon_circle",
            capRegionMarkerScale = 3,
            icon = "",
            mapIcon = "hud_target_flag_onscreen2",
            mapIconScale = 3
        }
    )
    ctf:AddFlag(
        {
            name = "flag3",
            homeRegion = "",
            captureRegion = "togozone3",
            capRegionMarker = "hud_objective_icon_circle",
            capRegionMarkerScale = 3,
            icon = "",
            mapIcon = "hud_target_flag_onscreen2",
            mapIconScale = 3
        }
    )
    ctf:AddFlag(
        {
            name = "flag4",
            homeRegion = "",
            captureRegion = "togozone4",
            capRegionMarker = "hud_objective_icon_circle",
            capRegionMarkerScale = 3,
            icon = "",
            mapIcon = "hud_target_flag_onscreen2",
            mapIconScale = 3
        }
    )
    ctf:AddFlag(
        {
            name = "flag5",
            homeRegion = "",
            captureRegion = "togozone5",
            capRegionMarker = "hud_objective_icon_circle",
            capRegionMarkerScale = 3,
            icon = "",
            mapIcon = "hud_target_flag_onscreen2",
            mapIconScale = 3
        }
    )
    ctf:AddFlag(
        {
            name = "flag6",
            homeRegion = "",
            captureRegion = "togozone6",
            capRegionMarker = "hud_objective_icon_circle",
            capRegionMarkerScale = 3,
            icon = "",
            mapIcon = "hud_target_flag_onscreen2",
            mapIconScale = 3
        }
    )
    ctf:AddFlag(
        {
            name = "flag7",
            homeRegion = "",
            captureRegion = "togozone7",
            capRegionMarker = "hud_objective_icon_circle",
            capRegionMarkerScale = 3,
            icon = "",
            mapIcon = "hud_target_flag_onscreen2",
            mapIconScale = 3
        }
    )
    object_count = 4
    ctf:Start()
    ctf.OnCapture = function(arg1, arg2)
        object_count = object_count - 1
        if 0 < object_count then
            if object_count == 3 then
                ShowMessageText("level.nab2c_s.objectives.5")
            end
            if object_count == 2 then
                ShowMessageText("level.nab2c_s.objectives.6")
            end
            if object_count == 1 then
                ShowMessageText("level.nab2c_s.objectives.7")
            end
        end
        if object_count == 0 then
            MissionVictory(ATT)
        end
    end

    OnTimerElapse(
        function()
            MissionVictory(DEF)
        end,
        "missiontimer"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.5min")
        end,
        "fiveminremains"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.4min")
        end,
        "fourminremains"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.3min")
        end,
        "threeminremains"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.2min")
        end,
        "twominremains"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.1min")
        end,
        "oneminremains"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.30sec")
        end,
        "thirtysecremains"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.10sec")
        end,
        "tensecremains"
    )

    local UpdateMarkerPulses = function(flag)
        if not flag.mapIcon then
            return end
            
        local flagTeam = GetObjectTeam(flag.name)
        local carrierTeam = 0
        if flagTeam ~= 0 then
            carrierTeam = GetOpposingTeam(flagTeam)
        end
    
		--TODO: update ObjectiveRaider to take advantage of self.capRegionDummyObjectATT and self.capRegionDummyObjectDEF
		print("updating markers for flag:", flag.name)
        if flag.carrier then
			print("flag carrier")
            --no marker on the flag, yes marker on the capture region
 			MapRemoveEntityMarker(flag.name)
            MapAddRegionMarker(GetRegion(flag.captureRegion), flag.capRegionMarker, 4.0,
                                carrierTeam, "YELLOW", false, false, true)
        else
			print("no carrier")
            --no marker on the flag, no marker on the capture region
			MapRemoveEntityMarker(flag.name)
            --MapAddEntityMarker(flag.name, flag.mapIcon, 4.0, carrierTeam, "YELLOW", true, false, true, true)     
            MapRemoveRegionMarker(GetRegion(flag.captureRegion))
        end 
    end
	
    AICanCaptureCP("CP1", 2, false)
    AICanCaptureCP("CP2", 2, false)
    AICanCaptureCP("CP4", 2, false)
    SetAIDifficulty(0, 2, "hard")
	--SetAIDifficulty(-5, 2, "medium")
    AddAIGoal(ALL, "Deathmatch", 100)
    AddAIGoal(IMP, "Deathmatch", 100)
end

function ScriptInit()
    StealArtistHeap(135 * 1024)
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(1979297)
        SetPSPClipper(1)
    else
        SetPS2ModelMemory(4880000)
    end
    ReadDataFile("ingame.lvl")
    SetTeamAggressiveness(ALL, 0.75)
    --SetTeamAggressiveness(IMP, 0.5)
	SetTeamAggressiveness(IMP, 1.0)
    SetMaxFlyHeight(40)
    SetMaxPlayerFlyHeight(40)
    ReadDataFile("sound\\nab.lvl;nab2gcw")
    ReadDataFile("SIDE\\all.lvl", "all_inf_engineer_jungle", "all_hero_hansolo_tat")
    ReadDataFile(
        "SIDE\\imp.lvl",
        "imp_inf_rifleman",
        "imp_inf_rocketeer",
        "imp_inf_engineer",
        "imp_inf_sniper",
        "imp_inf_officer",
        "imp_inf_dark_trooper"
    )
	ReadDataFile("SIDE\\contraband.lvl", "contraband_all")
    ClearWalkers()
    AddWalkerType(0, 8)
    AddWalkerType(1, 0)
    AddWalkerType(2, 0)
    AddWalkerType(3, 4)
    SetMemoryPoolSize("Weapon", 280)
    SetMemoryPoolSize("CommandWalker", 0)
    SetMemoryPoolSize("MountedTurret", 55)
    SetMemoryPoolSize("EntityFlyer", 1)
    SetMemoryPoolSize("EntityHover", 8)
    SetMemoryPoolSize("EntityCarrier", 0)
    SetMemoryPoolSize("PowerupItem", 40)
    SetMemoryPoolSize("EntityMine", 40)
    SetMemoryPoolSize("Aimer", 220)
    SetMemoryPoolSize("FlagItem", 7)
    if ScriptCB_GetPlatform() == "PSP" then
        SetupTeams(
            {
                all = {
                    team = ALL,
                    units = 6,
                    reinforcements = -1,
                    engineer = {"all_inf_engineer_jungle"}
                },
                imp = {
                    team = IMP,
                    units = 8,
                    reinforcements = -1,
                    soldier = {"imp_inf_rifleman"},
                    assault = {"imp_inf_rocketeer"},
                    engineer = {"imp_inf_engineer"},
                    sniper = {"imp_inf_sniper"},
                    officer = {"imp_inf_officer"},
                    special = {"imp_inf_dark_trooper", 1, 4}
                }
            }
        )
    else
        SetupTeams(
            {
                all = {
                    team = ALL,
                    units = 6,
                    reinforcements = -1,
                    engineer = {"all_inf_engineer_jungle"}
                },
                imp = {
                    team = IMP,
                    units = 8,
                    reinforcements = -1,
                    soldier = {"imp_inf_rifleman"},
                    assault = {"imp_inf_rocketeer"},
                    engineer = {"imp_inf_engineer"},
                    sniper = {"imp_inf_sniper"},
                    officer = {"imp_inf_officer"},
                    special = {"imp_inf_dark_trooper", 1, 4}
                }
            }
        )
    end
	if (not ScriptCB_InMultiplayer() and (numPlayers < 2)) then
	  ForceHumansOntoTeam1() --if in singleplayer, force humans to team 1
	end
	
    SetUnitCount(ATT, 6)
    SetReinforcementCount(ATT, -1)
    SetUnitCount(DEF, 8)
    SetReinforcementCount(DEF, -1)
    SetHeroClass(ALL, "all_hero_hansolo_tat")
    AddAIGoal(ATT, "Deathmatch", 100)
    AddAIGoal(DEF, "Deathmatch", 100)
    SetSpawnDelay(10, 0.25)
	
    --ReadDataFile("NAB\\nab2.lvl", "naboo2_Smuggler")
	--ReadDataFile("NAB\\nab2dlc.lvl", "naboo2_eli")
	ReadDataFile("raider\\nab2.lvl", "naboo2_Smuggler")
	
    SetDenseEnvironment("true")
    AddDeathRegion("Water")
    AddDeathRegion("Waterfall")
    SetNumBirdTypes(1)
    SetBirdType(0, 1, "bird")
    OpenAudioStream("sound\\global.lvl", "gcw_music")
    SetAmbientMusic(ALL, 1, "all_nab_amb_start", 0, 1)
    SetAmbientMusic(ALL, 0.80000001192093, "all_nab_amb_middle", 1, 1)
    SetAmbientMusic(ALL, 0.20000000298023, "all_nab_amb_end", 2, 1)
    SetAmbientMusic(IMP, 1, "imp_nab_amb_start", 0, 1)
    SetAmbientMusic(IMP, 0.80000001192093, "imp_nab_amb_middle", 1, 1)
    SetAmbientMusic(IMP, 0.20000000298023, "imp_nab_amb_end", 2, 1)
    SetVictoryMusic(IMP, "imp_nab_amb_victory")
    SetDefeatMusic(IMP, "imp_nab_amb_defeat")
    SetVictoryMusic(ALL, "all_nab_amb_victory")
    SetDefeatMusic(ALL, "all_nab_amb_defeat")
    SetSoundEffect("CaptureFlag", "sfx_start_beep")
    SetAttackingTeam(ATT)
    --  Camera Stats
    --Nab2 Theed
    --Palace
    AddCameraShot(0.038177, -0.005598, -0.988683, -0.144973, -0.985535, 18.617458, -123.316505);
    AddCameraShot(0.993106, -0.109389, 0.041873, 0.004612, 6.576932, 24.040697, -25.576218);
    AddCameraShot(0.851509, -0.170480, 0.486202, 0.097342, 158.767715, 22.913860, -0.438658);
    AddCameraShot(0.957371, -0.129655, -0.255793, -0.034641, 136.933548, 20.207420, 99.608246);
    AddCameraShot(0.930364, -0.206197, 0.295979, 0.065598, 102.191856, 22.665434, 92.389435);
    AddCameraShot(0.997665, -0.068271, 0.002086, 0.000143, 88.042351, 13.869274, 93.643898);
    AddCameraShot(0.968900, -0.100622, 0.224862, 0.023352, 4.245263, 13.869274, 97.208542);
    AddCameraShot(0.007091, -0.000363, -0.998669, -0.051089, -1.309990, 16.247049, 15.925866);
    AddCameraShot(-0.274816, 0.042768, -0.949121, -0.147705, -55.505108, 25.990822, 86.987534);
    AddCameraShot(0.859651, -0.229225, 0.441156, 0.117634, -62.493008, 31.040747, 117.995369);
    AddCameraShot(0.703838, -0.055939, 0.705928, 0.056106, -120.401054, 23.573559, -15.484946);
    AddCameraShot(0.835474, -0.181318, -0.506954, -0.110021, -166.314774, 27.687098, -6.715797);
    AddCameraShot(0.327573, -0.024828, -0.941798, -0.071382, -109.700180, 15.415476, -84.413605);
    AddCameraShot(-0.400505, 0.030208, -0.913203, -0.068878, 82.372711, 15.415476, -42.439548);
end
