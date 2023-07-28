    --
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
    
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")

  --  Empire Attacking (attacker is always #1)
ALL = 1;
IMP = 2;
     --  These variables do not change
ATT = 1;
DEF = 2;

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
    SetProperty("cp1", "Team", "1")
    SetProperty("cp2", "Team", "2")
    SetProperty("cp3", "Team", "2")
    SetProperty("cp4", "Team", "2")
    SetProperty("cp5", "Team", "1")
    SetProperty("cp6", "Team", "1")
    DisableBarriers("camp")
    SetAIDamageThreshold("Comp1", 0 )
    SetAIDamageThreshold("Comp2", 0 )
    SetAIDamageThreshold("Comp3", 0 )
    SetAIDamageThreshold("Comp4", 0 )
    SetAIDamageThreshold("Comp5", 0 )
    SetAIDamageThreshold("Comp6", 0 )
    SetAIDamageThreshold("Comp7", 0 )
    SetAIDamageThreshold("Comp8", 0 )
    SetAIDamageThreshold("Comp9", 0 )
    SetAIDamageThreshold("Comp10", 0 )

        SetProperty("Kam_Bldg_Podroom_Door32", "Islocked", 1)

    SetProperty("Kam_Bldg_Podroom_Door33", "Islocked", 1)
        SetProperty("Kam_Bldg_Podroom_Door32", "Islocked", 1)
                SetProperty("Kam_Bldg_Podroom_Door34", "Islocked", 1)
    SetProperty("Kam_Bldg_Podroom_Door35", "Islocked", 1)
        SetProperty("Kam_Bldg_Podroom_Door27", "Islocked", 0)       
            SetProperty("Kam_Bldg_Podroom_Door28", "Islocked", 1)       
    SetProperty("Kam_Bldg_Podroom_Door36", "Islocked", 1)
        SetProperty("Kam_Bldg_Podroom_Door20", "Islocked", 0)
    UnblockPlanningGraphArcs("connection71")
      
    --Objective1
    UnblockPlanningGraphArcs("connection85")
    UnblockPlanningGraphArcs("connection48")
    UnblockPlanningGraphArcs("connection63")
    UnblockPlanningGraphArcs("connection59")
    UnblockPlanningGraphArcs("close")
    UnblockPlanningGraphArcs("open")
    DisableBarriers("frog")
    DisableBarriers("close")
    DisableBarriers("open")
    
    --blocking Locked Doors
    UnblockPlanningGraphArcs("connection194");
    UnblockPlanningGraphArcs("connection200");
    UnblockPlanningGraphArcs("connection118");
    DisableBarriers("FRONTDOOR2-3");
    DisableBarriers("FRONTDOOR2-1");  
    DisableBarriers("FRONTDOOR2-2");  
    
    --Lower cloning facility
    UnblockPlanningGraphArcs("connection10")
    UnblockPlanningGraphArcs("connection159")
    UnblockPlanningGraphArcs("connection31")
    DisableBarriers("FRONTDOOR1-3")
    DisableBarriers("FRONTDOOR1-1")  
    DisableBarriers("FRONTDOOR1-2")
    
        --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "cp1"}
    cp2 = CommandPost:New{name = "cp2"}
    cp3 = CommandPost:New{name = "cp3"}
    cp4 = CommandPost:New{name = "cp4"}
    cp5 = CommandPost:New{name = "cp5"}
    cp6 = CommandPost:New{name = "cp6"}
    
    --This sets up the actual objective.  This needs to happen after cp's are defined
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, textATT = "game.modes.con", textDEF = "game.modes.con2", multiplayerRules = true}
    
    --This adds the CPs to the objective.  This needs to happen after the objective is set up
    conquest:AddCommandPost(cp1)
    conquest:AddCommandPost(cp2)
    conquest:AddCommandPost(cp3)
    conquest:AddCommandPost(cp4)
    conquest:AddCommandPost(cp5)
    conquest:AddCommandPost(cp6)
