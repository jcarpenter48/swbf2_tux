-- myg1c_scm.lua
-- PSP Mission Script; 'Rebel Raider' Mygeeto level

ScriptCB_DoFile("ObjectiveCTF")
ScriptCB_DoFile("setup_teams")
ALL = 1
IMP = 2
ATT = ALL
DEF = IMP
local numPlayers = ScriptCB_GetNumCameras() --better than checking number of plugged in controllers

function ScriptPostLoad()
    DisableBarriers("dropship")
    DisableBarriers("shield_03")
    DisableBarriers("shield_02")
    DisableBarriers("shield_01")
    DisableBarriers("ctf")
    DisableBarriers("ctf1")
    DisableBarriers("ctf2")
    DisableBarriers("ctf3")
    missiontimer = CreateTimer("missiontimer")
    SetTimerValue(missiontimer, 360)
    timelimit = 360
    fiveminremains = CreateTimer("fiveminremains")
    SetTimerValue(fiveminremains, 60)
    fourminremains = CreateTimer("fourminremains")
    SetTimerValue(fourminremains, 120)
    threeminremains = CreateTimer("threeminremains")
    SetTimerValue(threeminremains, 180)
    twominremains = CreateTimer("twominremains")
    SetTimerValue(twominremains, 240)
    oneminremains = CreateTimer("oneminremains")
    SetTimerValue(oneminremains, 300)
    thirtysecremains = CreateTimer("thirtysecremains")
    SetTimerValue(thirtysecremains, 330)
    tensecremains = CreateTimer("tensecremains")
    SetTimerValue(tensecremains, 350)
    StartTimer(missiontimer)
    StartTimer(fiveminremains)
    StartTimer(fourminremains)
    StartTimer(threeminremains)
    StartTimer(twominremains)
    StartTimer(oneminremains)
    StartTimer(thirtysecremains)
    StartTimer(tensecremains)
    ShowTimer(missiontimer)
    --SetProperty("flag1", "GeometryName", "com_icon_alliance_contraband")
	SetProperty("flag1", "GeometryName", "myg1_prop_shield_generator")
    SetProperty("flag1", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag1", "AllowAIPickup", 0)
    --SetProperty("flag2", "GeometryName", "com_icon_alliance_contraband")
	SetProperty("flag2", "GeometryName", "myg1_prop_shield_generator")
    SetProperty("flag2", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag2", "AllowAIPickup", 0)
    --SetProperty("flag3", "GeometryName", "com_icon_alliance_contraband")
	SetProperty("flag3", "GeometryName", "myg1_prop_shield_generator")
    SetProperty("flag3", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag3", "AllowAIPickup", 0)
    --SetProperty("flag4", "GeometryName", "com_icon_alliance_contraband")
	SetProperty("flag4", "GeometryName", "myg1_prop_shield_generator")
    SetProperty("flag4", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag4", "AllowAIPickup", 0)
    --SetClassProperty("com_icon_alliance_contraband", "DroppedColorize", 1)
	SetClassProperty("myg1_prop_shield_generator", "DroppedColorize", 1)
	
	SetProperty("com_bldg_ctfbase7", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase12", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase15", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase8", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase13", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase18", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase6", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase11", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase14", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase17", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase5", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase10", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase16", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase9", "IsVisible", 0)
	
    ctf =
        ObjectiveCTF:New(
        {
            teamATT = ATT,
            teamDEF = DEF,
            captureLimit = 3,
            popupText = "level.myg1c_s.objectives.detail",
            text = "level.myg1c_s.objectives.1",
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
            mapIcon = " ",
            mapIconScale = 0
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
            mapIcon = " ",
            mapIconScale = 0
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
            mapIcon = " ",
            mapIconScale = 0
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
            mapIcon = " ",
            mapIconScale = 0
			--mapIcon = "hud_target_flag_onscreen2",
            --mapIconScale = 3
        }
    )
	
	SetProperty("flag1", "IconTexture", " ")
	SetProperty("flag1", "MapTexture", " ")
	SetProperty("flag2", "IconTexture", " ")
	SetProperty("flag2", "MapTexture", " ")
	SetProperty("flag3", "IconTexture", " ")
	SetProperty("flag3", "MapTexture", " ")
	SetProperty("flag4", "IconTexture", " ")
	SetProperty("flag4", "MapTexture", " ")

	
    object_count = 3
    ctf:Start()
    ctf.OnCapture = function(arg1, arg2)
        object_count = object_count - 1
        if 0 < object_count then
            if object_count == 2 then
                ShowMessageText("level.myg1c_s.objectives.4")
            end
            if object_count == 1 then
                ShowMessageText("level.myg1c_s.objectives.5")
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
            MapRemoveRegionMarker(GetRegion(flag.captureRegion))
        end 
    end
	
    AICanCaptureCP("CP1_CON", 2, false)
    AICanCaptureCP("CP2_CON", 2, false)
    AICanCaptureCP("CP4_CON", 2, false)
    SetAIDifficulty(0, 2, "hard")
	--SetAIDifficulty(-7, 2, "medium")
    AddAIGoal(ALL, "Deathmatch", 100)
    AddAIGoal(IMP, "Deathmatch", 100)
end

function ScriptInit()
    StealArtistHeap(135 * 1024)
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(3996881)
        SetPSPClipper(0)
    else
        SetPS2ModelMemory(4880000)
    end
    ReadDataFile("ingame.lvl")
    ReadDataFile("sound\\myg.lvl;myg1gcw")
    ReadDataFile("SIDE\\all.lvl", "all_inf_engineer_jungle", "all_hero_hansolo_tat", "all_hover_combatspeeder")
    ReadDataFile(
        "SIDE\\imp.lvl",
        "imp_inf_rifleman",
        "imp_inf_rocketeer",
        "imp_inf_officer",
        "imp_inf_sniper",
        "imp_inf_engineer",
        "imp_inf_dark_trooper",
        "imp_hero_bobafett",
        "imp_hover_fightertank",
        "imp_hover_speederbike",
        "imp_walk_atst"
    )
	
	
	--ScriptCB_RemoveTexture("hud_target_flag_onscreen2")
	--ScriptCB_RemoveTexture("hud_target_flag_onscreen")
	--ScriptCB_RemoveTexture("hud_objective_icon")
	--ScriptCB_RemoveTexture("hud_objective_icon_hidden")
	--ScriptCB_RemoveTexture("hud_objective_icon_offscreen")
	
	ReadDataFile("SIDE\\contraband.lvl", "contraband_all")
	
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
                    units = 15,
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
                    units = 4,
                    reinforcements = -1,
                    engineer = {"all_inf_engineer_jungle"}
                },
                imp = {
                    team = IMP,
                    units = 25,
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
	SetTeamAggressiveness(IMP, 1.0)
	
	if (not ScriptCB_InMultiplayer() and (numPlayers < 2)) then
	  ForceHumansOntoTeam1() --if in singleplayer, force humans to team 1
	end
	
    SetHeroClass(ALL, "all_hero_hansolo_tat")
    ClearWalkers()
    AddWalkerType(0, 4)
    AddWalkerType(2, 0)
    SetMemoryPoolSize("EntityHover", 8)
    SetMemoryPoolSize("CommandWalker", 5)
    SetMemoryPoolSize("MountedTurret", 16)
    SetMemoryPoolSize("PowerupItem", 40)
    SetMemoryPoolSize("EntityMine", 30)
    SetMemoryPoolSize("EntityDroid", 12)
    SetMemoryPoolSize("Aimer", 100)
    SetMemoryPoolSize("Obstacle", 500)
    SetMemoryPoolSize("Decal", 0)
    SetMemoryPoolSize("PassengerSlot", 0)
    SetMemoryPoolSize("ParticleEmitter", 350)
    SetMemoryPoolSize("ParticleEmitterInfoData", 800)
    SetMemoryPoolSize("ParticleEmitterObject", 256)
    SetMemoryPoolSize("PathNode", 512)
    SetMemoryPoolSize("TreeGridStack", 300)
    SetMemoryPoolSize("Ordnance", 70)
    SetMemoryPoolSize("FlagItem", 5)
    SetMemoryPoolSize("EntityCloth", 24)
    SetSpawnDelay(10, 0.25)
	
    --ReadDataFile("myg\\myg1.lvl", "myg1_Smuggler")
	ReadDataFile("raider\\myg1.lvl", "myg1_Smuggler")
	--ReadDataFile("myg\\myg1dlc.lvl", "myg1_eli")
	
    SetDenseEnvironment("false")
    AddDeathRegion("deathregion")
    OpenAudioStream("sound\\global.lvl", "gcw_music")
    SetAmbientMusic(ALL, 1, "all_myg_amb_start", 0, 1)
    SetAmbientMusic(ALL, 0.80000001192093, "all_myg_amb_middle", 1, 1)
    SetAmbientMusic(ALL, 0.20000000298023, "all_myg_amb_end", 2, 1)
    SetAmbientMusic(IMP, 1, "imp_myg_amb_start", 0, 1)
    SetAmbientMusic(IMP, 0.80000001192093, "imp_myg_amb_middle", 1, 1)
    SetAmbientMusic(IMP, 0.20000000298023, "imp_myg_amb_end", 2, 1)
    SetVictoryMusic(ALL, "all_myg_amb_victory")
    SetDefeatMusic(ALL, "all_myg_amb_defeat")
    SetVictoryMusic(IMP, "imp_myg_amb_victory")
    SetDefeatMusic(IMP, "imp_myg_amb_defeat")
    SetSoundEffect("CaptureFlag", "sfx_start_beep")
    SetAttackingTeam(ATT)
        --Camera Shizzle--
        
        -- Collector Shot
    AddCameraShot(0.008315, 0.000001, -0.999965, 0.000074, -64.894348, 5.541570, 201.711090);
	AddCameraShot(0.633584, -0.048454, -0.769907, -0.058879, -171.257629, 7.728924, 28.249359);
	AddCameraShot(-0.001735, -0.000089, -0.998692, 0.051092, -146.093109, 4.418306, -167.739212);
	AddCameraShot(0.984182, -0.048488, 0.170190, 0.008385, 1.725611, 8.877428, 88.413887);
	AddCameraShot(0.141407, -0.012274, -0.986168, -0.085598, -77.743042, 8.067328, 42.336128);
	AddCameraShot(0.797017, 0.029661, 0.602810, -0.022434, -45.726467, 7.754435, -47.544712);
	AddCameraShot(0.998764, 0.044818, -0.021459, 0.000963, -71.276566, 4.417432, 221.054550);
end
