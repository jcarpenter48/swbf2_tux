--myg1c_mcm.lua
-- PSP Mission Script; 'Rogue Assassin' Mygeeto level
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
         DisableBarriers("corebar1");
         DisableBarriers("corebar2");
         DisableBarriers("corebar3");
         DisableBarriers("shield_01");
         DisableBarriers("shield_02");
         DisableBarriers("shield_03");
         DisableBarriers("corebar4");
         DisableBarriers("dropship")
         DisableBarriers("coresh1")
         
         
         -- Setting up Shield functionality --


    OnObjectRespawnName(Revived, "generator_01");
    OnObjectKillName(ShieldDied, "force_shield_01");
    OnObjectKillName(ShieldDied, "generator_01");
    

    OnObjectRespawnName(Revived, "generator_02");
    OnObjectKillName(ShieldDied, "force_shield_02");
    OnObjectKillName(ShieldDied, "generator_02");
    
    OnObjectRespawnName(Revived, "generator_03");
    OnObjectKillName(ShieldDied, "force_shield_03");
    OnObjectKillName(ShieldDied, "generator_03");
	
	
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

    DisableBarriers("dropship")
    DisableBarriers("shield_03")
    DisableBarriers("shield_02")
    DisableBarriers("shield_01")
    DisableBarriers("ctf")
    DisableBarriers("ctf1")
    DisableBarriers("ctf2")
    DisableBarriers("ctf3")
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
            Ambush("CP4_CTFSPAWN", 3, 3)
            AddAIGoal(3, "Deathmatch", 9999)
            AddAIGoal(2, "Deathmatch", 1)
            followguy1 = GetTeamMember(3, 0)
            followthatguy1 = AddAIGoal(2, "Follow", 3, followguy1)
            followguy2 = GetTeamMember(3, 1)
            followthatguy2 = AddAIGoal(2, "Follow", 3, followguy2)
            followguy3 = GetTeamMember(3, 2)
            followthatguy3 = AddAIGoal(2, "Follow", 3, followguy3)
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
	
	--get rid of ctf stuff
	KillObject("ctfbase1")
	SetProperty("ctfbase1", "CurHealth", 0)
	SetProperty("ctfbase1", "IsVisible", 0)
	SetProperty("ctfbase1", "IsCollidable ", 0)
	SetProperty("ctfbase1", "PhysicsActive", 0)
	KillObject("ctfbase2")
	SetProperty("ctfbase2", "CurHealth", 0)
	SetProperty("ctfbase2", "IsVisible", 0)
	SetProperty("ctfbase2", "IsCollidable ", 0)
	SetProperty("ctfbase2", "PhysicsActive", 0)	
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
	
--hide posts
	MapHideCommandPosts(true)
	SetProperty("CP1_CTF", "MapTexture", " ")
	SetProperty("CP1_CTF", "MapScale", 0.0)
	SetProperty("CP2_CTF", "MapTexture", " ")
	SetProperty("CP2_CTF", "MapScale", 0.0)
	SetProperty("CP3_CTF", "MapTexture", " ")
	SetProperty("CP3_CTF", "MapScale", 0.0)
	SetProperty("CP4_CTF", "MapTexture", " ")
	SetProperty("CP4_CTF", "MapScale", 0.0)	
end

--Start Shield Work

function Init(numberStr)
   
     shieldName = "force_shield_" .. numberStr;
     genName = "generator_" .. numberStr;
     upAnim = "shield_up_" .. numberStr;
     downAnim = "shield_down_" .. numberStr;
     
     PlayShieldUp(shieldName, genName, upAnim, downAnim);
     
     BlockPlanningGraphArcs("shield_" .. numberStr);
     EnableBarriers("shield_" .. numberStr);
   
end

