-- yav1g_mcm
-- PSP Mission Script; 'Rogue Assassin' Yavin level
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveAssault")
ScriptCB_DoFile("MultiObjectiveContainer")
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("Ambush")
REP = 2
IMP = 1
locals = 3
ATT = 1
DEF = 2
EnableSPHeroRules()

function ScriptPostLoad()
	KillObject ("TempleBlastDoor")
    DisableBarriers("StopTanks")
    
	    AddDeathRegion("death1")
	    AddDeathRegion("death2")
	    AddDeathRegion("death3")
	    AddDeathRegion("death4")
	    AddDeathRegion("death5")
	    AddDeathRegion("death6")
	    AddDeathRegion("death7")
	    AddDeathRegion("death8") 
		
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

    TDM = ObjectiveTDM:New({teamATT = 1, teamDEF = 2, multiplayerRules = true})
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

    AAB_count = 3
    AAB = TargetType:New({classname = "rep_inf_ep3_officer", killLimit = 3})

    AAB.OnDestroy = function(param1, param2)
        AAB_count = AAB_count - 1
        ShowMessageText("level.cor1c_m.merc.2-" .. AAB_count, ATT)
    end

    Objective1 =
        ObjectiveAssault:New(
        {
            teamATT = ATT,
            teamDEF = DEF,
            AIGoalWeight = 1,
            textATT = "level.cor1c_m.merc.end",
            popupText = "level.cor1c_m.merc.popup"
        }
    )

    Objective1:AddTarget(AAB)

    Objective1.OnComplete = function(param0)
        StartTimer(missiontimer3)
        StopTimer(fiveminremains)
        StopTimer(fourminremains)
        StopTimer(threeminremains)
        StopTimer(twominremains)
        StopTimer(oneminremains)
        StopTimer(thirtysecremains)
        StopTimer(tensecremains)
    end

    AAT_count = 3
    AAT = TargetType:New({classname = "rep_inf_ep3_officer", killLimit = 3})

    AAT.OnDestroy = function(param1, param2)
        AAT_count = AAT_count - 1
        ShowMessageText("level.cor1c_m.merc.1-" .. AAT_count, ATT)
    end

    Objective2 =
        ObjectiveAssault:New(
        {
            teamATT = ATT,
            teamDEF = DEF,
            AIGoalWeight = 1,
            textATT = "level.cor1c_m.merc.end2",
            textDEF = "level.dag1.objectives.1"
        }
    )
    Objective2:AddTarget(AAT)
    Objective2.OnComplete = function(OnCompleteParam0)
        ShowMessageText("level.cor1.merc.1", ATT)
        MissionVictory(ATT)
    end

    missiontimer2 = CreateTimer("missiontimer2")
    SetTimerValue(missiontimer2, 1)
    StartTimer(missiontimer2)
    OnTimerElapse(
        function()
            Ambush("Team2LeftPath", 3, 3)
			--Ambush("target1", 3, 3)
            AddAIGoal(locals, "Deathmatch", 9999)
            AddAIGoal(2, "Deathmatch", 1)
            followguy1 = GetTeamMember(3, 0)
            followthatguy1 = AddAIGoal(2, "Follow", 3, followguy1)
            followguy2 = GetTeamMember(3, 1)
            followthatguy2 = AddAIGoal(2, "Follow", 3, followguy2)
            followguy3 = GetTeamMember(3, 2)
            followthatguy3 = AddAIGoal(2, "Follow", 3, followguy3)
            SetAIDifficulty(2, 1, "medium")
            SetAIDifficulty(3, 2, "medium")
        end,
        "missiontimer2"
    )
    missiontimer3 = CreateTimer("missiontimer3")
    SetTimerValue(missiontimer3, 1)
    OnTimerElapse(
        function()
            Ambush("Team2RightPath", 3, 3)
			--Ambush("target2", 3, 3)
            AddAIGoal(locals, "Deathmatch", 9999)
            AddAIGoal(2, "Deathmatch", 1)
            followguy4 = GetTeamMember(3, 3)
            followthatguy4 = AddAIGoal(2, "Follow", 3, followguy4)
            followguy5 = GetTeamMember(3, 4)
            followthatguy5 = AddAIGoal(2, "Follow", 3, followguy5)
            followguy6 = GetTeamMember(3, 5)
            followthatguy6 = AddAIGoal(2, "Follow", 3, followguy6)
            SetTimerValue(missiontimer, 300)
            StartTimer(fourminremains1)
            StartTimer(threeminremains1)
            StartTimer(twominremains1)
            StartTimer(oneminremains1)
            StartTimer(thirtysecremains1)
            StartTimer(tensecremains1)
            SetAIDifficulty(2, 1, "medium")
            SetAIDifficulty(3, 2, "medium")
        end,
        "missiontimer3"
    )
    objectiveSequence = MultiObjectiveContainer:New({})
    objectiveSequence:AddObjectiveSet(Objective1)
    objectiveSequence:AddObjectiveSet(Objective2)
    objectiveSequence:AddObjectiveSet(TDM)
    objectiveSequence:Start()
	
	--fix our rogue assassin
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "PointsToUnlock", "0")
	
	--get rid of ctf stuff
	KillObject("Flag")
	SetProperty("Flag", "CurHealth", 0)
	SetProperty("Flag", "IsVisible", 0)
	SetProperty("Flag", "IsCollidable ", 0)
	SetProperty("Flag", "PhysicsActive", 0)
	KillObject("Team1Capture")
	SetProperty("Team1Capture", "CurHealth", 0)
	SetProperty("Team1Capture", "IsVisible", 0)
	SetProperty("Team1Capture", "IsCollidable ", 0)
	SetProperty("Team1Capture", "PhysicsActive", 0)
	KillObject("Team2Capture")
	SetProperty("Team2Capture", "CurHealth", 0)
	SetProperty("Team2Capture", "IsVisible", 0)
	SetProperty("Team2Capture", "IsCollidable ", 0)
	SetProperty("Team2Capture", "PhysicsActive", 0)		
	
