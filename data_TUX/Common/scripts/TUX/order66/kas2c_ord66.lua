--uta1c_ord66.lua
-- Decompiled with SWBF2CodeHelper
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams")
REP = 1
JED = 2
ATT = 1
DEF = 2

function ScriptPostLoad()
    TDM = ObjectiveTDM:New({ teamATT = 1, teamDEF = 2, multiplayerScoreLimit = 75, textATT = "game.modes.tdm", textDEF = "game.modes.tdm2", multiplayerRules = true, isCelebrityDeathmatch = true })
    TDM:Start()
	
	AddDeathRegion("deathregion")
	AddDeathRegion("deathregion2")
	
    SetProperty("CP1CON","CaptureRegion","")
    SetProperty("CP3CON","CaptureRegion","")
    SetProperty("CP4CON","CaptureRegion","")
    SetProperty("CP5CON","CaptureRegion","")
    SetProperty("CP1CON","Team","3")
    SetProperty("CP3CON","Team","2")
    SetProperty("CP4CON","Team","1")
    SetProperty("CP5CON","Team","2")
	AddAIGoal(3, "Deathmatch", 1000, 0)
	
	--fix the jedi classes
	SetClassProperty("jed_knight_01", "FleeLikeAHero", 0)
	SetClassProperty("jed_knight_02", "FleeLikeAHero", 0)	
	SetClassProperty("jed_knight_03", "FleeLikeAHero", 0)
	SetClassProperty("jed_knight_04", "FleeLikeAHero", 0)
	SetClassProperty("jed_master_01", "FleeLikeAHero", 0)
	SetClassProperty("jed_master_02", "FleeLikeAHero", 0)	
	SetClassProperty("jed_master_03", "FleeLikeAHero", 0)
	SetClassProperty("jed_runner", "FleeLikeAHero", 0)
	
	SetClassProperty("jed_knight_01", "NoEnterVehicles", 0)
	SetClassProperty("jed_knight_02", "NoEnterVehicles", 0)	
	SetClassProperty("jed_knight_03", "NoEnterVehicles", 0)
	SetClassProperty("jed_knight_04", "NoEnterVehicles", 0)
	SetClassProperty("jed_master_01", "NoEnterVehicles", 0)
	SetClassProperty("jed_master_02", "NoEnterVehicles", 0)	
	SetClassProperty("jed_master_03", "NoEnterVehicles", 0)
	SetClassProperty("jed_runner", "NoEnterVehicles", 0)

	SetClassProperty("jed_knight_01", "AddHealth", 0.0)
	SetClassProperty("jed_knight_02", "AddHealth", 0.0)	
	SetClassProperty("jed_knight_03", "AddHealth", 0.0)
	SetClassProperty("jed_knight_04", "AddHealth", 0.0)
	SetClassProperty("jed_runner", "AddHealth", 0.0)
	
	SetClassProperty("rep_inf_ep3_rifleman", "GeometryName", "rep_inf_feluciatrooper")
	SetClassProperty("rep_inf_ep3_rifleman", "GeometryLowRes", "rep_inf_feluciatrooper_low1")
	
	--make the unlocks more fair
	SetClassProperty("jed_master_01", "PointsToUnlock", 12)
	SetClassProperty("jed_master_02", "PointsToUnlock", 12)	
	SetClassProperty("jed_master_03", "PointsToUnlock", 12)	
	SetClassProperty("rep_inf_ep3_commando", "PointsToUnlock", 0)	
	SetClassProperty("rep_inf_ep3_commando", "MaxHealth", 2200.0)
	SetClassProperty("rep_inf_ep3_commando", "FleeLikeAHero", 1)	

	-- Timer for skins--

	--interval is the number of seconds between model changes
	--maxskin is the number of versions to use

	interval = 10 --i had been testing this at 10 second waves, but it could be changed
	--in MP, it will probably cause each 15 second spawn-wave to be the same model
	skintimer = CreateTimer("timeout") -- i don't know what significance "timeout" has, copied from hoth campaign this way
	SetTimerValue(skintimer , interval )
	--ShowTimer(skintimer ) --uncomment this line to see the timer onscreen
	skin = 1
	maxskin = 2

	OnTimerElapse(
	function(timer)


	if (skin == 1) then
	SetClassProperty("rep_inf_ep3_rifleman", "GeometryName", "rep_inf_ep3trooper")
	SetClassProperty("rep_inf_ep3_rifleman", "GeometryLowRes", "rep_inf_ep3trooper_low1")
	end
	if (skin == 2) then
	SetClassProperty("rep_inf_ep3_rifleman", "GeometryName", "rep_inf_feluciatrooper")
	SetClassProperty("rep_inf_ep3_rifleman", "GeometryLowRes", "rep_inf_feluciatrooper_low1")
	end



	skin = skin + 1

	if (skin > maxskin) then
	skin = 1
	end

	--ShowTimer(nil)
	--DestroyTimer(timer)



	SetTimerValue(skintimer , interval )
	StartTimer(skintimer)


	end,
	skintimer
	)	
    --Gate Stuff -- 
    BlockPlanningGraphArcs("seawall1")
    BlockPlanningGraphArcs("woodl")
    BlockPlanningGraphArcs("woodc")
    BlockPlanningGraphArcs("woodr")
    DisableBarriers("disableme");
    
    SetProperty("woodl", "MaxHealth", 15000)
    SetProperty("woodl", "CurHealth", 15000)
    SetProperty("woodr", "MaxHealth", 15000)
    SetProperty("woodr", "CurHealth", 15000)
    SetProperty("woodc", "MaxHealth", 15000)
    SetProperty("woodc", "CurHealth", 15000)
    SetProperty("gatepanel", "MaxHealth", 1000)
    SetProperty("gatepanel", "CurHealth", 1000)
    
    
     OnObjectKillName(PlayAnimDown, "gatepanel");
     OnObjectRespawnName(PlayAnimUp, "gatepanel");
     OnObjectKillName(woodl, "woodl");
     OnObjectKillName(woodc, "woodc");
     OnObjectKillName(woodr, "woodr");
     OnObjectRespawnName(woodlr, "woodl");
     OnObjectRespawnName(woodcr, "woodc");
     OnObjectRespawnName(woodrr, "woodr");

	--start our skin timer
	StartTimer(skintimer) --starts the timer the first time, after it starts, it will restart itself one ending.
