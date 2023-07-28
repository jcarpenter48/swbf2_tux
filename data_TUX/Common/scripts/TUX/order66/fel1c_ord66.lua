--fel1c_ord66.lua
-- Decompiled with SWBF2CodeHelper
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams")
REP = 1
JED = 2
ATT = 1
DEF = 2

function ScriptPostLoad()
--skin stuff
if( ScriptCB_IsFileExist("no327endor.txt") ~= 1 ) then
    SetClassProperty("rep_inf_ep3_rifleman", "GeometryName", "rep_inf_ep3trooper327")
    SetClassProperty("rep_inf_ep3_rifleman", "ClothODF", "rep_inf_ep3sniper_cape")
    SetClassProperty("rep_inf_ep3_rifleman", "AnimatedAddon", "pauldron")
    SetClassProperty("rep_inf_ep3_rifleman", "GeometryAddon", "rep_inf_pauldron_addon") 
    SetClassProperty("rep_inf_ep3_rifleman", "AddonAttachJoint", "bone_ribcage") 
    --Change the Clone Commander's appearance for the 327th
    SetClassProperty("rep_inf_ep3_officer", "GeometryName", "rep_inf_ep3trooper327")
    SetClassProperty("rep_inf_ep3_officer", "OverrideTexture", "rep_inf_ep3jettrooper") --salient bit
    SetClassProperty("rep_inf_ep3_officer", "ClothODF", "rep_inf_ep3sniper_cape")
    SetClassProperty("rep_inf_ep3_officer", "AnimatedAddon", "pauldron")
    SetClassProperty("rep_inf_ep3_officer", "GeometryAddon", "rep_inf_pauldron_addon") 
    SetClassProperty("rep_inf_ep3_officer", "AddonAttachJoint", "bone_ribcage")   
