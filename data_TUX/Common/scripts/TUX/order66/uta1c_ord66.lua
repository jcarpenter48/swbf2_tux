--uta1c_ord66.lua
-- Decompiled with SWBF2CodeHelper
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams")
REP = 2
JED = 1
ATT = 1
DEF = 2

function ScriptPostLoad()
    TDM = ObjectiveTDM:New({ teamATT = 1, teamDEF = 2, multiplayerScoreLimit = 75, textATT = "game.modes.tdm", textDEF = "game.modes.tdm2", multiplayerRules = true, isCelebrityDeathmatch = true })
    TDM:Start()
    DisableBarriers("Barrier445")
--[[
    SetProperty("cp1","CaptureRegion","")
    SetProperty("cp2","CaptureRegion","")
    SetProperty("cp3","CaptureRegion","")
    SetProperty("cp4","CaptureRegion","")
    SetProperty("cp5","CaptureRegion","")
    SetProperty("cp6","CaptureRegion","")
    SetProperty("cp1","Team","1")
    SetProperty("cp2","Team","2")
    SetProperty("cp3","Team","1")
    SetProperty("cp4","Team","2")
    SetProperty("cp5","Team","2")
    SetProperty("cp6","Team","1")]]--
	
    SetProperty("CON_CP1","CaptureRegion","")
    SetProperty("con_CP1a","CaptureRegion","")
    SetProperty("CON_CP2","CaptureRegion","")
    SetProperty("CON_CP5","CaptureRegion","")
    SetProperty("CON_CP6","CaptureRegion","")
    SetProperty("CON_CP7","CaptureRegion","")
    SetProperty("CON_CP1","Team","2")
    SetProperty("con_CP1a","Team","1")
    SetProperty("CON_CP2","Team","2")
    SetProperty("CON_CP5","Team","1")
    SetProperty("CON_CP6","Team","3")
    SetProperty("CON_CP7","Team","3")
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
	
	--make the unlocks more fair
	SetClassProperty("jed_master_01", "PointsToUnlock", 12)
	SetClassProperty("jed_master_02", "PointsToUnlock", 12)	
	SetClassProperty("jed_master_03", "PointsToUnlock", 12)	
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
	
    ReadDataFile("sound\\uta.lvl;uta1cw")
    ReadDataFile("SIDE\\rep_256.lvl","rep_inf_ep3_rifleman","rep_inf_ep3_rocketeer","rep_inf_ep3_engineer","rep_inf_ep3_sniper","rep_inf_ep3_officer","rep_inf_ep3_jettrooper")
    --ReadDataFile("SIDE\\jed.lvl","jed_knight_01","jed_knight_02","jed_knight_03","jed_knight_04")
   -- ReadDataFile("SIDE\\infantry.lvl","jed_knight_10","jed_knight_13","jed_knight_14")
    --ReadDataFile("SIDE\\rep_128.lvl", "rep_hero_cloakedanakin") --dependency for some jedi
    ReadDataFile("SIDE\\rep_256.lvl", "rep_hero_obiwan", "rep_walk_oneman_atst")              
    ReadDataFile("SIDE\\jed.lvl",
        "jed_knight_01",
        "jed_knight_02",
        "jed_knight_03",
        "jed_knight_04",
        --"jed_master_01",
        "jed_master_02",
        --"jed_master_03",
        "jed_runner")

	ReadDataFile("SIDE\\cmdrcody.lvl", "rep_hero_cmdrcody")   
					
	if( ScriptCB_IsFileExist("no212utapau.txt") ~= 1 ) then    
        ReadDataFile("side\\212skin.lvl",
                "212skin")    --load 327th skins to override existing Ep3 trooper appearances
    end   	
	
	ReadDataFile("SIDE\\cis_128.lvl", "cis_inf_marine")		
	
    SetupTeams({ 
        rep =         { team = REP, units = 24, reinforcements = -1, 
          soldier =           { "rep_inf_ep3_rifleman", 13, 16 }, 
          assault =           { "rep_inf_ep3_rocketeer", 5, 4 }, 
          engineer =           { "rep_inf_ep3_engineer", 3, 4 }, 
          sniper =           { "rep_inf_ep3_sniper", 2, 4 }, 
          officer =           { "rep_inf_ep3_officer", 2, 4 }, 
          special =           { "rep_inf_ep3_jettrooper", 2, 4 }
         }, 
        JED =         { team = JED, units = 14, reinforcements = -1, 
          soldier =           { "jed_knight_01", 4, 6 }, 
          assault =           { "jed_knight_02", 4, 6 }, 
          engineer =           { "jed_knight_03", 3, 6 }, 
          sniper =           { "jed_knight_04", 2, 6 }, 
          officer =           { "jed_runner", 1, 1 }, 
          special =           { "jed_master_02", 1, 1 }
         }
       })
	SetHeroClass(JED, "rep_hero_obiwan")
	--SetHeroClass(REP, "rep_hero_cloakedanakin")
	SetHeroClass(REP, "rep_hero_cmdrcody")
	SetTeamName(JED, "Jedi")
    ClearWalkers()
	AddWalkerType(1, 2) -- ATRTa (special case: 0 leg pairs)
    SetMemoryPoolSize("Aimer",5)
    SetMemoryPoolSize("AmmoCounter",150)
    SetMemoryPoolSize("BaseHint",200)
    SetMemoryPoolSize("EnergyBar",150)
    SetMemoryPoolSize("EntityLight",80)
	--SetMemoryPoolSize("EntityHover",1)
    SetMemoryPoolSize("EntityFlyer",4)
    SetMemoryPoolSize("EntitySoundStream",8)
    SetMemoryPoolSize("EntitySoundStatic",27)
    SetMemoryPoolSize("MountedTurret",0)
    SetMemoryPoolSize("Navigator",40)
    SetMemoryPoolSize("Obstacle",400)
    SetMemoryPoolSize("PathFollower",40)
    SetMemoryPoolSize("PathNode",100)
    SetMemoryPoolSize("TreeGridStack",256)
    SetMemoryPoolSize("UnitAgent",40)
    SetMemoryPoolSize("UnitController",40)
    SetMemoryPoolSize("Weapon",150)
    SetMemoryPoolSize("SoldierAnimation",500)
    SetSpawnDelay(10,0.25)
    ReadDataFile("uta\\uta1.lvl","uta1_Conquest")
    SetDenseEnvironment("false")
    AddDeathRegion("deathregion")
    SetMaxFlyHeight(29.5)
    SetMaxPlayerFlyHeight(29.5)

    --  Local Stats
    SetTeamName(3, "CIS")
    SetTeamIcon(3, "cis_icon")
    AddUnitClass(3, "cis_inf_marine", 6)
    SetUnitCount(3, 6)
    SetTeamAsEnemy(3,DEF)
    SetTeamAsEnemy(3,ATT)
	SetTeamAsEnemy(ATT,3)
    SetTeamAsEnemy(DEF,3)
	
    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "all_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "all_unit_vo_quick", voiceQuick)   

    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\uta.lvl",  "uta1")
    OpenAudioStream("sound\\uta.lvl",  "uta1")
    -- OpenAudioStream("sound\\cor.lvl",  "cor1_emt")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, JED, "rep_off_com_report_enemy_losing",   1)
    --SetBleedingVoiceOver(JED, REP, "cis_off_com_report_enemy_losing",   1)
    --SetBleedingVoiceOver(JED, JED, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, JED, "rep_off_victory_im", .1, 1)
    --SetLowReinforcementsVoiceOver(JED, JED, "cis_off_defeat_im", .1, 1)
    --SetLowReinforcementsVoiceOver(JED, REP, "cis_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(REP, "Repleaving")
    SetOutOfBoundsVoiceOver(JED, "Repleaving")

    SetAmbientMusic(REP, 1.0, "rep_uta_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_uta_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2, "rep_uta_amb_end",    2,1)
    SetAmbientMusic(JED, 1.0, "cis_uta_amb_start",  0,1)
    SetAmbientMusic(JED, 0.8, "cis_uta_amb_middle", 1,1)
    SetAmbientMusic(JED, 0.2, "cis_uta_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_uta_amb_victory")
    SetDefeatMusic (REP, "rep_uta_amb_defeat")
    SetVictoryMusic(JED, "cis_uta_amb_victory")
    SetDefeatMusic (JED, "cis_uta_amb_defeat")
	
    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")
--  Camera Stats - Utapau: Sinkhole
	AddCameraShot(-0.428091, 0.045649, -0.897494, -0.095703, 162.714951, 45.857063, 40.647118)
	AddCameraShot(-0.194861, -0.001600, -0.980796, 0.008055, -126.179787, 16.113789, 70.012894);
	AddCameraShot(-0.462548, -0.020922, -0.885442, 0.040050, -16.947638, 4.561796, 156.926956);
	AddCameraShot(0.995310, 0.024582, -0.093535, 0.002310, 38.288612, 4.561796, 243.298508);
	AddCameraShot(0.827070, 0.017093, 0.561719, -0.011609, -24.457638, 8.834146, 296.544586);
	AddCameraShot(0.998875, 0.004912, -0.047174, 0.000232, -45.868237, 2.978215, 216.217880);
end