end

 function PlayAnimDown()
    PauseAnimation("thegateup");
    RewindAnimation("thegatedown");
    PlayAnimation("thegatedown");
    ShowMessageText("level.kas2.objectives.gateopen",1)
    ScriptCB_SndPlaySound("KAS_obj_13")
    SetProperty("gatepanel", "MaxHealth", 2200)
--    SetProperty("gatepanel", "CurHealth", 50000)
--    PlayAnimation("gatepanel");
    --SetProperty("gatepanel", "MaxHealth", 1e+37)
    --SetProperty("gatepanel", "CurHealth", 1e+37)
      
            
   -- Allowing AI to run under gate   
    UnblockPlanningGraphArcs("seawall1");
    DisableBarriers("seawalldoor1");
    DisableBarriers("vehicleblocker");
      
end

function PlayAnimUp()
    PauseAnimation("thegatedown");
    RewindAnimation("thegateup");
    PlayAnimation("thegateup");
      
            
   -- Allowing AI to run under gate   
    BlockPlanningGraphArcs("seawall1");
    EnableBarriers("seawalldoor1");
    EnableBarriers("vehicleblocker");
    SetProperty("gatepanel", "MaxHealth", 1000)
    SetProperty("gatepanel", "CurHealth", 1000)
      
end

function woodl()
    UnblockPlanningGraphArcs("woodl");
    DisableBarriers("woodl");
    SetProperty("woodl", "MaxHealth", 1800)
--    SetProperty("woodl", "CurHealth", 15)
end
    
function woodc()
    UnblockPlanningGraphArcs("woodc");
    DisableBarriers("woodc");
    SetProperty("woodc", "MaxHealth", 1800)
--    SetProperty("woodc", "CurHealth", 15)
end
    
function woodr()
    UnblockPlanningGraphArcs("woodr");
    DisableBarriers("woodr");
    SetProperty("woodr", "MaxHealth", 1800)
--    SetProperty("woodr", "CurHealth", 15)
end