end --allow option to switch 327th off, mainly if there is a future TC that breaks this. 
--just place a file named no327endor.txt (doesn't have to actually contain anything, just named that) to disable 327th
  
    SetProperty("cp1-1","CaptureRegion","")
    SetProperty("cp2-1","CaptureRegion","")
    SetProperty("cp3-1","CaptureRegion","")
    SetProperty("cp4-1","CaptureRegion","")
    SetProperty("cp5-1","CaptureRegion","")
    SetProperty("cp6-1","CaptureRegion","")
    SetProperty("cp1-1","Team","1")
    SetProperty("cp2-1","Team","2")
    SetProperty("cp3-1","Team","2")
    SetProperty("cp4-1","Team","1")
    SetProperty("cp5-1","Team","3")
    SetProperty("cp6-1","Team","3")
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
	SetClassProperty("rep_inf_ep3_commando", "PointsToUnlock", 0)	
	SetClassProperty("rep_inf_ep3_commando", "MaxHealth", 2200.0)
	SetClassProperty("rep_inf_ep3_commando", "FleeLikeAHero", 1)
	
    TDM = ObjectiveTDM:New({ teamATT = 1, teamDEF = 2, multiplayerScoreLimit = 75, textATT = "game.modes.tdm", textDEF = "game.modes.tdm2", multiplayerRules = true, isCelebrityDeathmatch = true })
    TDM:Start()
	
	EnableSPHeroRules()	
end

function ScriptInit()
    SetPS2ModelMemory(4056000)
    ReadDataFile("ingame.lvl")
    SetMaxFlyHeight(53)
    SetMaxPlayerFlyHeight(53)
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
	
    ReadDataFile("sound\\fel.lvl;fel1cw")
    ReadDataFile("SIDE\\rep_256.lvl","rep_inf_ep3_rifleman","rep_inf_ep3_rocketeer","rep_inf_ep3_engineer","rep_inf_ep3_sniper","rep_inf_ep3_officer","rep_inf_ep3_jettrooper")
	
    --ReadDataFile("SIDE\\jed.lvl","jed_knight_01","jed_knight_02","jed_knight_03","jed_knight_04")
   -- ReadDataFile("SIDE\\infantry.lvl","jed_knight_10","jed_knight_13","jed_knight_14")
    --ReadDataFile("SIDE\\rep_128.lvl", "rep_hero_cloakedanakin") --dependency for some jedi
    ReadDataFile("SIDE\\rep_256.lvl", "rep_hero_aalya", "rep_walk_oneman_atst")              
    ReadDataFile("SIDE\\jed.lvl",
        "jed_knight_01",
        "jed_knight_02",
        "jed_knight_03",
        "jed_knight_04",
        --"jed_master_01",
        "jed_master_02",
        --"jed_master_03",
        "jed_runner")	
	
    if( ScriptCB_IsFileExist("no327endor.txt") ~= 1 ) then    
        ReadDataFile("side\\327skin.lvl",
                "327skin")    --load 327th skins to override existing Ep3 trooper appearances
    end   	
	ReadDataFile("SIDE\\commando.lvl", "rep_inf_ep3_commando")
	
	ReadDataFile("SIDE\\cis_128.lvl", "cis_inf_marine")		
 	
    SetupTeams({ 
        REP =         { team = REP, units = 24, reinforcements = -1, 
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
	SetHeroClass(JED, "rep_hero_aalya")
	SetHeroClass(REP, "rep_inf_ep3_commando")
	SetTeamName(JED, "Jedi")
    ClearWalkers()
	AddWalkerType(1, 2) -- 1x2 (1 pair of legs)
    SetMemoryPoolSize("Aimer",20)
    SetMemoryPoolSize("AmmoCounter",260)
    SetMemoryPoolSize("BaseHint",200)
    SetMemoryPoolSize("EnergyBar",260)
    --SetMemoryPoolSize("EntityHover",1)
    SetMemoryPoolSize("EntityFlyer",4)
    SetMemoryPoolSize("EntitySoundStream",1)
    SetMemoryPoolSize("EntitySoundStatic",0)
    --SetMemoryPoolSize("EntityWalker",1)
    SetMemoryPoolSize("MountedTurret",1)
    SetMemoryPoolSize("Obstacle",400)
    SetMemoryPoolSize("PathNode",512)
    SetMemoryPoolSize("TreeGridStack",280)
    SetMemoryPoolSize("Weapon",260)
    SetMemoryPoolSize("Music",39)
    SetSpawnDelay(10,0.25)
    ReadDataFile("fel\\fel1.lvl","fel1_conquest")
    SetDenseEnvironment("false")
    SetAIViewMultiplier(0.64999997615814)
    SetNumBirdTypes(1)
    SetBirdType(0,1,"bird")
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
    OpenAudioStream("sound\\fel.lvl",  "fel1")
    OpenAudioStream("sound\\fel.lvl",  "fel1")

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

    SetAmbientMusic(REP, 1.0, "rep_fel_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_fel_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_fel_amb_end",    2,1)
    SetAmbientMusic(JED, 1.0, "cis_fel_amb_start",  0,1)
    SetAmbientMusic(JED, 0.8, "cis_fel_amb_middle", 1,1)
    SetAmbientMusic(JED, 0.2,"cis_fel_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_fel_amb_victory")
    SetDefeatMusic (REP, "rep_fel_amb_defeat")
    SetVictoryMusic(JED, "cis_fel_amb_victory")
    SetDefeatMusic (JED, "cis_fel_amb_defeat")

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
    AddCameraShot(0.896307, -0.171348, -0.401716, -0.076796, -116.306931, 31.039505, 20.757469)
    AddCameraShot(0.909343, -0.201967, -0.355083, -0.078865, -116.306931, 31.039505, 20.757469)
    AddCameraShot(0.543199, 0.115521, -0.813428, 0.172990, -108.378189, 13.564240, -40.644150)
    AddCameraShot(0.970610, 0.135659, 0.196866, -0.027515, -3.214346, 11.924586, -44.687294)
    AddCameraShot(0.346130, 0.046311, -0.928766, 0.124267, 87.431061, 20.881388, 13.070729)
    AddCameraShot(0.468084, 0.095611, -0.860724, 0.175812, 18.063482, 19.360580, 18.178158)
end

