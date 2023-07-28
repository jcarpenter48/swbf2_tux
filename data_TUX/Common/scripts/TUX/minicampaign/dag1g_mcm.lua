-- dag1g_mcm.lua
-- PSP Mission Script; 'Rogue Assassin' Dagobah level
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveAssault")
ScriptCB_DoFile("MultiObjectiveContainer")
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("Ambush")
REP = 1
IMP = 2
locals = 3
ATT = 1
DEF = 2

function ScriptPostLoad()
--hide posts
	MapHideCommandPosts(true)
	SetProperty("ctf_cp1", "MapTexture", " ")
	SetProperty("ctf_cp1", "MapScale", 0.0)
	SetProperty("ctf_cp2", "MapTexture", " ")
	SetProperty("ctf_cp2", "MapScale", 0.0)
	SetProperty("ctf_cp3", "MapTexture", " ")
	SetProperty("ctf_cp3", "MapScale", 0.0)
	SetProperty("ctf_cp4", "MapTexture", " ")
	SetProperty("ctf_cp4", "MapScale", 0.0)
	
    EnableSPHeroRules()
    missiontimer = CreateTimer("missiontimer")
    SetTimerValue(missiontimer, 300)
    StartTimer(missiontimer)
    ShowTimer(missiontimer)
    OnTimerElapse(
        function()
            MissionVictory(DEF)
        end,
        "missiontimer"
    )

    fourminremains = CreateTimer("fourminremains")
    SetTimerValue(fourminremains, 60)
    threeminremains = CreateTimer("threeminremains")
    SetTimerValue(threeminremains, 120)
    twominremains = CreateTimer("twominremains")
    SetTimerValue(twominremains, 180)
    oneminremains = CreateTimer("oneminremains")
    SetTimerValue(oneminremains, 240)
    thirtysecremains = CreateTimer("thirtysecremains")
    SetTimerValue(thirtysecremains, 270)
    tensecremains = CreateTimer("tensecremains")
    SetTimerValue(tensecremains, 290)
    StartTimer(fourminremains)
    StartTimer(threeminremains)
    StartTimer(twominremains)
    StartTimer(oneminremains)
    StartTimer(thirtysecremains)
    StartTimer(tensecremains)
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
    AAT_count = 3
    AAT = TargetType:New({classname = "imp_inf_officer", killLimit = 3})

    AAT.OnDestroy = function(self, objectPtr)
        AAT_count = AAT_count - 1
        ShowMessageText("level.dag1g_m.merc.2-" .. AAT_count, ATT)
    end

    Objective2 =
        ObjectiveAssault:New(
        {
            teamATT = ATT,
            teamDEF = DEF,
            AIGoalWeight = 1,
            textATT = "level.dag1g_m.merc.end",
            popupText = "level.dag1g_m.merc.popup"
        }
    )

    Objective2:AddTarget(AAT)
    Objective2.OnComplete = function(param0)
        MissionVictory(ATT)
    end
    TDM = ObjectiveTDM:New({teamATT = 1, teamDEF = 2, textATT = "level.dag1g_m.merc.merc1", multiplayerRules = true})
    missiontimer2 = CreateTimer("missiontimer2")
    SetTimerValue(missiontimer2, 1)
    StartTimer(missiontimer2)
    OnTimerElapse(
        function()
		    --Ambush("off_path", 3, 3)
            Ambush("ctf_cp3_spawn", 3, 3)
            AddAIGoal(locals, "Deathmatch", 9999)
            followguy1 = GetTeamMember(3, 0)
            AddAIGoal(followguy1, "defend", 100, x1)
            followthatguy1 = AddAIGoal(2, "defend", 100, followguy1)
            followguy2 = GetTeamMember(3, 1)
            AddAIGoal(followguy2, "defend", 100, x2)
            followthatguy2 = AddAIGoal(2, "defend", 100, followguy2)
            followguy3 = GetTeamMember(3, 2)
            AddAIGoal(followguy3, "defend", 100, x3)
            followthatguy3 = AddAIGoal(2, "defend", 100, followguy3)
            SetAIDifficulty(2, 3, "medium")
            SetAIDifficulty(3, 3, "medium")
        end,
        "missiontimer2"
    )
    objectiveSequence = MultiObjectiveContainer:New({})
    objectiveSequence:AddObjectiveSet(Objective2)
    objectiveSequence:AddObjectiveSet(TDM)
    objectiveSequence:Start()
	
	--fix our rogue assassin
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "PointsToUnlock", "0")
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "WeaponName1", "rep_weap_inf_rifle_padme")
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "WeaponName2", "imp_weap_inf_commando_pistol")
	--SetClassProperty("imp_hero_bobafett", "WeaponName1", "rep_weap_inf_rifle_padme")
	--[[
	SetClassProperty("imp_hero_bobafett", "WeaponName1", "imp_weap_inf_rifle")
	--SetClassProperty("imp_hero_bobafett", "WeaponName1", "imp_weap_award_rifle")
	SetClassProperty("imp_hero_bobafett", "WeaponAmmo1", 5)
	SetClassProperty("imp_hero_bobafett", "WeaponName5", "imp_weap_award_rifle")
	SetClassProperty("imp_hero_bobafett", "WeaponAmmo5", 5)	]]--
	
	--get rid of ctf stuff
	KillObject("ctf_flag1")
	SetProperty("ctf_flag1", "CurHealth", 0)
	SetProperty("ctf_flag1", "IsVisible", 0)
	SetProperty("ctf_flag1", "IsCollidable ", 0)
	SetProperty("ctf_flag1", "PhysicsActive", 0)
	KillObject("ctf_flag2")
	SetProperty("ctf_flag2", "CurHealth", 0)
	SetProperty("ctf_flag2", "IsVisible", 0)
	SetProperty("ctf_flag2", "IsCollidable ", 0)
	SetProperty("ctf_flag2", "PhysicsActive", 0)
	KillObject("flag1_effect")
	SetProperty("flag1_effect", "CurHealth", 0)
	SetProperty("flag1_effect", "IsVisible", 0)
	SetProperty("flag1_effect", "IsCollidable ", 0)
	SetProperty("flag1_effect", "PhysicsActive", 0)
	KillObject("flag2_effect")
	SetProperty("flag2_effect", "CurHealth", 0)
	SetProperty("flag2_effect", "IsVisible", 0)
	SetProperty("flag2_effect", "IsCollidable ", 0)
	SetProperty("flag2_effect", "PhysicsActive", 0)	