function woodlr()
	BlockPlanningGraphArcs("woodl")
	EnableBarriers("woodl")
	SetProperty("woodl", "MaxHealth", 15000)
    SetProperty("woodl", "CurHealth", 15000)
end
	
function woodcr()
	BlockPlanningGraphArcs("woodc")
	EnableBarriers("woodc")
	SetProperty("woodc", "MaxHealth", 15000)
    SetProperty("woodc", "CurHealth", 15000)
end

function woodrr()
	BlockPlanningGraphArcs("woodr")
	EnableBarriers("woodr")
	SetProperty("woodr", "MaxHealth", 15000)
    SetProperty("woodr", "CurHealth", 15000)
end

function ScriptInit()
    StealArtistHeap(1228 * 1024)
    SetPS2ModelMemory(4380000)
    ReadDataFile("ingame.lvl")
    --[[SetMemoryPoolSize("ClothData",20)
    SetMemoryPoolSize("Combo",15)
    SetMemoryPoolSize("Combo::State",250)
    SetMemoryPoolSize("Combo::Transition",300)
    SetMemoryPoolSize("Combo::Condition",300)
    SetMemoryPoolSize("Combo::Attack",250)
    SetMemoryPoolSize("Combo::DamageSample",10000)
    SetMemoryPoolSize("Combo::Deflect",150)]]--
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",40)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",450)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",450) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",450)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",450)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",8000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",96)     -- should be ~1x #combo
	SetMemoryPoolSize ("SoldierAnimation",350)	
	
    ReadDataFile("sound\\kas.lvl;kas2cw")
    ReadDataFile("SIDE\\rep_256.lvl", "rep_inf_ep3_rifleman", "rep_inf_ep3_rocketeer","rep_inf_ep3_engineer","rep_inf_ep3_sniper_felucia","rep_inf_ep3_officer","rep_inf_ep3_jettrooper")
    --ReadDataFile("SIDE\\jed.lvl","jed_knight_01","jed_knight_02","jed_knight_03","jed_knight_04")
   -- ReadDataFile("SIDE\\infantry.lvl","jed_knight_10","jed_knight_13","jed_knight_14")
    ReadDataFile("SIDE\\rep_128.lvl", "rep_fly_cat_dome")
    ReadDataFile("SIDE\\rep_256.lvl", "rep_hero_yoda", "rep_hover_fightertank")
            
    ReadDataFile("SIDE\\jed.lvl",
        --"jed_knight_01",
        "jed_knight_02",
        "jed_knight_03",
        "jed_knight_04",
        --"jed_master_01",
        "jed_master_02",
        --"jed_master_03",
        "jed_runner")

    ReadDataFile("SIDE\\wok.lvl",
                             "wok_inf_basic")	

	ReadDataFile("SIDE\\commando.lvl", "rep_inf_ep3_commando")
	
	ReadDataFile("SIDE\\tur.lvl",
							"tur_bldg_beam",
							"tur_bldg_recoilless_kas")
	
	ReadDataFile("SIDE\\cis_128.lvl", "cis_inf_marine")
	
    SetupTeams({ 
        rep =         { team = REP, units = 24, reinforcements = -1, 
          soldier =           { "rep_inf_ep3_rifleman", 13, 16 }, 
          assault =           { "rep_inf_ep3_rocketeer", 5, 4 }, 
          engineer =           { "rep_inf_ep3_engineer", 3, 4 }, 
          sniper =           { "rep_inf_ep3_sniper_felucia", 2, 4 }, 
          officer =           { "rep_inf_ep3_officer", 2, 4 }, 
          special =           { "rep_inf_ep3_jettrooper", 2, 4 }
         }, 
        JED =         { team = JED, units = 14, reinforcements = -1, 
          soldier =           { "jed_knight_02", 2, 5 }, 
          assault =           { "wok_inf_warrior", 2, 4 }, 
          engineer =           { "wok_inf_mechanic", 1, 4 }, 
          sniper =           { "jed_knight_03", 2, 5 }, 
          officer =           { "jed_knight_04", 1, 1 }, 
          special =           { "jed_master_02", 1, 1 }
         }
       })
	SetHeroClass(JED, "rep_hero_yoda")
	--SetHeroClass(REP, "rep_hero_cloakedanakin")
	SetHeroClass(REP, "rep_inf_ep3_commando")
	SetTeamName(JED, "Jedi")
    ClearWalkers()
    SetMemoryPoolSize("Aimer",5)
    SetMemoryPoolSize("AmmoCounter",150)
    SetMemoryPoolSize("BaseHint",200)
    SetMemoryPoolSize("EnergyBar",150)
	SetMemoryPoolSize("EntityHover", 4)
    SetMemoryPoolSize("EntityLight",80)
    SetMemoryPoolSize("EntityFlyer",4)
    SetMemoryPoolSize("EntitySoundStream",8)
    SetMemoryPoolSize("EntitySoundStatic",27)
    SetMemoryPoolSize("MountedTurret", 12)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 300)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("PathNode", 512)
    SetMemoryPoolSize("TentacleSimulator", 14)
    SetMemoryPoolSize("TreeGridStack", 300)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon",150)
    SetMemoryPoolSize("SoldierAnimation",500)
    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("KAS\\kas2.lvl", "kas2_con")
    SetDenseEnvironment("false")
    
    SetMaxFlyHeight(65)
    SetMaxPlayerFlyHeight(65)

    --  Birdies
    SetNumBirdTypes(1)
    SetBirdType(0,1.0,"bird")

    --  Fishies
    SetNumFishTypes(1)
    SetFishType(0,0.8,"fish")

    --  Local Stats
    SetTeamName(3, "CIS")
    SetTeamIcon(3, "cis_icon")
    AddUnitClass(3, "cis_inf_marine", 6)
    SetUnitCount(3, 6)
    SetTeamAsEnemy(3,DEF)
    SetTeamAsEnemy(3,ATT)
	SetTeamAsEnemy(ATT,3)
    SetTeamAsEnemy(DEF,3)

    --  Sound
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "all_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "wok_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "all_unit_vo_quick", voiceQuick)   
    AudioStreamAppendSegments("sound\\global.lvl", "wok_unit_vo_quick", voiceQuick) 

    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\kas.lvl",  "kas")
    OpenAudioStream("sound\\kas.lvl",  "kas")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, JED, "rep_off_com_report_enemy_losing",   1)
    --SetBleedingVoiceOver(JED, REP, "cis_off_com_report_enemy_losing",   1)
    --SetBleedingVoiceOver(JED, JED, "cis_off_com_report_us_overwhelmed", 1)

    SetAmbientMusic(REP, 1.0, "rep_kas_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_kas_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_kas_amb_end",    2,1)
    SetAmbientMusic(JED, 1.0, "cis_kas_amb_start",  0,1)
    SetAmbientMusic(JED, 0.8, "cis_kas_amb_middle", 1,1)
    SetAmbientMusic(JED, 0.2,"cis_kas_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_kas_amb_victory")
    SetDefeatMusic (REP, "rep_kas_amb_defeat")
    SetVictoryMusic(JED, "cis_kas_amb_victory")
    SetDefeatMusic (JED, "cis_kas_amb_defeat")

    SetOutOfBoundsVoiceOver(REP, "repleaving")
    SetOutOfBoundsVoiceOver(JED, "repleaving")

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


    --Kas2 Docks
    --Wide beach shot
	AddCameraShot(0.977642, -0.052163, -0.203414, -0.010853, 66.539520, 21.864969, 168.598495);
	AddCameraShot(0.969455, -0.011915, 0.244960, 0.003011, 219.552948, 21.864969, 177.675674);
	AddCameraShot(0.995040, -0.013447, 0.098558, 0.001332, 133.571289, 16.216759, 121.571236);
	AddCameraShot(0.350433, -0.049725, -0.925991, -0.131394, 30.085188, 32.105236, -105.325264);



-- GOOD SHOTS -- 
	-- Gate to Right


--Kinda Cool -- 
	
    AddCameraShot(0.163369, -0.029669, -0.970249, -0.176203, 85.474831, 47.313362, -156.345627);
	AddCameraShot(0.091112, -0.011521, -0.987907, -0.124920, 97.554062, 53.690968, -179.347076);
	AddCameraShot(0.964953, -0.059962, 0.254988, 0.015845, 246.471008, 20.362143, 153.701050);  
end

