--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams")

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
--fix dellso
	SetClassProperty("geo_inf_agro_geonosian", "AnimatedAddon", "WINGS")
    SetClassProperty("geo_inf_agro_geonosian", "GeometryAddon", "geonosianwings_folded")
	SetClassProperty("geo_inf_agro_geonosian", "AddonAttachJoint", "bone_ribcage")
	
	AddAIGoal(3, "Deathmatch", 100)
    cp1 = CommandPost:New{name = "cp1"}
    cp2 = CommandPost:New{name = "cp2"}
    cp3 = CommandPost:New{name = "cp3"}
    cp4 = CommandPost:New{name = "cp4"}
    cp6 = CommandPost:New{name = "cp6"}
    cp7 = CommandPost:New{name = "cp7"}
    cp8 = CommandPost:New{name = "cp8"}
    
    --This sets up the actual objective.  This needs to happen after cp's are defined
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, text = "level.geo1.objectives.conquest", multiplayerRules = true}
    
    --This adds the CPs to the objective.  This needs to happen after the objective is set up
    conquest:AddCommandPost(cp1)
    conquest:AddCommandPost(cp2)
    conquest:AddCommandPost(cp3)
    conquest:AddCommandPost(cp4)
    conquest:AddCommandPost(cp6)
    conquest:AddCommandPost(cp7)
    conquest:AddCommandPost(cp8)
    
    conquest:Start()
    
    EnableSPHeroRules()
    
    AddDeathRegion("deathregion")
    AddDeathRegion("deathregion2")
    AddDeathRegion("deathregion3")
    AddDeathRegion("deathregion4")
    AddDeathRegion("deathregion5")
    
 end
function ScriptInit()
    StealArtistHeap(800*1024)
    -- Designers, these two lines *MUST* be first.
    SetPS2ModelMemory(3500000)
    ReadDataFile("ingame.lvl")

    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",200)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",200) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",200)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",200)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",1800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",22)     -- should be ~1x #combo   
    
    --  IMP Attacking (attacker is always #1)
    local IMP = 1
    local CIS = 2
    --  These variables do not change
    local ATT = 1
    local DEF = 2

    SetTeamAggressiveness(CIS, 1.0)
    SetTeamAggressiveness(IMP, 1.0)

    SetMemoryPoolSize("Music", 40)

    ReadDataFile("sound\\mus.lvl;mus1cross")
     ReadDataFile("SIDE\\imp_256.lvl",
                    --Insert "imp_bldg_defensegridturret", once the odf has been set up
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_engineer",
                    "imp_inf_sniper",
                    "imp_inf_officer",
                    "imp_inf_dark_trooper",                   
                    "imp_hero_bobafett")
                             
    ReadDataFile("SIDE\\cis_256.lvl",
                  "cis_inf_rifleman",
                  "cis_inf_rocketeer",
                  "cis_inf_engineer",
                  "cis_inf_sniper",
                  "cis_inf_droideka",
                  "CIS_inf_officer")

   ReadDataFile("SIDE\\geo.lvl",
                        "gen_inf_geonosian",
                        "geo_inf_agro_geonosian")
                             
	ReadDataFile("SIDE\\tur.lvl",
                             "tur_bldg_geoturret")

    --  Level Stats

    ClearWalkers()
    --SetMemoryPoolSize("EntityWalker", -1)
    AddWalkerType(0, 4) -- 4 droidekas (special case: 0 leg pairs)
    --AddWalkerType(2, 3) -- 2 spider walkers with 2 leg pairs each
    --AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
    local weaponcnt = 128
    SetMemoryPoolSize("Aimer", 50)
    SetMemoryPoolSize("AmmoCounter", weaponcnt)
    SetMemoryPoolSize("BaseHint", 100)
    --SetMemoryPoolSize("CommandWalker", 1)
    SetMemoryPoolSize("EnergyBar", weaponcnt)
    SetMemoryPoolSize("EntityFlyer", 6)
    --SetMemoryPoolSize("EntityHover", 9)
    SetMemoryPoolSize("EntityLight", 50)
    SetMemoryPoolSize("EntitySoundStream", 4)
    SetMemoryPoolSize("MountedTurret", 10)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 450)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("PathNode", 100)
    SetMemoryPoolSize("TreeGridStack", 300)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon", weaponcnt)

    SetSpawnDelay(10.0, 0.25)

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
	AddUnitClass(CIS, "geo_inf_geonosian")	
	SetHeroClass(CIS, "geo_inf_agro_geonosian")
	SetHeroClass(IMP, "imp_hero_bobafett")


    --  Attacker Stats
    
    --teamATT = ConquestTeam:New{team = ATT}
    --teamATT:AddBleedThreshold(21, 0.75)
    --teamATT:AddBleedThreshold(11, 2.25)
    --teamATT:AddBleedThreshold(1, 3.0)
    --teamATT:Init()
    SetTeamAsEnemy(ATT,3)
    SetTeamAsEnemy(3,ATT)

    --  Defender Stats
    
    --teamDEF = ConquestTeam:New{team = DEF}
    --teamDEF:AddBleedThreshold(21, 0.75)
    --teamDEF:AddBleedThreshold(11, 2.25)
    --teamDEF:AddBleedThreshold(1, 3.0)
    --teamDEF:Init()
    SetTeamAsFriend(DEF,3)

    --  Local Stats
    SetTeamName(3, "locals")
    SetUnitCount(3, 7)
    AddUnitClass(3, "geo_inf_geonosian", 7)    
    SetTeamAsFriend(3, DEF)
    --SetTeamName(4, "locals")
    --AddUnitClass(4, "rep_inf_jedimale",1)
    --AddUnitClass(4, "rep_inf_jedimaleb",1)
    --AddUnitClass(4, "rep_inf_jedimaley",1)
    --SetUnitCount(4, 3)
    --SetTeamAsFriend(4, ATT)

    ReadDataFile("GEO\\geo1.lvl", "geo1_conquest")

    SetDenseEnvironment("false")
    SetMinFlyHeight(-65)
    SetMaxFlyHeight(50)
    SetMaxPlayerFlyHeight(50)



    --  Birdies
    --SetNumBirdTypes(1)
    --SetBirdType(0.0,10.0,"dragon")
    --SetBirdFlockMinHeight(90.0)

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



    --ActivateBonus(CIS, "SNEAK_ATTACK")
    --ActivateBonus(IMP, "SNEAK_ATTACK")

    SetAttackingTeam(ATT)

    --Opening Satalite Shot
    --Geo
    --Mountain
    AddCameraShot(0.996091, 0.085528, -0.022005, 0.001889, -6.942698, -59.197201, 26.136919)
    --Wrecked Ship
    AddCameraShot(0.906778, 0.081875, -0.411906, 0.037192, 26.373968, -59.937874, 122.553581)
    --War Room  
    --AddCameraShot(0.994219, 0.074374, 0.077228, -0.005777, 90.939568, -49.293945, -69.571136)
end