--hide posts
	MapHideCommandPosts(true)
	SetProperty("Team1Right", "MapTexture", " ")
	SetProperty("Team1Right", "MapScale", 0.0)
	SetProperty("Team1Left", "MapTexture", " ")
	SetProperty("Team1Left", "MapScale", 0.0)
	SetProperty("Team2Right", "MapTexture", " ")
	SetProperty("Team2Right", "MapScale", 0.0)
	SetProperty("Team2Left", "MapTexture", " ")
	SetProperty("Team2Left", "MapScale", 0.0)	
end

function ScriptInit()
    StealArtistHeap(300 * 1024)
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(2222777)
        SetPSPClipper(1)
    else
        SetPS2ModelMemory(2500000)
    end
    ReadDataFile("ingame.lvl")
    ReadDataFile("sound\\yav.lvl;yav1cw")
    SetMaxFlyHeight(18)
    SetMaxPlayerFlyHeight(18)
    ReadDataFile(
        "SIDE\\rep.lvl",
        "rep_inf_ep3_rifleman",
        "rep_inf_ep3_engineer",
        "rep_inf_ep3_rocketeer",
        "rep_inf_ep3_jettrooper",
        "rep_inf_ep3_sniper",
        "rep_inf_ep3_officer",
        "rep_inf_ep2_pilot",
        "rep_inf_ep2_jettrooper_rifleman"
    )
    ReadDataFile("SIDE\\cis.lvl", "cis_hero_jangofett")
    ReadDataFile("SIDE\\tur.lvl", "tur_bldg_laser", "tur_bldg_tower")
    SetUnitCount(ATT, 4)
    SetReinforcementCount(ATT, -1)
    SetTeamName(IMP, "IMP")
    SetTeamIcon(IMP, "IMP_icon")
    AddUnitClass(IMP, "rep_inf_ep2_jettrooper_rifleman", 1)
    SetUnitCount(DEF, 12)
    SetReinforcementCount(DEF, -1)
    SetTeamName(REP, "Republic")
    SetTeamIcon(REP, "rep_icon")
    AddUnitClass(REP, "rep_inf_ep3_rifleman", 3)
    AddUnitClass(REP, "rep_inf_ep3_engineer", 2)
    AddUnitClass(REP, "rep_inf_ep3_rocketeer", 3)
    AddUnitClass(REP, "rep_inf_ep3_jettrooper", 2)
    AddUnitClass(REP, "rep_inf_ep3_sniper", 2)
    SetHeroClass(IMP, "cis_hero_jangofett")
    ForceHumansOntoTeam1()
    SetTeamName(locals, "rep")
    AddUnitClass(locals, "rep_inf_ep3_officer", 6)
    SetUnitCount(locals, 12)
    SetTeamAsFriend(locals, REP)
    SetTeamAsFriend(REP, locals)
    SetTeamAsEnemy(locals, IMP)
    SetTeamAsEnemy(IMP, locals)
    SetReinforcementCount(locals, 6)
    AddWalkerType(0, 0)
    AddWalkerType(1, 0)
    AddWalkerType(2, 0)
    AddWalkerType(3, 0)
    local weaponCnt = 214
    SetMemoryPoolSize("Aimer", 13)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 1000)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth", 17)
    SetMemoryPoolSize("EntitySoundStream", 4)
    SetMemoryPoolSize("EntitySoundStatic", 20)
    SetMemoryPoolSize("EntityLight", 38)
    SetMemoryPoolSize("FlagItem", 1)
    SetMemoryPoolSize("MountedTurret", 13)
    SetMemoryPoolSize("Navigator", 46)
    SetMemoryPoolSize("Obstacle", 750)
    SetMemoryPoolSize("PathNode", 512)
    SetMemoryPoolSize("SoundSpaceRegion", 48)
    SetMemoryPoolSize("TreeGridStack", 500)
    SetMemoryPoolSize("UnitAgent", 46)
    SetMemoryPoolSize("UnitController", 46)
    SetMemoryPoolSize("Weapon", weaponCnt)
    SetMemoryPoolSize("EntityFlyer", 7)
    SetMemoryPoolSize("EntityHover", 2)
    SetSpawnDelay(10, 0.25)
	
	ReadDataFile("YAV\\yav1.lvl","Yavin1_CTF_CenterFlag")
    --ReadDataFile("YAV\\yav1mcm.lvl", "Yavin1_merc")
	--ReadDataFile("YAV\\yav1.lvl", "yavin1_TDM")
	
    SetDenseEnvironment("false")
    SetAIViewMultiplier(0.5)
    SetNumBirdTypes(2)
    SetBirdType(0, 1, "bird")
    SetBirdType(1, 1.5, "bird2")
    SetNumFishTypes(1)
    SetFishType(0, 0.80000001192093, "fish")
    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\cor.lvl",  "cor1")
    OpenAudioStream("sound\\cor.lvl",  "cor1")
    -- OpenAudioStream("sound\\cor.lvl",  "cor1_emt")

    -- SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    -- SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    -- SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    -- SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

    SetOutOfBoundsVoiceOver(REP, "Repleaving")
    SetOutOfBoundsVoiceOver(IMP, "Repleaving")

    SetAmbientMusic(REP, 1.0, "rep_yav_amb_start",  0,1)
    SetAmbientMusic(REP, 0.9, "rep_yav_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.1, "rep_yav_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "cis_yav_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.9, "cis_yav_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.1, "cis_yav_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_yav_amb_victory")
    SetDefeatMusic (REP, "rep_yav_amb_defeat")
    SetVictoryMusic(IMP, "cis_yav_amb_victory")
    SetDefeatMusic (IMP, "cis_yav_amb_defeat")

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
    --Yav 1 - Temple
    --Fountain
	AddCameraShot(0.660400, -0.059877, -0.745465, -0.067590, 143.734436, -55.725388, 7.761997);
	AddCameraShot(0.830733, -0.144385, 0.529679, 0.092061, 111.796799, -42.959831, 75.199142);
	AddCameraShot(0.475676, -0.064657, -0.869247, -0.118154, 13.451733, -47.769894, 13.242496);
	AddCameraShot(-0.168833, 0.020623, -0.978158, -0.119483, 58.080200, -50.858742, -62.208008);
	AddCameraShot(0.880961, -0.440820, -0.153824, -0.076971, 101.777763, -46.775646, -29.683767);
	AddCameraShot(0.893823, -0.183838, 0.400618, 0.082398, 130.714828, -60.244068, -27.587791);
	AddCameraShot(0.999534, 0.004060, 0.030244, -0.000123, 222.209137, -61.220325, -18.061192);
	AddCameraShot(0.912637, -0.057866, 0.403844, 0.025606, 236.693344, -49.829277, -116.150986);
	AddCameraShot(0.430732, -0.016398, -0.901678, -0.034328, 180.692062, -54.148796, -159.856644);
	AddCameraShot(0.832119, -0.063785, 0.549306, 0.042107, 160.699402, -54.148796, -130.990692);
	AddCameraShot(0.404200, -0.037992, -0.909871, -0.085520, 68.815331, -54.148796, -160.837585);
	AddCameraShot(-0.438845, 0.053442, -0.890394, -0.108431, 116.562241, -52.504406, -197.686005);
	AddCameraShot(0.389349, -0.113400, -0.877617, -0.255609, 29.177610, -23.974962, -288.061676);
	AddCameraShot(0.499938, -0.081056, -0.851146, -0.137998, 90.326912, -28.060659, -283.329376);
	AddCameraShot(-0.217006, 0.015116, -0.973694, -0.067827, 202.056778, -37.476913, -181.445663);
	AddCameraShot(0.990640, -0.082509, 0.108367, 0.009026, 206.266953, -37.476913, -225.158249);
	AddCameraShot(-0.386589, 0.126400, -0.868314, -0.283907, 224.942032, -17.820135, -269.532227);
	AddCameraShot(0.967493, 0.054298, 0.246611, -0.013840, 155.984451, -30.781782, -324.836975);
	AddCameraShot(-0.453147, 0.140485, -0.840816, -0.260672, 164.648956, -0.002431, -378.487061);
	AddCameraShot(0.592731, -0.182571, -0.749678, -0.230913, 99.326836, -13.029744, -414.846191);
	AddCameraShot(0.865750, -0.184352, 0.455084, 0.096905, 137.221359, -19.694859, -436.057556);
	AddCameraShot(0.026915, -0.002609, -0.994969, -0.096461, 128.397949, -30.249140, -428.447418);
end

-- INFO 0x1 0x0 0x0 0x0 0x1 0x0 0x0 0x0
