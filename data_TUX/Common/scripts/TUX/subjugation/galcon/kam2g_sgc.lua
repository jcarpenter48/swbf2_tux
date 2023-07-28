--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 

--  Empire Attacking (attacker is always #1)
ALL = 1
IMP = 2
--  These variables do not change
ATT = 1
DEF = 2

 ---------------------------------------------------------------------------
 -- FUNCTION:    ScriptInit
 -- PURPOSE:     This function is only run once
 -- INPUT:
 -- OUTPUT:
 -- NOTES:       The name, 'ScriptInit' is a chosen convention, and each
 --              mission script must contain a version of this function, as
 --              it is called from C to start the mission.
 ---------------------------------------------------------------------------
 function ScriptPostLoad()
  
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP13"}
    cp2 = CommandPost:New{name = "CP11"}
    cp3 = CommandPost:New{name = "CP4"}
    cp4 = CommandPost:New{name = "CP5"}
    cp5 = CommandPost:New{name = "CP10"}
    cp6 = CommandPost:New{name = "CP2"}
    
    --This sets up the actual objective.  This needs to happen after cp's are defined
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, 
                                     textATT = "level.yavin1.con.att", 
                                     textDEF = "level.yavin1.con.def",
                                     multiplayerRules = true}
    
    --This adds the CPs to the objective.  This needs to happen after the objective is set up
    conquest:AddCommandPost(cp1)
    conquest:AddCommandPost(cp2)
    conquest:AddCommandPost(cp3)
    conquest:AddCommandPost(cp4)
    conquest:AddCommandPost(cp5)
    conquest:AddCommandPost(cp6)
    
    conquest:Start()
 
    EnableSPHeroRules()
    
 	--fix the jettrooper sniper
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetJump", "5.0")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetPush", "8.0")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetAcceleration", "30.0")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetEffect", "rep_sfx_jetpack")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetType", "hover")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetFuelRechargeRate", "0.12")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetFuelCost", "0.16")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetFuelInitialCost", "0.25")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetFuelMinBorder", "0.24")
	
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "PointsToUnlock", "0")
    SetClassProperty("rep_inf_ep2_jettrooper_sniper", "PointsToUnlock", "0")
	SetClassProperty("rep_inf_ep2_jettrooper", "PointsToUnlock", "12")
	SetClassProperty("rep_inf_ep2_rocketeer_chaingun", "PointsToUnlock", "8")
	
	---[[fix award weapons
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "WeaponName5", "rep_weap_award_rifle")
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "WeaponAmmo5", 4)
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "WeaponName6", "rep_weap_award_pistol")
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "WeaponAmmo6", 6)
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "WeaponName4", "rep_weap_award_sniper_rifle")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "WeaponAmmo4", 6)
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "WeaponName5", "rep_weap_award_pistol")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "WeaponAmmo5", 6)
	SetClassProperty("rep_inf_ep2_rocketeer_chaingun", "WeaponName4", "imp_weap_inf_remotedroid")
	SetClassProperty("rep_inf_ep2_rocketeer_chaingun", "WeaponAmmo4", 1)
	--]]--
	---[[create jedi hero
	SetClassProperty("jed_knight_03", "MaxHealth", 1200.0)
	SetClassProperty("jed_knight_03", "AddHealth", 0.0)
	SetClassProperty("jed_knight_03", "FleeLikeAHero", 1)
	SetClassProperty("jed_knight_03", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("jed_knight_03", "SoldierMusic", "all_hero_Chewbacca_lp")
	--]]--
	--[[create Bothan Spy hero
	SetClassProperty("all_inf_officer", "WeaponName1", "rep_weap_inf_rifle")
	SetClassProperty("all_inf_officer", "WeaponAmmo1", 7)
	SetClassProperty("all_inf_officer", "WeaponName3", "all_weap_inf_buff_defense")
	SetClassProperty("all_inf_officer", "WeaponName4", "all_weap_inf_detpack")
	SetClassProperty("all_inf_officer", "MaxHealth", 1400.0)
	SetClassProperty("all_inf_officer", "FleeLikeAHero", 1)
	SetClassProperty("all_inf_officer", "PointsToUnlock", "0")
	SetClassProperty("all_inf_officer", "FoleyFXClass", "rep_inf_trooper")
	SetClassProperty("all_inf_officer", "WeaponName5", "rep_weap_award_rifle")
	SetClassProperty("all_inf_officer", "WeaponAmmo5", 6)
	]]--
 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(600*1024)
    SetPS2ModelMemory(4100000)
    ReadDataFile("ingame.lvl")

	SetMemoryPoolSize ("ClothData",28)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",260)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",260) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",260)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",260)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",2800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",24)     -- should be ~1x #combo       -- should be ~1x #combo     