conquest:Start()
    EnableSPHeroRules()
    
    SetProperty("cp2", "spawnpath", "cp2_spawn")
    SetProperty("cp2", "captureregion", "cp2_capture")
 
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
	SetClassProperty("jed_master_02", "MaxHealth", 1450.0)
	SetClassProperty("jed_master_02", "AddHealth", 0.0)
	SetClassProperty("jed_master_02", "FleeLikeAHero", 1)
	SetClassProperty("jed_master_02", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("jed_master_02", "SoldierMusic", "all_hero_Chewbacca_lp")
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
  
 --START BRIDGEWORK!

-- OPEN

 function ScriptInit()
     -- Designers, these two lines *MUST* be first!
        SetPS2ModelMemory(3600000)
     ReadDataFile("ingame.lvl")

	SetMemoryPoolSize ("ClothData",28)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",260)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",260) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",260)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",260)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",2800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",24)     -- should be ~1x #combo       -- should be ~1x #combo 
	
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
								"imp_hero_emperor",
                                "imp_inf_dark_trooper")

	ReadDataFile("SIDE\\tur.lvl",
                        "tur_bldg_chaingun_roof",
                        "tur_weap_built_gunturret") 

	ReadDataFile("SIDE\\jed.lvl", "jed_master_02") 
		
     --  Level Stats
     ClearWalkers()
     --    AddWalkerType(0, 0) -- 8 droidekas (special case: 0 leg pairs)
     --    AddWalkerType(1, 3) -- 8 droidekas (special case: 0 leg pairs)
     --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
     --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
     SetMemoryPoolSize ("EntityCloth", 33)
     SetMemoryPoolSize ("EntityLight", 64)  
     SetMemoryPoolSize ("Obstacle", 800)
    SetMemoryPoolSize("EntitySoundStream", 3)
     SetMemoryPoolSize ("SoundSpaceRegion", 36)
    SetMemoryPoolSize("EntitySoundStatic", 85)
     SetMemoryPoolSize ("Weapon", 260)

   SetupTeams{
    all = {
        team = ALL,
        units = 22,
        reinforcements = 150,
		soldier = { "rep_inf_ep2_jettrooper_rifleman",9, 25},
		assault = { "rep_inf_ep2_rocketeer",1, 4},
        engineer = { "rep_inf_ep2_engineer",1, 4},
		sniper  = { "rep_inf_ep2_jettrooper_sniper",1, 4},
		officer = { "rep_inf_ep2_rocketeer_chaingun",1, 4},
		special = { "rep_inf_ep2_jettrooper",1,4},
    },

}   

SetupTeams{
    imp = {
        team = IMP,
        units = 22,
        reinforcements = 150,
        soldier = { "imp_inf_rifleman",9, 25},
        assault = { "imp_inf_rocketeer",1, 4},
        engineer = { "imp_inf_engineer", 1, 4},
        sniper  = { "imp_inf_sniper",1, 4},
        officer = { "imp_inf_officer",1, 4},
            special = { "imp_inf_dark_trooper",1, 4},
      
    },

}
	--SetTeamIcon(ALL, "rep_icon", "rep_icon", "rep_icon")
	--SetTeamName(ALL, "locals")
    --SetHeroClass(ALL, "all_inf_officer")
	SetHeroClass(ALL, "jed_master_02")
    --SetHeroClass(IMP, "imp_hero_bobafett")
	SetHeroClass(IMP, "imp_hero_emperor")
    
     SetSpawnDelay(10.0, 0.25)
     --  AddDeathRegion("deathregion")
     ReadDataFile("KAM\\kam1.lvl", "kamino1_conquest")
         SetMemoryPoolSize("EntityFlyer", 6)
     SetDenseEnvironment("false")
         SetMinFlyHeight(60)
    SetAllowBlindJetJumps(0)
       SetMaxFlyHeight(102)
    SetMaxPlayerFlyHeight(102)
     --SetStayInTurrets(1)
	local weaponCnt = 215
    SetMemoryPoolSize("Aimer", 39)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 210)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth", 18)
    SetMemoryPoolSize("EntityLight", 70)
    SetMemoryPoolSize("EntitySoundStream", 3)
    SetMemoryPoolSize("EntitySoundStatic", 84)
    SetMemoryPoolSize("MountedTurret", 22)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 800)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("PathNode", 256)
    SetMemoryPoolSize("SoundSpaceRegion", 36)
    SetMemoryPoolSize("TentacleSimulator", 0)
    SetMemoryPoolSize("TreeGridStack", 338)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("EntityFlyer", 6)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon", weaponCnt)

     --  Movies
     --  SetVictoryMovie(ALL, "all_end_victory")
     --  SetDefeatMovie(ALL, "imp_end_victory")
     --  SetVictoryMovie(IMP, "imp_end_victory")
     --  SetDefeatMovie(IMP, "all_end_victory")

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


     SetAttackingTeam(ATT)
    AddDeathRegion("deathregion")


   		    AddCameraShot(0.564619, -0.121047, 0.798288, 0.171142, 68.198814, 79.137611, 110.850922);

            AddCameraShot(-0.281100, 0.066889, -0.931340, -0.221616, 10.076019, 82.958336, -26.261774);

            AddCameraShot(0.209553, -0.039036, -0.960495, -0.178923, 92.558563, 58.820618, 130.675919);

            AddCameraShot(0.968794, 0.154227, 0.191627, -0.030506, -173.914413, 69.858940, 52.532421);

            AddCameraShot(0.744389, 0.123539, 0.647364, -0.107437, 97.475639, 53.216236, 76.477089);

            AddCameraShot(-0.344152, 0.086702, -0.906575, -0.228393, 95.062233, 105.285820, -37.661552);
 end
