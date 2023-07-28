-- cor1c_mcm.lua
-- PSP Mission file; 'Rogue Assassin' Coruscant mission
-- Seems to be an unused 'Rogue Assassin' level that shipped with the PSP version
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
    ForceHumansOntoTeam1()
    EnableSPHeroRules()
    	SetProperty ("LibCase1","MaxHealth",1000)
    	SetProperty ("LibCase2","MaxHealth",1000)
    	SetProperty ("LibCase3","MaxHealth",1000)
    	SetProperty ("LibCase4","MaxHealth",1000)
    	SetProperty ("LibCase5","MaxHealth",1000)
    	SetProperty ("LibCase6","MaxHealth",1000)
    	SetProperty ("LibCase7","MaxHealth",1000)
    	SetProperty ("LibCase8","MaxHealth",1000)
    	SetProperty ("LibCase9","MaxHealth",1000)
    	SetProperty ("LibCase10","MaxHealth",1000)
    	SetProperty ("LibCase11","MaxHealth",1000)
    	SetProperty ("LibCase12","MaxHealth",1000)
    	SetProperty ("LibCase13","MaxHealth",1000)
    	SetProperty ("LibCase14","MaxHealth",1000)


    	SetProperty ("LibCase1","CurHealth",1000)
    	SetProperty ("LibCase2","CurHealth",1000)
    	SetProperty ("LibCase3","CurHealth",1000)
    	SetProperty ("LibCase4","CurHealth",1000)
    	SetProperty ("LibCase5","CurHealth",1000)
    	SetProperty ("LibCase6","CurHealth",1000)
    	SetProperty ("LibCase7","CurHealth",1000)
    	SetProperty ("LibCase8","CurHealth",1000)
    	SetProperty ("LibCase9","CurHealth",1000)
    	SetProperty ("LibCase10","CurHealth",1000)
    	SetProperty ("LibCase11","CurHealth",1000)
    	SetProperty ("LibCase12","CurHealth",1000)
    	SetProperty ("LibCase13","CurHealth",1000)
    	SetProperty ("LibCase14","CurHealth",1000)

		DisableBarriers("SideDoor1")
		DisableBarriers("MainLibraryDoors")
		DisableBarriers("SideDoor2")
		DisableBarriers("SIdeDoor3")
		DisableBarriers("ComputerRoomDoor1")
		DisableBarriers("StarChamberDoor1")
		DisableBarriers("StarChamberDoor2")
		DisableBarriers("WarRoomDoor1")
		DisableBarriers("WarRoomDoor2")
		DisableBarriers("WarRoomDoor3") 
		PlayAnimation("DoorOpen01")
		PlayAnimation("DoorOpen02")
			PlayAnimation("DoorOpen01")
			PlayAnimation("DoorOpen02")
			
	AddDeathRegion("death")
    AddDeathRegion("death1")
    AddDeathRegion("death2")
    AddDeathRegion("death3")
    AddDeathRegion("death4")
	
    missiontimer = CreateTimer("missiontimer")
    SetTimerValue(missiontimer, 420)
    StartTimer(missiontimer)
    ShowTimer(missiontimer)
    OnTimerElapse(
        function()
            MissionVictory(DEF)
        end,
        "missiontimer"
    )

    TDM = ObjectiveTDM:New({teamATT = 1, teamDEF = 2, multiplayerRules = true})
    AAB_count = 3
    AAB = TargetType:New({classname = "rep_inf_ep3_officer", killLimit = 3})
    AAB.OnDestroy = function(OnDestroyParam0, OnDestroyParam1)
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
            popupText = "level.cor1c_m.merc.end"
        }
    )
    Objective1:AddTarget(AAB)
    Objective1.OnComplete = function(OnCompleteParam0)
        StartTimer(missiontimer3)
    end

    AAT_count = 3
    AAT = TargetType:New({classname = "rep_inf_ep3_officer", killLimit = 3})
    AAT.OnDestroy = function(OnDestroyParam0, OnDestroyParam1)
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
            Ambush("Team2dEF01SpawnPath", 3, 3)
			-- Ambush("target1", 3, 3)
            AddAIGoal(locals, "Deathmatch", 9999)
            followguy1 = GetTeamMember(3, 0)
            followthatguy1 = AddAIGoal(2, "Follow", 3, followguy1)
            followguy2 = GetTeamMember(3, 1)
            followthatguy2 = AddAIGoal(2, "Follow", 3, followguy2)
            followguy3 = GetTeamMember(3, 2)
            followthatguy3 = AddAIGoal(2, "Follow", 3, followguy3)
        end,
        "missiontimer2"
    )

    missiontimer3 = CreateTimer("missiontimer3")
    SetTimerValue(missiontimer3, 1)
    OnTimerElapse(
        function()
            Ambush("Team2Off01SpawnPath", 3, 3)
			--Ambush("target2", 3, 3)
            AddAIGoal(locals, "Deathmatch", 9999)
            followguy4 = GetTeamMember(3, 3)
            followthatguy4 = AddAIGoal(2, "Follow", 3, followguy4)
            followguy5 = GetTeamMember(3, 4)
            followthatguy5 = AddAIGoal(2, "Follow", 3, followguy5)
            followguy6 = GetTeamMember(3, 5)
            followthatguy6 = AddAIGoal(2, "Follow", 3, followguy6)
            SetTimerValue(missiontimer, 300)
        end,
        "missiontimer3"
    )
    objectiveSequence = MultiObjectiveContainer:New({})
    objectiveSequence:AddObjectiveSet(Objective1)
    objectiveSequence:AddObjectiveSet(Objective2)
    objectiveSequence:AddObjectiveSet(TDM)
    objectiveSequence:Start()

