--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
Conquest = ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 
	KillObject ("TempleBlastDoor")
--  Empire Attacking (attacker is always #1)
     CIS = 2
     IMP = 1
    --  These variables do not change
     ATT = IMP
     DEF = CIS

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
    DisableBarriers("StopTanks")



	    AddDeathRegion("death1")
	    AddDeathRegion("death2")
	    AddDeathRegion("death3")
	    AddDeathRegion("death4")
	    AddDeathRegion("death5")
	    AddDeathRegion("death6")
	    AddDeathRegion("death7")
	    AddDeathRegion("death8") 
    
    
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "Bazaar"}
    cp2 = CommandPost:New{name = "CP1"}
    cp3 = CommandPost:New{name = "LandingZone"}
    cp4 = CommandPost:New{name = "ReflectingPool"}
    cp5 = CommandPost:New{name = "Temple"}
    cp6 = CommandPost:New{name = "Tflank"}
    cp7 = CommandPost:New{name = "ViaDuct"}
    
    --This sets up the actual objective.  This needs to happen after cp's are defined
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, 
                                     textATT = "game.modes.con", 
                                     textDEF = "game.modes.con2",
                                     multiplayerRules = true}
    
    --This adds the CPs to the objective.  This needs to happen after the objective is set up
    conquest:AddCommandPost(cp1)
    conquest:AddCommandPost(cp2)
    conquest:AddCommandPost(cp3)
    conquest:AddCommandPost(cp4)
    conquest:AddCommandPost(cp5)
    conquest:AddCommandPost(cp6)
    conquest:AddCommandPost(cp7)
    
    conquest:Start()





    EnableSPHeroRules()
 
	--smuggler hero
	SetClassProperty("all_inf_engineer", "MaxHealth", 1100.0)
	SetClassProperty("all_inf_engineer", "AddHealth", 0.0)
	SetClassProperty("all_inf_engineer", "FleeLikeAHero", 1)
	SetClassProperty("all_inf_engineer", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("all_inf_engineer", "SoldierMusic", "all_hero_Chewbacca_lp")	 
	SetClassProperty("all_inf_engineer", "WeaponName1", "imp_weap_inf_arccaster")	
    SetClassProperty("all_inf_engineer", "WeaponAmmo1", 10)		
 end

function ScriptInit()
    -- Designers, these two lines *MUST* be first!

	StealArtistHeap(1200*1024)

    SetPS2ModelMemory(2600000)
    ReadDataFile("ingame.lvl")
    
  	  	SetMaxFlyHeight(14)
  	  	SetMaxPlayerFlyHeight (14)
    	SetMaxFlyHeight(-17)
    
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",20)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",300)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",300) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",300)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",150)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",1800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",50)
    
	ReadDataFile("sound\\mus.lvl;mus1cross")
    ReadDataFile("SIDE\\cis_256.lvl",
                  "cis_inf_rifleman",
                  "cis_inf_rocketeer",
                  "cis_inf_engineer",
                  "cis_inf_sniper",
                  "cis_inf_droideka",
                  "CIS_inf_officer")
	ReadDataFile("SIDE\\imp_256.lvl",
					"imp_inf_rifleman",
					"imp_inf_rocketeer",
					"imp_inf_engineer",
					"imp_inf_sniper",
					"imp_inf_officer",
					"imp_inf_dark_trooper",					
					"imp_hero_bobafett")
                    
                        
                        
                        
    ReadDataFile("SIDE\\tur.lvl", 
    			"tur_bldg_laser",
    			"tur_bldg_tower")          
                        


	SetupTeams{
		imp = {
			team = IMP,
			units = 22,
			reinforcements = 150,
			soldier = { "imp_inf_rifleman",7, 22},
			assault = { "imp_inf_rocketeer",1,4},
			engineer = { "imp_inf_engineer",1,4},
			sniper  = { "imp_inf_sniper",1,4},
			officer = { "imp_inf_officer",1,4},
				special = { "imp_inf_dark_trooper",1,4},

		},
		cis = {
			team = CIS,
			units = 22,
			reinforcements = 150,
			soldier = { "CIS_inf_rifleman",7, 22},
			assault = { "CIS_inf_rocketeer",1,4},
			engineer = { "CIS_inf_engineer",1,4},
			sniper  = { "CIS_inf_sniper",1,4},
			officer = { "CIS_inf_officer",1,4},
			special = { "cis_inf_droideka",1,4},

		},

	}
		
	SetHeroClass(CIS, "all_inf_engineer")
	SetHeroClass(IMP, "imp_hero_bobafett")
   

		--	Level Stats
	ClearWalkers()
	AddWalkerType(0, 4) --special case, up to 4 droidekas
    --AddWalkerType(1, 2) -- 1x2 (1 pair of legs)
    AddWalkerType(2, 0) -- 2x2 (2 pairs of legs)
    AddWalkerType(3, 0) -- 3x2 (3 pairs of legs)
    local weaponCnt = 128
    SetMemoryPoolSize("Aimer", 75)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 1000)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
	SetMemoryPoolSize("EntityCloth", 17)
	SetMemoryPoolSize("EntityFlyer", 7)
    SetMemoryPoolSize("EntityHover", 8)
    SetMemoryPoolSize("EntityLight", 50)
    SetMemoryPoolSize("EntitySoundStream", 4)
    SetMemoryPoolSize("EntitySoundStatic", 20)
    SetMemoryPoolSize("MountedTurret", 25)
	SetMemoryPoolSize("Navigator", 49)
    SetMemoryPoolSize("Obstacle", 760)
	SetMemoryPoolSize("PathNode", 512)
    SetMemoryPoolSize("SoundSpaceRegion", 46)
    SetMemoryPoolSize("TreeGridStack", 500)
	SetMemoryPoolSize("UnitAgent", 49)
	SetMemoryPoolSize("UnitController", 49)
	SetMemoryPoolSize("Weapon", weaponCnt)
    
    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("YAV\\yav1.lvl",
                                 "Yavin1_Conquest")
    SetDenseEnvironment("false")

    --  Birdies
    SetNumBirdTypes(2)
    SetBirdType(0,1.0,"bird")
    SetBirdType(1,1.5,"bird2")

    --  Fishies
    SetNumFishTypes(1)
    SetFishType(0,0.8,"fish")



   --  Sound 
    voiceSlow = OpenAudioStream("sound\\global.lvl", "mus_objective_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)     
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "cis_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_quick", voiceQuick)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_quick", voiceQuick) 
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\global.lvl",  "global_vo_slow")

    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(IMP, CIS, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, IMP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

    SetOutOfBoundsVoiceOver(IMP, "impleaving")
    SetOutOfBoundsVoiceOver(CIS, "Cisleaving")

    SetAmbientMusic(IMP, 1.0, "cis_mus_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.75, "cis_mus_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.25,"cis_mus_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_mus_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.99, "cis_mus_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.1,"cis_mus_amb_end",    2,1)

    SetVictoryMusic(IMP, "rep_mus_amb_victory")
    SetDefeatMusic (IMP, "rep_mus_amb_defeat")
    SetVictoryMusic(CIS, "cis_mus_amb_victory")
    SetDefeatMusic (CIS, "cis_mus_amb_defeat")

	  SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
	  SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
		--SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
		--SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
	  SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
	  SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
	  SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
	  SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
	  SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")


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