--  Alliance Attacking (attacker is always #1)
    ALL = ATT
    IMP = DEF
    
    
    ReadDataFile("sound\\kam.lvl;kam1cross")
    ReadDataFile("SIDE\\rep.lvl",
							 "rep_inf_ep2_sniper",
                             "rep_inf_ep2_jettrooper_sniper",
                             "rep_inf_ep2_jettrooper_rifleman",
							 "rep_inf_ep2_jettrooper",
							 "rep_inf_ep2_rocketeer",
							 "rep_inf_ep2_engineer",
                             "rep_inf_ep2_rocketeer_chaingun")
							 
	
    ReadDataFile("SIDE\\all_256.lvl",
                    "all_hero_hansolo_tat",
                    "all_inf_officer")						 
                               
     ReadDataFile("SIDE\\imp.lvl",
                                "imp_inf_rifleman",
                                "imp_inf_rocketeer",
                                "imp_inf_engineer",
                                "imp_inf_sniper",
                                "imp_inf_officer",
                                --"imp_hero_bobafett",
								"imp_hero_darthvader",
                                "imp_inf_dark_trooper")

	ReadDataFile("SIDE\\tur.lvl",
                        "tur_bldg_chaingun_roof",
                        "tur_weap_built_gunturret") 
         
                
    ReadDataFile("SIDE\\rep_128.lvl", "rep_hero_cloakedanakin") --dependency for some jedi
		
	ReadDataFile("SIDE\\jed.lvl",
		--"jed_master_03",
		--"jed_master_02",
		"jed_knight_03")     
    
    SetupTeams{    
        all = {
          team = ALL,
          units = 24,
          reinforcements = 150,
		soldier = { "rep_inf_ep2_jettrooper_rifleman",9, 25},
		assault = { "rep_inf_ep2_rocketeer",1, 4},
        engineer = { "rep_inf_ep2_engineer",1, 4},
		sniper  = { "rep_inf_ep2_jettrooper_sniper",1, 4},
		officer = { "rep_inf_ep2_rocketeer_chaingun",1, 4},
		special = { "rep_inf_ep2_jettrooper",1,4},
		},
        imp = {
          team = IMP,
          units = 24,
          reinforcements = 150,
			soldier = { "imp_inf_rifleman",9, 25},
			assault = { "imp_inf_rocketeer",1, 4},
			engineer = { "imp_inf_engineer", 1, 4},
			sniper  = { "imp_inf_sniper",1, 4},
			officer = { "imp_inf_officer",1, 4},
            special = { "imp_inf_dark_trooper",1, 4},
      
		}
     }
    --SetHeroClass(ALL, "all_inf_officer")
	SetHeroClass(ALL, "jed_knight_03")
    --SetHeroClass(IMP, "imp_hero_bobafett")
	SetHeroClass(IMP, "imp_hero_darthvader")

   --SetTeamName(ALL, "locals")

    --  Level Stats
        ClearWalkers()
        --AddWalkerType(0, 0) -- 3 droidekas (special case: 0 leg pairs)
        --   AddWalkerType(1, 3) 
        --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
        local weaponCnt = 96
        SetMemoryPoolSize ("Aimer", 60)
        SetMemoryPoolSize ("AmmoCounter", weaponCnt)
        SetMemoryPoolSize ("BaseHint", 245)
        SetMemoryPoolSize ("EnergyBar", weaponCnt)
        SetMemoryPoolSize ("EntityCloth", 17)
        SetMemoryPoolSize ("EntityHover",5)
        SetMemoryPoolSize ("EntitySoundStatic", 9)
        --SetMemoryPoolSize ("MountedTurret", 5) --works, but kinda low
		SetMemoryPoolSize ("MountedTurret", 15)
        SetMemoryPoolSize ("Navigator", 45)
        SetMemoryPoolSize ("Obstacle", 390)
        SetMemoryPoolSize ("PathFollower", 45)
        SetMemoryPoolSize ("PathNode", 128)
        SetMemoryPoolSize ("SoundSpaceRegion", 34)
        SetMemoryPoolSize ("TentacleSimulator", 0)
        SetMemoryPoolSize ("TreeGridStack", 180)
        SetMemoryPoolSize ("UnitAgent", 45)
        SetMemoryPoolSize ("UnitController", 45)
        SetMemoryPoolSize ("Weapon", weaponCnt)
		SetMemoryPoolSize("EntityFlyer", 4)   

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("kam\\km1.lvl","km1_Conquest")
	 
    SetMinFlyHeight(60)
    SetMaxFlyHeight(140)
    SetAllowBlindJetJumps(0)

     --  Sound
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_quick", voiceQuick)   
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\kam.lvl",  "kam1")
    OpenAudioStream("sound\\kam.lvl",  "kam1")


    SetBleedingVoiceOver(ALL, IMP, "rep_off_com_report_enemy_losing", 1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed",   1)
    SetBleedingVoiceOver(ALL, ALL, "rep_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, ALL, "rep_off_victory_im", .1, 1)    

    SetAmbientMusic(IMP, 1.0, "rep_kam_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "rep_kam_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2, "rep_kam_amb_end",    2,1)
    SetAmbientMusic(ALL, 1.0, "cis_kam_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "cis_kam_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2, "cis_kam_amb_end",    2,1)

    SetVictoryMusic(IMP, "rep_kam_amb_victory")
    SetDefeatMusic (IMP, "rep_kam_amb_defeat")
    SetVictoryMusic(ALL, "cis_kam_amb_victory")
    SetDefeatMusic (ALL, "cis_kam_amb_defeat")

    SetOutOfBoundsVoiceOver(ALL, "repleaving")
    SetOutOfBoundsVoiceOver(IMP, "impleaving")

     SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
     SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
     --  SetSoundEffect("BirdScatter",         "birdsFlySeq1")
     SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
     SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
     SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
     SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
     SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")

	AddDeathRegion("deathregion")
    --  Camera Stats
	--Kamino
	--Alpha
	AddCameraShot(0.190478, -0.010945, -0.980014, -0.056312, -26.091288, 55.965012, 159.458099);
	--Clonecenter
	AddCameraShot(-0.376571, -0.019637, -0.924923, 0.048232, 176.042465, 53.957565, 244.261139);
	--Overhead many alphas
	AddCameraShot(0.639254, -0.073533, 0.760457, 0.087475, 78.395348, 72.538582, 344.086609);


end


