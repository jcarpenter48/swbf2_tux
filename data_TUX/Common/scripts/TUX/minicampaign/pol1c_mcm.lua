--pol1c_mcm.lua
-- PSP 'Rogue Assassin' Polis Massa mission
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveAssault")
ScriptCB_DoFile("MultiObjectiveContainer")
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("Ambush")
REP = 1
CIS = 2
locals = 3
ATT = 1
DEF = 2

function ScriptPostLoad()
    EnableSPHeroRules()
    missiontimer = CreateTimer("missiontimer")
    SetTimerValue(missiontimer, 360)
    StartTimer(missiontimer)
    ShowTimer(missiontimer)
    OnTimerElapse(
        function()
            MissionVictory(DEF)
        end,
        "missiontimer"
    )

    TDM = ObjectiveTDM:New({teamATT = 1, teamDEF = 2, textATT = "level.pol1c_m.merc.merc1", multiplayerRules = true})
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
    StartTimer(fiveminremains)
    StartTimer(fourminremains)
    StartTimer(threeminremains)
    StartTimer(twominremains)
    StartTimer(oneminremains)
    StartTimer(thirtysecremains)
    StartTimer(tensecremains)

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
    fourminremains1 = CreateTimer("fourminremains1")
    SetTimerValue(fourminremains1, 60)
    threeminremains1 = CreateTimer("threeminremains1")
    SetTimerValue(threeminremains1, 120)
    twominremains1 = CreateTimer("twominremains1")
    SetTimerValue(twominremains1, 180)
    oneminremains1 = CreateTimer("oneminremains1")
    SetTimerValue(oneminremains1, 240)
    thirtysecremains1 = CreateTimer("thirtysecremains1")
    SetTimerValue(thirtysecremains1, 270)
    tensecremains1 = CreateTimer("tensecremains1")
    SetTimerValue(tensecremains1, 290)

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.4min")
        end,
        "fourminremains1"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.3min")
        end,
        "threeminremains1"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.2min")
        end,
        "twominremains1"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.1min")
        end,
        "oneminremains1"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.30sec")
        end,
        "thirtysecremains1"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.10sec")
        end,
        "tensecremains1"
    )

    AAT_count = 3
    AAT = TargetType:New({classname = "cis_inf_officer", killLimit = 3})
    AAT.OnDestroy = function(self, objectPtr)
        AAT_count = AAT_count - 1
        ShowMessageText("level.pol1c_m.merc.2-" .. AAT_count, ATT)
    end
    Objective2 =
        ObjectiveAssault:New({teamATT = ATT, teamDEF = DEF, AIGoalWeight = 1, textATT = "level.pol1c_m.merc.end2"})
    Objective2:AddTarget(AAT)

    Objective2.OnComplete = function(self)
        MissionVictory(ATT)
    end

    AAB_count = 3
    AAB = TargetType:New({classname = "cis_inf_officer", killLimit = 3})
    AAB.OnDestroy = function(self, objectPtr)
        AAB_count = AAB_count - 1
        ShowMessageText("level.pol1c_m.merc.1-" .. AAB_count, ATT)
    end
    Objective1 =
        ObjectiveAssault:New(
        {
            teamATT = ATT,
            teamDEF = DEF,
            AIGoalWeight = 1,
            textATT = "level.pol1c_m.merc.end",
            popupText = "level.pol1c_m.merc.popup"
        }
    )
    Objective1:AddTarget(AAB)
    Objective1.OnComplete = function(self)
        StartTimer(missiontimer3)
        StopTimer(fiveminremains)
        StopTimer(fourminremains)
        StopTimer(threeminremains)
        StopTimer(twominremains)
        StopTimer(oneminremains)
        StopTimer(thirtysecremains)
        StopTimer(tensecremains)
    end

    missiontimer2 = CreateTimer("missiontimer2")
    SetTimerValue(missiontimer2, 1)
    StartTimer(missiontimer2)
    OnTimerElapse(
        function()
           -- Ambush("off_path", 3, 3)
			Ambush("Team2DefSpawnPath", 3, 3)
            AddAIGoal(3, "Deathmatch", 9999)
            followguy1 = GetTeamMember(3, 0)
            followthatguy1 = AddAIGoal(2, "Follow", 3, followguy1)
            followguy2 = GetTeamMember(3, 1)
            followthatguy2 = AddAIGoal(2, "Follow", 3, followguy2)
            followguy3 = GetTeamMember(3, 2)
            followthatguy3 = AddAIGoal(2, "Follow", 3, followguy3)
            AddAIGoal(2, "Deathmatch", 1)
            SetAIDifficulty(2, 2, "medium")
            SetAIDifficulty(3, 5, "medium")
        end,
        "missiontimer2"
    )
    missiontimer3 = CreateTimer("missiontimer3")
    SetTimerValue(missiontimer3, 2)
    OnTimerElapse(
        function()
            --Ambush("off_path2", 2, 3)
           -- Ambush("off_path3", 1, 3)
			Ambush("Team2OffSpawn", 2, 3)
            Ambush("Team2DefSpawnPath", 1, 3)
            AddAIGoal(3, "Deathmatch", 9999)
            followguy4 = GetTeamMember(3, 3)
            followthatguy4 = AddAIGoal(2, "Follow", 3, followguy4)
            followguy5 = GetTeamMember(3, 4)
            followthatguy5 = AddAIGoal(2, "Follow", 3, followguy5)
            followguy6 = GetTeamMember(3, 5)
            followthatguy6 = AddAIGoal(2, "Follow", 3, followguy6)
            SetTimerValue(missiontimer, 300)
            AddAIGoal(2, "Deathmatch", 1)
            SetTimerValue(missiontimer, 300)
            SetAIDifficulty(2, 2, "medium")
            SetAIDifficulty(3, 5, "medium")
            StartTimer(fourminremains1)
            StartTimer(threeminremains1)
            StartTimer(twominremains1)
            StartTimer(oneminremains1)
            StartTimer(thirtysecremains1)
            StartTimer(tensecremains1)
        end,
        "missiontimer3"
    )
    objectiveSequence = MultiObjectiveContainer:New({})
    objectiveSequence:AddObjectiveSet(Objective1)
    objectiveSequence:AddObjectiveSet(Objective2)
    objectiveSequence:AddObjectiveSet(TDM)
    objectiveSequence:Start()
    OnObjectRespawnName(PlayAnimLock01Open, "LockCon01")
    OnObjectKillName(PlayAnimLock01Close, "LockCon01")
	
	--fix our rogue assassin
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "PointsToUnlock", "0")
	
	--get rid of ctf stuff
	KillObject("Flag1")
	SetProperty("Flag1", "CurHealth", 0)
	SetProperty("Flag1", "IsVisible", 0)
	SetProperty("Flag1", "IsCollidable ", 0)
	SetProperty("Flag1", "PhysicsActive", 0)
	KillObject("Flag2")
	SetProperty("Flag2", "CurHealth", 0)
	SetProperty("Flag2", "IsVisible", 0)
	SetProperty("Flag2", "IsCollidable ", 0)
	SetProperty("Flag2", "PhysicsActive", 0)
	KillObject("com_bldg_ctfbase")
	SetProperty("com_bldg_ctfbase", "CurHealth", 0)
	SetProperty("com_bldg_ctfbase", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase", "IsCollidable ", 0)
	SetProperty("com_bldg_ctfbase", "PhysicsActive", 0)
	KillObject("com_bldg_ctfbase1")
	SetProperty("com_bldg_ctfbase1", "CurHealth", 0)
	SetProperty("com_bldg_ctfbase1", "IsVisible", 0)
	SetProperty("com_bldg_ctfbase1", "IsCollidable ", 0)
	SetProperty("com_bldg_ctfbase1", "PhysicsActive", 0)	
	
--hide posts
	MapHideCommandPosts(true)
	SetProperty("Team2FlagHome", "MapTexture", " ")
	SetProperty("Team2FlagHome", "MapScale", 0.0)
	SetProperty("Team2OffCP", "MapTexture", " ")
	SetProperty("Team2OffCP", "MapScale", 0.0)
	SetProperty("Team1FlagHome", "MapTexture", " ")
	SetProperty("Team1FlagHome", "MapScale", 0.0)
	SetProperty("Team1OffCP", "MapTexture", " ")
	SetProperty("Team1OffCP", "MapScale", 0.0)	
end

function PlayAnimLock01Open()
    PauseAnimation("Airlockclose")
    RewindAnimation("Airlockopen")
    PlayAnimation("Airlockopen")
end

function PlayAnimLock01Close()
    PauseAnimation("Airlockopen")
    RewindAnimation("Airlockclose")
    PlayAnimation("Airlockclose")
end

function ScriptInit()
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(2598193)
    else
        SetPS2ModelMemory(4090000)
    end
    ReadDataFile("ingame.lvl")
    ReadDataFile("sound\\pol.lvl;pol1cw")
    SetMapNorthAngle(0)
    SetMaxFlyHeight(55)
    SetMaxPlayerFlyHeight (55)
    AISnipeSuitabilityDist(30)
    ReadDataFile("SIDE\\cis.lvl", "cis_inf_rifleman", "cis_inf_officer", "cis_hover_aat", "cis_hero_jangofett")
    ReadDataFile("SIDE\\rep.lvl", "rep_inf_ep2_jettrooper_rifleman")
    ForceHumansOntoTeam1()
    SetTeamName(1, "REP")
    SetTeamIcon(1, "rep_icon")
    AddUnitClass(1, "rep_inf_ep2_jettrooper_rifleman", 1)
    SetHeroClass(1, "cis_hero_jangofett")
    SetTeamName(2, "cis")
    SetTeamIcon(2, "cis_icon")
    AddUnitClass(2, "cis_inf_rifleman", 4)
    SetUnitCount(ATT, 4)
    SetReinforcementCount(ATT, -1)
    SetUnitCount(DEF, 12)
    SetReinforcementCount(DEF, -1)
    SetTeamName(locals, "cis")
    AddUnitClass(locals, "cis_inf_officer", 6)
    SetUnitCount(locals, 12)
    SetTeamAsFriend(locals, CIS)
    SetTeamAsFriend(CIS, locals)
    SetTeamAsEnemy(locals, 1)
    SetTeamAsEnemy(1, locals)
    SetReinforcementCount(locals, 6)
    ClearWalkers()
    SetMemoryPoolSize("MountedTurret", 16)
    SetMemoryPoolSize("EntityHover", 4)
    SetMemoryPoolSize("EntityFlyer", 0)
    SetMemoryPoolSize("EntityDroid", 10)
    SetMemoryPoolSize("EntityCarrier", 0)
    SetMemoryPoolSize("Obstacle", 380)
    SetMemoryPoolSize("Weapon", 260)
    SetMemoryPoolSize("EntityLight", 63)
    if gPlatformStr == "XBox" then
        SetMemoryPoolSize("Asteroid", 100)
    else
        if gPlatformStr == "PS2" then
            SetMemoryPoolSize("Asteroid", 100)
        else
            SetMemoryPoolSize("Asteroid", 100)
        end
    end
    SetSpawnDelay(10, 0.25)
    
	ReadDataFile("pol\\pol1.lvl", "pol1_ctf")
	--ReadDataFile("pol\\pol1mcm.lvl", "pol1_merc")
	--ReadDataFile("pol\\pol1.lvl", "pol1_ctf")
	
    SetDenseEnvironment("True")
    AddDeathRegion("deathregion1")
    SetParticleLODBias(3000)
    SetMaxCollisionDistance(1500)
    if gPlatformStr == "XBox" then
        FillAsteroidPath("pathas01", 10, "pol1_prop_asteroid_01", 20, 1, 0, 0, -1, 0, 0)
        FillAsteroidPath("pathas01", 20, "pol1_prop_asteroid_02", 40, 1, 0, 0, -1, 0, 0)
        FillAsteroidPath("pathas02", 10, "pol1_prop_asteroid_01", 10, 1, 0, 0, -1, 0, 0)
        FillAsteroidPath("pathas03", 10, "pol1_prop_asteroid_02", 20, 1, 0, 0, -1, 0, 0)
        FillAsteroidPath("pathas04", 5, "pol1_prop_asteroid_02", 2, 1, 0, 0, -1, 0, 0)
    else
        if gPlatformStr == "PS2" then
            FillAsteroidPath("pathas01", 10, "pol1_prop_asteroid_01", 20, 1, 0, 0, -1, 0, 0)
            FillAsteroidPath("pathas01", 20, "pol1_prop_asteroid_02", 40, 1, 0, 0, -1, 0, 0)
            FillAsteroidPath("pathas02", 10, "pol1_prop_asteroid_01", 10, 1, 0, 0, -1, 0, 0)
            FillAsteroidPath("pathas03", 10, "pol1_prop_asteroid_02", 20, 1, 0, 0, -1, 0, 0)
            FillAsteroidPath("pathas04", 5, "pol1_prop_asteroid_02", 2, 1, 0, 0, -1, 0, 0)
        else
            FillAsteroidPath("pathas01", 10, "pol1_prop_asteroid_01", 20, 1, 0, 0, -1, 0, 0)
            FillAsteroidPath("pathas01", 20, "pol1_prop_asteroid_02", 40, 1, 0, 0, -1, 0, 0)
            FillAsteroidPath("pathas02", 10, "pol1_prop_asteroid_01", 10, 1, 0, 0, -1, 0, 0)
            FillAsteroidPath("pathas03", 10, "pol1_prop_asteroid_02", 20, 1, 0, 0, -1, 0, 0)
            FillAsteroidPath("pathas04", 5, "pol1_prop_asteroid_02", 2, 1, 0, 0, -1, 0, 0)
        end
    end
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\pol.lvl",  "pol1")
    OpenAudioStream("sound\\pol.lvl",  "pol1")
    -- OpenAudioStream("sound\\cor.lvl",  "cor1_emt")

    -- SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    -- SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    -- SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    -- SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

    SetOutOfBoundsVoiceOver(REP, "Repleaving")
    SetOutOfBoundsVoiceOver(CIS, "Cisleaving")

    SetAmbientMusic(REP, 1.0, "rep_pol_amb_start",  0,1)
    SetAmbientMusic(REP, 0.9, "rep_pol_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.1, "rep_pol_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_pol_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.9, "cis_pol_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.1, "cis_pol_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_pol_amb_victory")
    SetDefeatMusic (REP, "rep_pol_amb_defeat")
    SetVictoryMusic(CIS, "cis_pol_amb_victory")
    SetDefeatMusic (CIS, "cis_pol_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")
    SetAttackingTeam(ATT)
    AddCameraShot(0.461189, -0.077838, -0.871555, -0.147098, 85.974007, 30.694353, -66.900795);
    AddCameraShot(0.994946, -0.100380, -0.002298, -0.000232, 109.076401, 27.636383, -10.235785);
    AddCameraShot(0.760383, 0.046402, 0.646612, -0.039459, 111.261696, 27.636383, 46.468048);
    AddCameraShot(-0.254949, 0.066384, -0.933546, -0.243078, 73.647552, 32.764030, 50.283028);
    AddCameraShot(-0.331901, 0.016248, -0.942046, -0.046116, 111.003563, 28.975283, 7.051458);
    AddCameraShot(0.295452, -0.038140, -0.946740, -0.122217, 19.856682, 36.399086, -9.890361);
    AddCameraShot(0.958050, -0.115837, -0.260254, -0.031467, -35.103737, 37.551651, 109.466576);
    AddCameraShot(-0.372488, 0.036892, -0.922789, -0.091394, -77.487892, 37.551651, 40.861832);
    AddCameraShot(0.717144, -0.084845, -0.686950, -0.081273, -106.047691, 36.238495, 60.770439);
    AddCameraShot(0.452958, -0.104748, -0.862592, -0.199478, -110.553474, 40.972584, 37.320778);
    AddCameraShot(-0.009244, 0.001619, -0.984956, -0.172550, -57.010258, 30.395561, 5.638251);
    AddCameraShot(0.426958, -0.040550, -0.899315, -0.085412, -87.005966, 30.395561, 19.625088);
    AddCameraShot(0.153632, -0.041448, -0.953179, -0.257156, -111.955055, 36.058708, -23.915501);
    AddCameraShot(0.272751, -0.002055, -0.962055, -0.007247, -117.452736, 17.298250, -58.572723);
    AddCameraShot(0.537097, -0.057966, -0.836668, -0.090297, -126.746666, 30.472836, -148.353333);
    AddCameraShot(-0.442188, 0.081142, -0.878575, -0.161220, -85.660973, 29.013374, -144.102219);
    AddCameraShot(-0.065409, 0.011040, -0.983883, -0.166056, -84.789032, 29.013374, -139.568787);
    AddCameraShot(0.430906, -0.034723, -0.898815, -0.072428, -98.038002, 47.662624, -128.643265);
    AddCameraShot(-0.401462, 0.047050, -0.908449, -0.106466, 77.586563, 47.662624, -147.517365);
    AddCameraShot(-0.269503, 0.031284, -0.956071, -0.110983, 111.260330, 16.927542, -114.045715);
    AddCameraShot(-0.338119, 0.041636, -0.933134, -0.114906, 134.970169, 26.441256, -82.282082);
end