end

function ScriptInit()
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(1616077)
        SetPSPClipper(0)
    else
        SetPS2ModelMemory(2497152 + 65536 * 0)
    end
    ReadDataFile("ingame.lvl")
    ReadDataFile("sound\\dag.lvl;dag1gcw")
    SetMaxFlyHeight(20)
    SetMaxPlayerFlyHeight(20)
	ReadDataFile("SIDE\\mcm_fixes.lvl", "mcm_fixes")
    ReadDataFile("SIDE\\rep.lvl", "rep_inf_ep2_jettrooper_rifleman")
    ReadDataFile(
        "SIDE\\imp.lvl",
        "imp_inf_rifleman",
        "imp_inf_sniper",
        "imp_inf_dark_trooper",
        "imp_inf_officer"
        --"imp_hero_bobafett"
    )
	ReadDataFile("SIDE\\imp_128.lvl", "imp_hero_bobafett")
	ReadDataFile("SIDE\\imp.lvl", "imp_hero_bobafett") --for higher res textures	
    ClearWalkers()
    AddWalkerType(0, 4)
    SetMemoryPoolSize("EntityHover", 0)
    SetMemoryPoolSize("EntityFlyer", 0)
    SetMemoryPoolSize("EntityDroid", 10)
    SetMemoryPoolSize("EntityCarrier", 0)
    SetMemoryPoolSize("Obstacle", 118)
    SetMemoryPoolSize("Weapon", 260)
    SetTeamName(REP, "Republic")
    SetTeamIcon(REP, "rep_icon")
    AddUnitClass(REP, "rep_inf_ep2_jettrooper_rifleman", 1)
    SetHeroClass(REP, "imp_hero_bobafett")
    SetTeamName(IMP, "IMP")
    SetTeamIcon(IMP, "IMP_icon")
    AddUnitClass(IMP, "imp_inf_rifleman", 6)
    AddUnitClass(IMP, "imp_inf_sniper", 3)
    AddUnitClass(IMP, "imp_inf_dark_trooper", 3)
    SetUnitCount(ATT, 4)
    SetReinforcementCount(ATT, -1)
    SetUnitCount(DEF, 12)
    SetReinforcementCount(DEF, -1)
    ForceHumansOntoTeam1()
    SetTeamName(locals, "IMP")
    AddUnitClass(locals, "imp_inf_officer", 3)
    SetUnitCount(locals, 10)
    SetTeamAsFriend(locals, IMP)
    SetTeamAsFriend(IMP, locals)
    SetTeamAsEnemy(locals, REP)
    SetTeamAsEnemy(REP, locals)
    SetReinforcementCount(locals, 3)
    SetSpawnDelay(10, 0.25)
	
	ReadDataFile("dag\\dag1.lvl", "dag1_ctf")
    --ReadDataFile("dag\\dag1mcm.lvl", "dag1_merc")
	--ReadDataFile("dag\\dag1.lvl", "dag1_1flag")
	
    SetDenseEnvironment("false")
    SetAIViewMultiplier(0.34999999403954)
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\dag.lvl",  "dag1")
    OpenAudioStream("sound\\dag.lvl",  "dag1")
    -- OpenAudioStream("sound\\cor.lvl",  "cor1_emt")

    -- SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    -- SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    -- SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    -- SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

    SetOutOfBoundsVoiceOver(REP, "Repleaving")
    SetOutOfBoundsVoiceOver(IMP, "Impleaving")

    SetAmbientMusic(REP, 1.0, "all_dag_amb_start",  0,1)
    SetAmbientMusic(REP, 0.9, "all_dag_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.1, "all_dag_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_dag_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.9, "imp_dag_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.1, "imp_dag_amb_end",    2,1)

    SetVictoryMusic(REP, "all_dag_amb_victory")
    SetDefeatMusic (REP, "all_dag_amb_defeat")
    SetVictoryMusic(IMP, "imp_dag_amb_victory")
    SetDefeatMusic (IMP, "imp_dag_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")
    --  Camera Stats
    AddCameraShot(0.953415, -0.062787, 0.294418, 0.019389, 20.468771, 3.780040, -110.412453);
    AddCameraShot(0.646125, -0.080365, 0.753185, 0.093682, 41.348438, 5.688061, -52.695042);
    AddCameraShot(-0.442911, 0.055229, -0.887986, -0.110728, 39.894440, 9.234127, -59.177147);
    AddCameraShot(-0.038618, 0.006041, -0.987228, -0.154444, 28.671711, 10.001163, 128.892181);
	
	--ScriptCB_QuitToShell()
	--quit to shell
end