-- hot1g_scm.lua
-- PSP Mission Script; 'Rebel Raider' Hoth level
ScriptCB_DoFile("ObjectiveCTF")
ScriptCB_DoFile("setup_teams")
ALL = 1
IMP = 2
ATT = ALL
DEF = IMP

local numPlayers = ScriptCB_GetNumCameras() --better than checking number of plugged in controllers

function ScriptPostLoad()
    SetObjectTeam("CP3", 1)
    SetObjectTeam("CP6", 1)
    SetObjectTeam("CP4", 2)
    SetObjectTeam("CP5", 2)
    KillObject("CP7")
    AICanCaptureCP("CP3", 2, false)
    AICanCaptureCP("CP4", 2, false)
    AICanCaptureCP("CP5", 2, false)
    AICanCaptureCP("CP6", 2, false)
    SetAIDifficulty(-1, 3, "medium")
    KillObject("CP7OBJ")
    KillObject("shieldgen")
    KillObject("CP7OBJ")
    KillObject("hangarcp")
    KillObject("enemyspawn")
    KillObject("enemyspawn2")
    KillObject("echoback2")
    KillObject("echoback1")
    KillObject("echo_shield1")
    KillObject("echo_shield2")
    KillObject("shield")
    DisableBarriers("conquestbar")
    KillObject("shield")

    missiontimer = CreateTimer("missiontimer")
    SetTimerValue(missiontimer, 900)
    timelimit = 900
    fiveminremains = CreateTimer("fiveminremains")
    SetTimerValue(fiveminremains, 600)
    fourminremains = CreateTimer("fourminremains")
    SetTimerValue(fourminremains, 660)
    threeminremains = CreateTimer("threeminremains")
    SetTimerValue(threeminremains, 720)
    twominremains = CreateTimer("twominremains")
    SetTimerValue(twominremains, 780)
    oneminremains = CreateTimer("oneminremains")
    SetTimerValue(oneminremains, 840)
    thirtysecremains = CreateTimer("thirtysecremains")
    SetTimerValue(thirtysecremains, 870)
    tensecremains = CreateTimer("tensecremains")

    SetTimerValue(tensecremains, 890)
    StartTimer(missiontimer)
    StartTimer(fiveminremains)
    StartTimer(fourminremains)
    StartTimer(threeminremains)
    StartTimer(twominremains)
    StartTimer(oneminremains)
    StartTimer(thirtysecremains)
    StartTimer(tensecremains)
    ShowTimer(missiontimer)

    SetProperty("flag1", "GeometryName", "hoth_prop_barrel_1")
    SetProperty("flag1", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag1", "AllowAIPickup", 0)
    SetProperty("flag2", "GeometryName", "hoth_prop_barrel_1")
    SetProperty("flag2", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag2", "AllowAIPickup", 0)
    SetProperty("flag3", "GeometryName", "hoth_prop_barrel_1")
    SetProperty("flag3", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag3", "AllowAIPickup", 0)
    SetProperty("flag4", "GeometryName", "hoth_prop_barrel_1")
    SetProperty("flag4", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag4", "AllowAIPickup", 0)
    SetProperty("flag5", "GeometryName", "hoth_prop_barrel_1")
    SetProperty("flag5", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag5", "AllowAIPickup", 0)
    SetProperty("flag6", "GeometryName", "hoth_prop_barrel_1")
    SetProperty("flag6", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag6", "AllowAIPickup", 0)
    SetProperty("flag7", "GeometryName", "hoth_prop_barrel_1")
    SetProperty("flag7", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag7", "AllowAIPickup", 0)
    SetProperty("flag8", "GeometryName", "hoth_prop_barrel_1")
    SetProperty("flag8", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag8", "AllowAIPickup", 0)
    SetProperty("flag9", "GeometryName", "hoth_prop_barrel_1")
    SetProperty("flag9", "CarriedGeometryName", "com_icon_alliance_contraband_carried")
    SetProperty("flag9", "AllowAIPickup", 0)
	
	SetProperty("com_bldg_ctfbase9", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase7", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase8", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase11", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase10", "IsVisible", 0)

    ctf =
        ObjectiveCTF:New(
        {
            teamATT = ATT,
            teamDEF = DEF,
            captureLimit = 5,
            popupText = "level.hot1g_s.objectives.detail",
            text = "level.hot1g_s.objectives.1",
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
            mapIcon = " ",
            mapIconScale = 0
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
            mapIcon = " ",
            mapIconScale = 0
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
            mapIcon = " ",
            mapIconScale = 0
        }
    )
    ctf:AddFlag(
        {
            name = "flag8",
            homeRegion = "",
            captureRegion = "togozone8",
            capRegionMarker = "hud_objective_icon_circle",
            capRegionMarkerScale = 3,
            icon = "",
            mapIcon = " ",
            mapIconScale = 0
        }
    )
    ctf:AddFlag(
        {
            name = "flag9",
            homeRegion = "",
            captureRegion = "togozone9",
            capRegionMarker = "hud_objective_icon_circle",
            capRegionMarkerScale = 3,
            icon = "",
            mapIcon = " ",
            mapIconScale = 0
			--mapIcon = "hud_target_flag_onscreen2",
            --mapIconScale = 3
        }
    )
    object_count = 5
    ctf:Start()

    ctf.OnCapture = function(arg1, arg2)
        object_count = object_count - 1
        if 0 < object_count then
            if object_count == 4 then
                ShowMessageText("level.hot1g_s.objectives.6")
            end
            if object_count == 3 then
                ShowMessageText("level.hot1g_s.objectives.7")
            end
            if object_count == 2 then
                ShowMessageText("level.hot1g_s.objectives.8")
            end
            if object_count == 1 then
                ShowMessageText("level.hot1g_s.objectives.9")
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
	
    SetAIDifficulty(0, 2, "hard")
	-- SetAIDifficulty(5, 2, "medium")
    AddAIGoal(ALL, "Deathmatch", 100)
    AddAIGoal(IMP, "Deathmatch", 100)
end

function ScriptInit()
    -- Decompiled with SWBF2CodeHelper
    if ScriptCB_GetPlatform() == "PS2" then
        StealArtistHeap(1024 * 1024)
    end

    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(2928421)
        SetPSPClipper(0)
    else
        SetPS2ModelMemory(3300000)
    end
    ReadDataFile("ingame.lvl")
    SetMaxFlyHeight(70)
    SetMaxPlayerFlyHeight(70)
	SetTeamAggressiveness(IMP, 1.0)
    ReadDataFile("sound\\hot.lvl;hot1gcw")
    ReadDataFile(
        "SIDE\\all.lvl",
        "all_inf_wookiee_snow",
        "all_inf_rifleman_snow",
        "all_inf_rocketeer_snow",
        "all_inf_engineer_snow",
        "all_inf_sniper_snow",
        "all_inf_officer_snow",
        "all_hero_hansolo_tat",
        "all_walk_tauntaun"
    )
    ReadDataFile(
        "SIDE\\imp.lvl",
        "imp_inf_rifleman_snow",
        "imp_inf_rocketeer_snow",
        "imp_inf_sniper_snow",
        "imp_inf_dark_trooper",
        "imp_inf_engineer",
        "imp_inf_officer_snow",
        "imp_walk_atst_snow"
    )
	ReadDataFile("SIDE\\contraband.lvl", "contraband_all")
	
    SetupTeams(
        {
            ALL = {
                team = ALL,
                units = 4,
                reinforcements = -1,
                soldier = {"all_inf_rifleman_snow"},
                assault = {"all_inf_rocketeer_snow"},
                engineer = {"all_inf_engineer_snow"},
                sniper = {"all_inf_sniper_snow"},
                officer = {"all_inf_officer_snow"},
                special = {"all_inf_wookiee_snow"}
            },
            IMP = {
                team = IMP,
                units = 26,
                reinforcements = -1,
                soldier = {"imp_inf_rifleman_snow"},
                assault = {"imp_inf_rocketeer_snow"},
                engineer = {"imp_inf_engineer"},
                sniper = {"imp_inf_sniper_snow"},
                officer = {"imp_inf_officer"},
                special = {"imp_inf_dark_trooper"}
            }
        }
    )
	if (not ScriptCB_InMultiplayer() and (numPlayers < 2)) then
	  ForceHumansOntoTeam1() --if in singleplayer, force humans to team 1
	end
	
    SetHeroClass(ALL, "all_hero_hansolo_tat")
    ClearWalkers()
    SetMemoryPoolSize("EntityWalker", -2)
    AddWalkerType(0, 0)
    AddWalkerType(1, 5)
    AddWalkerType(2, 2)
    SetMemoryPoolSize("CommandWalker", 2)
    SetMemoryPoolSize("EntityFlyer", 6)
    SetMemoryPoolSize("MountedTurret", 46)
    SetMemoryPoolSize("Weapon", 269)
    SetMemoryPoolSize("FlagItem", 9)
    SetMemoryPoolSize("PassengerSlot", 0)
    SetMemoryPoolSize("Ordnance", 28)
    SetMemoryPoolSize("BaseHint", 210)
    SetMemoryPoolSize("Obstacle", 344)
    SetMemoryPoolSize("Aimer", 90)
    SetMemoryPoolSize("EnergyBar", 269)
    SetMemoryPoolSize("AmmoCounter", 269)
    if ScriptCB_GetPlatform() == "PS2" or ScriptCB_GetPlatform() == "PSP" then
        SetMemoryPoolSize("Combo::DamageSample", 64)
        SetMemoryPoolSize("ConnectivityGraphFollower", 56)
        SetMemoryPoolSize("EntityDefenseGridTurret", 4)
        SetMemoryPoolSize("EntityDroid", 3)
        SetMemoryPoolSize("EntityLight", 130)
        SetMemoryPoolSize("EntityMine", 12)
        SetMemoryPoolSize("EntityPortableTurret", 4)
        SetMemoryPoolSize("EntitySoundStatic", 16)
        SetMemoryPoolSize("EntitySoundStream", 4)
        SetMemoryPoolSize("FLEffectObject::OffsetMatrix", 54)
        SetMemoryPoolSize("LightFlash", 3)
        SetMemoryPoolSize("LightningBoltEffectObject", 3)
        SetMemoryPoolSize("Navigator", 63)
        SetMemoryPoolSize("OrdnanceTowCable", 4)
        SetMemoryPoolSize("ParticleEmitter", 175)
        SetMemoryPoolSize("ParticleEmitterInfoData", 225)
        SetMemoryPoolSize("ParticleEmitterObject", 112)
        SetMemoryPoolSize("PathFollower", 63)
        SetMemoryPoolSize("PathNode", 268)
        SetMemoryPoolSize("PowerupItem", 14)
        SetMemoryPoolSize("RayRequest", 64)
        SetMemoryPoolSize("StickInfo", 20)
        SetMemoryPoolSize("TreeGridStack", 329)
        SetMemoryPoolSize("UnitController", 63)
        SetMemoryPoolSize("UnitAgent", 63)
    else
        SetMemoryPoolSize("EntityDroid", 5)
        SetMemoryPoolSize("EntityLight", 100)
        SetMemoryPoolSize("EntityMine", 16)
        SetMemoryPoolSize("LightFlash", 12)
        SetMemoryPoolSize("OrdnanceTowCable", 8)
        SetMemoryPoolSize("ParticleEmitter", 200)
        SetMemoryPoolSize("ParticleEmitterInfoData", 300)
        SetMemoryPoolSize("ParticleEmitterObject", 150)
        SetMemoryPoolSize("PathNode", 150)
        SetMemoryPoolSize("PowerupItem", 20)
        SetMemoryPoolSize("TreeGridStack", 275)
    end
    --ReadDataFile("HOT\\hot1.lvl", "hoth_Smuggler")
	--ReadDataFile("HOT\\hot1.lvl", "hoth_hunt")
	ReadDataFile("raider\\hot1.lvl", "hoth_Smuggler")
	
    SetSpawnDelay(10, 0.25)
    SetDenseEnvironment("false")
    SetDefenderSnipeRange(170)
    AddDeathRegion("Death")
    OpenAudioStream("sound\\global.lvl", "gcw_music")
    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing", 1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing", 1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)
    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", 0.10000000149012, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", 0.10000000149012, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", 0.10000000149012, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", 0.10000000149012, 1)
    SetOutOfBoundsVoiceOver(2, "Allleaving")
    SetOutOfBoundsVoiceOver(1, "Impleaving")
    SetAmbientMusic(ALL, 1, "all_hot_amb_start", 0, 1)
    SetAmbientMusic(ALL, 0.89999997615814, "all_hot_amb_middle", 1, 1)
    SetAmbientMusic(ALL, 0.10000000149012, "all_hot_amb_end", 2, 1)
    SetAmbientMusic(IMP, 1, "imp_hot_amb_start", 0, 1)
    SetAmbientMusic(IMP, 0.89999997615814, "imp_hot_amb_middle", 1, 1)
    SetAmbientMusic(IMP, 0.10000000149012, "imp_hot_amb_end", 2, 1)
    SetVictoryMusic(ALL, "all_hot_amb_victory")
    SetDefeatMusic(ALL, "all_hot_amb_defeat")
    SetVictoryMusic(IMP, "imp_hot_amb_victory")
    SetDefeatMusic(IMP, "imp_hot_amb_defeat")
    SetSoundEffect("ScopeDisplayZoomIn", "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    SetSoundEffect("SpawnDisplayUnitChange", "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack", "shell_menu_exit")
    SetSoundEffect("CaptureFlag", "sfx_start_beep")
    --  Camera Stats
    --Hoth
    --Hangar
    AddCameraShot(0.944210, 0.065541, 0.321983, -0.022350, -500.489838, 0.797472, -68.773849)
    --Shield Generator
    AddCameraShot(0.371197, 0.008190, -0.928292, 0.020482, -473.384155, -17.880533, 132.126801)
    --Battlefield
    AddCameraShot(0.927083, 0.020456, -0.374206, 0.008257, -333.221558, 0.676043, -14.027348)

end