function ShieldDied(actor)
     fullName = GetEntityName(actor);
     numberStr = string.sub(fullName, -2, -1);
     
     shieldName = "force_shield_" .. numberStr;
     genName = "generator_" .. numberStr;
     upAnim = "shield_up_" .. numberStr;
     downAnim = "shield_down_" .. numberStr;
     
     PlayShieldDown(shieldName, genName, upAnim, downAnim);
     
     UnblockPlanningGraphArcs("shield_" .. numberStr);
     DisableBarriers("shield_" .. numberStr);

end

function Revived(actor)

     fullName = GetEntityName(actor);
     numberStr = string.sub(fullName, -2, -1);
     
     shieldName = "force_shield_" .. numberStr;
     genName = "generator_" .. numberStr;
     upAnim = "shield_up_" .. numberStr;
     downAnim = "shield_down_" .. numberStr;
     
     PlayShieldUp(shieldName, genName, upAnim, downAnim);
     BlockPlanningGraphArcs("shield_" .. numberStr);
     EnableBarriers("shield_" .. numberStr);
end

-- Drop Shield
function PlayShieldDown(shieldObj, genObj, upAnim, downAnim)
      RespawnObject(shieldObj);
      KillObject(genObj);
      PauseAnimation(upAnim);
      RewindAnimation(downAnim);
      PlayAnimation(downAnim);
    
end
-- Put Shield Backup
function PlayShieldUp(shieldObj, genObj, upAnim, downAnim)
      RespawnObject(shieldObj);
      RespawnObject(genObj);
      PauseAnimation(downAnim);
      RewindAnimation(upAnim);
      PlayAnimation(upAnim);
end
 
 
function ScriptInit()
    StealArtistHeap(135 * 1024)
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(2978689)
        SetPSPClipper(0)
    else
        SetPS2ModelMemory(4880000)
    end
    ReadDataFile("ingame.lvl")
    ReadDataFile("sound\\myg.lvl;myg1gcw")
    SetMaxFlyHeight(22)
    SetMaxPlayerFlyHeight(22)
    ReadDataFile("SIDE\\rep.lvl", "rep_inf_ep2_jettrooper_rifleman")
    ReadDataFile(
        "SIDE\\imp.lvl",
        "imp_inf_rifleman",
        "imp_inf_sniper",
        "imp_inf_dark_trooper",
        "imp_inf_officer"
        --"imp_hero_bobafett"
    )
    ReadDataFile("SIDE\\tur.lvl", "tur_bldg_recoilless_lg")
	ReadDataFile("SIDE\\mcm_fixes.lvl", "mcm_fixes")
	ReadDataFile("SIDE\\imp_128.lvl", "imp_hero_bobafett")
	ReadDataFile("SIDE\\imp.lvl", "imp_hero_bobafett") --for higher res textures
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
	
	ReadDataFile("myg\\myg1.lvl", "myg1_ctf")
    --ReadDataFile("myg\\myg1mcm.lvl", "myg1_merc")
	--ReadDataFile("myg\\myg1dlc.lvl", "myg1_eli")
	
    SetDenseEnvironment("false")
    AddDeathRegion("deathregion")
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
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\myg.lvl",  "myg1")
    OpenAudioStream("sound\\myg.lvl",  "myg1")
    -- OpenAudioStream("sound\\cor.lvl",  "cor1_emt")

    -- SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    -- SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    -- SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    -- SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

    SetOutOfBoundsVoiceOver(REP, "Repleaving")
    SetOutOfBoundsVoiceOver(IMP, "Impleaving")

    SetAmbientMusic(REP, 1.0, "all_myg_amb_start",  0,1)
    SetAmbientMusic(REP, 0.9, "all_myg_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.1, "all_myg_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_myg_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.9, "imp_myg_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.1, "imp_myg_amb_end",    2,1)

    SetVictoryMusic(REP, "all_myg_amb_victory")
    SetDefeatMusic (REP, "all_myg_amb_defeat")
    SetVictoryMusic(IMP, "imp_myg_amb_victory")
    SetDefeatMusic (IMP, "imp_myg_amb_defeat")

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