--[[
    SetProperty("cp1", "CaptureRegion", " ")
    SetProperty("cp1", "Team", "1")    
    SetProperty("cp2", "CaptureRegion", " ")
    SetProperty("cp2", "Team", "2")	
    SetProperty("cp3", "CaptureRegion", " ")
    SetProperty("cp3", "Team", "1")
    SetProperty("cp4", "CaptureRegion", " ")
    SetProperty("cp4", "Team", "2")	
    SetProperty("cp5", "CaptureRegion", " ")
    SetProperty("cp5", "Team", "1")
    SetProperty("cp6", "CaptureRegion", " ")
    SetProperty("cp6", "Team", "2")

    SetProperty("cp7", "CaptureRegion", " ")
    SetProperty("cp7", "Team", "1")    
	]]--
	--get rid of ctf stuff
	KillObject("flag1")
	SetProperty("flag1", "CurHealth", 0)
	SetProperty("flag1", "IsVisible", 0)
	SetProperty("flag1", "IsCollidable ", 0)
	SetProperty("flag1", "PhysicsActive", 0)
	KillObject("flag2")
	SetProperty("flag2", "CurHealth", 0)
	SetProperty("flag2", "IsVisible", 0)
	SetProperty("flag2", "IsCollidable ", 0)
	SetProperty("flag2", "PhysicsActive", 0)
	KillObject("Team1FlagCapture")
	SetProperty("Team1FlagCapture", "CurHealth", 0)
	SetProperty("Team1FlagCapture", "IsVisible", 0)
	SetProperty("Team1FlagCapture", "IsCollidable ", 0)
	SetProperty("Team1FlagCapture", "PhysicsActive", 0)
	KillObject("Team2FlagCapture")
	SetProperty("Team2FlagCapture", "CurHealth", 0)
	SetProperty("Team2FlagCapture", "IsVisible", 0)
	SetProperty("Team2FlagCapture", "IsCollidable ", 0)
	SetProperty("Team2FlagCapture", "PhysicsActive", 0)		

--hide posts
	MapHideCommandPosts(true)
	SetProperty("cp3CTF", "MapTexture", " ")
	SetProperty("cp3CTF", "MapScale", 0.0)
	SetProperty("cp2CTF", "MapTexture", " ")
	SetProperty("cp2CTF", "MapScale", 0.0)
	SetProperty("cp1CTF", "MapTexture", " ")
	SetProperty("cp1CTF", "MapScale", 0.0)
	SetProperty("cp4CTF", "MapTexture", " ")
	SetProperty("cp4CTF", "MapScale", 0.0)	
	
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "PointsToUnlock", "0")
end

