--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")

function ScriptPostLoad()
    --This defines the CPs.  These need to happen first
    SetProperty("FDL-2", "IsLocked", 1)
    cp1 = CommandPost:New{name = "cp1"}
    cp2 = CommandPost:New{name = "cp2"}
    cp3 = CommandPost:New{name = "cp3"}
	cp6 = CommandPost:New{name = "cp6"}
	cp7 = CommandPost:New{name = "cp7"}
	cp8 = CommandPost:New{name = "cp8"}

    
    --This sets up the actual objective.  This needs to happen after cp's are defined
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, textATT = "game.modes.con", textDEF = "game.modes.con2", multiplayerRules = true}
    
    --This adds the CPs to the objective.  This needs to happen after the objective is set up
	conquest:AddCommandPost(cp1)
	conquest:AddCommandPost(cp2)
	conquest:AddCommandPost(cp3)

	conquest:AddCommandPost(cp6)
	conquest:AddCommandPost(cp7)
	conquest:AddCommandPost(cp8)


	conquest:Start()
	 AddAIGoal(1, "conquest", 1000)
	 AddAIGoal(2, "conquest", 1000)
	 AddAIGoal(3, "conquest", 1000)
	EnableSPHeroRules()
	
	--modify rebel smuggler to have attributes of a hero
	--SetClassProperty("all_inf_engineer", "GeometryName", "nab_inf_gungan")
	--SetClassProperty("all_inf_engineer", "GeometryLowRes", "nab_inf_gungan_low1")
	SetClassProperty("all_inf_engineer", "MaxHealth", 1100.0)
	SetClassProperty("all_inf_engineer", "AddHealth", 0.0)
	SetClassProperty("all_inf_engineer", "FleeLikeAHero", 1)
	SetClassProperty("all_inf_engineer", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("all_inf_engineer", "SoldierMusic", "all_hero_Chewbacca_lp")	 
	SetClassProperty("all_inf_engineer", "WeaponName1", "imp_weap_inf_arccaster")	
    SetClassProperty("all_inf_engineer", "WeaponAmmo1", 10)			
end

---------------------------------------------------------------------------
-- FUNCTION:    ScriptInit
-- PURPOSE:     This function is only run once
-- INPUT:
-- OUTPUT:
-- NOTES:       The name, 'ScriptInit' is a chosen convention, and each
--              mission script must contain a version of this function, as
--              it is called from C to start the mission.
---------------------------------------------------------------------------

function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(1024 * 1024)
    SetPS2ModelMemory(2097152 + 65536 * 10)
    ReadDataFile("ingame.lvl")

    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",200)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",200) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",200)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",200)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",1800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",22)     -- should be ~1x #combo   
	
    --  Empire Attacking (attacker is always #1)
    local CIS = 2
    local IMP = 1
    --  These variables do not change
    local ATT = 1
    local DEF = 2

    AddMissionObjective(IMP, "red", "level.tat2.objectives.1")
    --  AddMissionObjective(IMP, "orange", "level.tat2.objectives.2")
    AddMissionObjective(CIS, "green", "level.tat2.objectives.1b")
    --  AddMissionObjective(CIS, "orange", "level.tat2.objectives.3")


    SetMaxFlyHeight(40)
	SetMaxPlayerFlyHeight(40)

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
                    "imp_hero_bobafett",
                    "imp_fly_destroyer_dome" )

	ReadDataFile("SIDE\\all_256.lvl",
					"all_inf_engineer")
    ReadDataFile("SIDE\\gun.lvl",
                    "gun_inf_defender") --for the geometry model
					
    ReadDataFile("SIDE\\des.lvl",
                             "tat_inf_jawa")

    -- Jawas --------------------------
    SetTeamName (3, "locals")
    AddUnitClass (3, "tat_inf_jawa", 7)
    SetUnitCount (3, 7)
    SetTeamAsFriend(3,ATT)
    SetTeamAsFriend(3,DEF)
    SetTeamAsFriend(ATT,3)
    SetTeamAsFriend(DEF,3)
	-----------------------------------

	ReadDataFile("SIDE\\tur.lvl",
						"tur_bldg_tat_barge",	
						"tur_bldg_laser")	
 
	SetupTeams{
		imp = {
			team = IMP,
			units = 20,
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
			units = 20,
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

    --  Level Stats
    ClearWalkers()
    AddWalkerType(0, 4) -- special -> droidekas
    AddWalkerType(1, 0) -- 1x2 (1 pair of legs)
    AddWalkerType(2, 0) -- 2x2 (2 pairs of legs)
    AddWalkerType(3, 0) -- 3x2 (3 pairs of legs)
    SetMemoryPoolSize("Aimer", 14)
	SetMemoryPoolSize("EntityCloth", 25)
	SetMemoryPoolSize("EntityFlyer", 6) -- to account for rocket upgrade
    SetMemoryPoolSize("MountedTurret", 14)
    SetMemoryPoolSize("Obstacle", 664)
    SetMemoryPoolSize("PathNode", 384)
    SetMemoryPoolSize("TreeGridStack", 500)

    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("TAT\\tat2.lvl", "tat2_con")
    SetDenseEnvironment("false")


    --  Sound 
    voiceSlow = OpenAudioStream("sound\\global.lvl", "mus_objective_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)     
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "cis_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_quick", voiceQuick)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_quick", voiceQuick) 
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\mus.lvl",  "mus1")
    OpenAudioStream("sound\\mus.lvl",  "mus1")
    OpenAudioStream("sound\\mus.lvl",  "mus_objective_vo_slow")
    OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\mus.lvl",  "mus1_emt")

    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(IMP, CIS, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, imp, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

    SetOutOfBoundsVoiceOver(IMP, "impleaving")
    SetOutOfBoundsVoiceOver(CIS, "Cisleaving")

    SetAmbientMusic(IMP, 1.0, "rep_mus_amb_obj1_3_explore",  0,1)
    SetAmbientMusic(IMP, 0.75, "rep_mus_amb_obj1_3_explore", 1,1)
    SetAmbientMusic(IMP, 0.25,"rep_mus_amb_obj4_5_explore",    2,1)
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




    SetAttackingTeam(ATT)

    --  Camera Stats
    --Tat2 Mos Eisley
	AddCameraShot(0.974338, -0.222180, 0.035172, 0.008020, -82.664650, 23.668301, 43.955681);
	AddCameraShot(0.390197, -0.089729, -0.893040, -0.205362, 23.563562, 12.914885, -101.465561);
	AddCameraShot(0.169759, 0.002225, -0.985398, 0.012916, 126.972809, 4.039628, -22.020613);
	AddCameraShot(0.677453, -0.041535, 0.733016, 0.044942, 97.517807, 4.039628, 36.853477);
	AddCameraShot(0.866029, -0.156506, 0.467299, 0.084449, 7.685640, 7.130688, -10.895234);
end