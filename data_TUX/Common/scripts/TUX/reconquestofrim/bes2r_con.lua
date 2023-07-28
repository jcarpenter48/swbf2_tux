--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")


	--	Republic Attacking (attacker is always #1)
IMP = 1
CIS = 2
	--	These variables do not change
ATT = 1
DEF = 2

---------------------------------------------------------------------------
-- ScriptPostLoad
---------------------------------------------------------------------------
function ScriptPostLoad()
		--This defines the CPs.	These need to happen first
	cp1 = CommandPost:New{name = "cp1"}
	cp2 = CommandPost:New{name = "cp2"}
	cp3 = CommandPost:New{name = "cp3"}
	cp4 = CommandPost:New{name = "cp4"}
	cp5 = CommandPost:New{name = "cp5"}
	cp7 = CommandPost:New{name = "cp7"}
	
	--This sets up the actual objective.	This needs to happen after cp's are defined
	conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, textATT = "game.modes.con", textDEF = "game.modes.con2", multiplayerRules = true}
	
	--This adds the CPs to the objective.	This needs to happen after the objective is set up
	conquest:AddCommandPost(cp1)
	conquest:AddCommandPost(cp2)
	conquest:AddCommandPost(cp3)
	conquest:AddCommandPost(cp4)
	conquest:AddCommandPost(cp5)
	conquest:AddCommandPost(cp7)
	
	conquest:Start()
 
	EnableSPHeroRules()
	
	--modify jedi to have attributes of a hero
	SetClassProperty("jed_knight_02", "MaxHealth", 1200.0)
	SetClassProperty("jed_knight_02", "AddHealth", 0.0)
	SetClassProperty("jed_knight_02", "FleeLikeAHero", 1)
	SetClassProperty("jed_knight_02", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("jed_knight_02", "SoldierMusic", "all_hero_Chewbacca_lp")	
end

---------------------------------------------------------------------------
-- ScriptInit
---------------------------------------------------------------------------
function ScriptInit()
    StealArtistHeap(950*1024)
    -- Designers, these two lines *MUST* be first!
    SetPS2ModelMemory(3997152)
    ReadDataFile("ingame.lvl")

	-- Memory settings ---------------------------------------------------------------------
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",200)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",200) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",200)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",200)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",1800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",22)     -- should be ~1x #combo   
	local weaponCnt = 128
    --SetMemoryPoolSize ("Combo::Transition",75) -- should be a bit bigger than #Combo::State
	SetMemoryPoolSize("Aimer", 0)
	SetMemoryPoolSize("AmmoCounter", weaponCnt)
	SetMemoryPoolSize("BaseHint", 105)
	SetMemoryPoolSize("EnergyBar", weaponCnt)
	SetMemoryPoolSize("EntityCloth", 22)
	SetMemoryPoolSize("EntityFlyer", 6) -- to account for rocket upgrade
	SetMemoryPoolSize("EntityLight", 145)
	SetMemoryPoolSize("EntitySoundStream", 2)
	SetMemoryPoolSize("EntitySoundStatic", 3)
	SetMemoryPoolSize("MountedTurret", 0)
	SetMemoryPoolSize("Navigator", 35)
	SetMemoryPoolSize("Obstacle", 202)
	SetMemoryPoolSize("PathFollower", 35)
	SetMemoryPoolSize("RedOmniLight", 150)
	SetMemoryPoolSize("PathNode", 256)
	SetMemoryPoolSize("ShieldEffect", 0)
	SetMemoryPoolSize("SoundSpaceRegion", 80)
	SetMemoryPoolSize("TentacleSimulator", 12)
	SetMemoryPoolSize("TreeGridStack", 80)
	SetMemoryPoolSize("UnitAgent", 35)
	SetMemoryPoolSize("UnitController", 35)
	SetMemoryPoolSize("Weapon", weaponCnt)
	----------------------------------------------------------------------------------------

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
					"imp_hero_darthvader")
                    
     ReadDataFile("SIDE\\jed.lvl",
                --"jed_knight_04",
                "jed_knight_02")   


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
		
	SetHeroClass(CIS, "jed_knight_02")
	SetHeroClass(IMP, "imp_hero_darthvader")

		--	Level Stats
	ClearWalkers()
	AddWalkerType(0, 4) --special case, up to 4 droidekas
	AddWalkerType(1, 0)
	AddWalkerType(2, 0)


	SetSpawnDelay(10.0, 0.25)
	ReadDataFile("bes\\bes2.lvl", "bespin2_conquest")
	SetDenseEnvironment("true")
	--AddDeathRegion("Sarlac01")
	SetMaxFlyHeight(90)
	SetMaxPlayerFlyHeight(90)
    AISnipeSuitabilityDist(30)


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


    --  Camera Stats
    --Bespin 2
    --Courtyard 
    AddCameraShot(0.364258, -0.004224, -0.931226, -0.010797, -206.270294, -44.204708, 88.837059)
    --Carbon Chamber
    AddCameraShot(0.327508, 0.002799, -0.944810, 0.008076, -184.781006, -59.802036, -28.118919)
    --Wind Tunnel
    AddCameraShot(0.572544, -0.013560, -0.819532, -0.019410, -244.788055, -61.541622, -44.260509)

end