function ScriptInit()
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(3755505)
        SetPSPClipper(1)
    else
        SetPS2ModelMemory(4100000)
    end
    ReadDataFile("ingame.lvl")
    SetTeamAggressiveness(REP, 0.5)
    ReadDataFile("sound\\cor.lvl;cor1cw")
    SetMapNorthAngle(0)
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
    ReadDataFile("SIDE\\tur.lvl", "tur_bldg_laser")

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
    SetTeamName(locals, "locals")

    AddUnitClass(locals, "rep_inf_ep3_officer", 6)
    SetUnitCount(locals, 12)
    SetTeamAsFriend(locals, REP)
    SetTeamAsFriend(REP, locals)
    SetTeamAsEnemy(locals, IMP)
    SetTeamAsEnemy(IMP, locals)

    SetReinforcementCount(locals, 6)
    ClearWalkers()
    AddWalkerType(0, 0)
    AddWalkerType(1, 0)
    AddWalkerType(2, 0)
    AddWalkerType(3, 0)

    SetMemoryPoolSize("MountedTurret", 16)
    SetMemoryPoolSize("EntityHover", 4)
    SetMemoryPoolSize("EntityFlyer", 0)
    SetMemoryPoolSize("EntityDroid", 10)
    SetMemoryPoolSize("EntityCarrier", 0)
    SetMemoryPoolSize("EntityLight", 96)
    SetMemoryPoolSize("SoundSpaceRegion", 38)

    SetSpawnDelay(10, 0.25)
    ReadDataFile("cor\\cor1.lvl","cor1_CTF")
    SetDenseEnvironment("True")
    AddDeathRegion("DeathRegion1")

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

    SetOutOfBoundsVoiceOver(2, "Repleaving")
    SetOutOfBoundsVoiceOver(1, "Repleaving")

    SetAmbientMusic(REP, 1.0, "rep_cor_amb_start",  0,1)
    SetAmbientMusic(REP, 0.9, "rep_cor_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.1, "rep_cor_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "cis_cor_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.9, "cis_cor_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.1, "cis_cor_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_cor_amb_victory")
    SetDefeatMusic (REP, "rep_cor_amb_defeat")
    SetVictoryMusic(IMP, "cis_cor_amb_victory")
    SetDefeatMusic (IMP, "cis_cor_amb_defeat")

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

    --  Camera Stats
	AddCameraShot(0.419938, 0.002235, -0.907537, 0.004830, -15.639358, 5.499980, -176.911179);
	AddCameraShot(0.994506, 0.104463, -0.006739, 0.000708, 1.745251, 5.499980, -118.700668);
	AddCameraShot(0.008929, -0.001103, -0.992423, -0.122538, 1.366768, 16.818106, -114.422173);
	AddCameraShot(0.761751, -0.117873, -0.629565, -0.097419, 59.861904, 16.818106, -81.607773);
	AddCameraShot(0.717110, -0.013583, 0.696703, 0.013197, 98.053314, 11.354497, -85.857857);
	AddCameraShot(0.360958, -0.001053, -0.932577, -0.002721, 69.017578, 18.145807, -56.992413);
	AddCameraShot(-0.385976, 0.014031, -0.921793, -0.033508, 93.111061, 18.145807, -20.164375);
	AddCameraShot(0.695468, -0.129569, -0.694823, -0.129448, 27.284357, 18.145807, -12.377695);
	AddCameraShot(0.009002, -0.000795, -0.996084, -0.087945, 1.931320, 13.356332, -16.410583);
	AddCameraShot(0.947720, -0.145318, 0.280814, 0.043058, 11.650738, 16.955814, 28.359180);
	AddCameraShot(0.686380, -0.127550, 0.703919, 0.130810, -30.096384, 11.152356, -63.235146);
	AddCameraShot(0.937945, -0.108408, 0.327224, 0.037821, -43.701199, 8.756138, -49.974789);
	AddCameraShot(0.531236, -0.079466, -0.834207, -0.124787, -62.491230, 10.305247, -120.102989);
	AddCameraShot(0.452286, -0.179031, -0.812390, -0.321572, -50.015198, 15.394646, -114.879379);
	AddCameraShot(0.927563, -0.243751, 0.273918, 0.071982, 26.149965, 26.947924, -46.834148);
end
