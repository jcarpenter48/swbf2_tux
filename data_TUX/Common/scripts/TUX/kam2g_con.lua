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
    
    
 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(600*1024)
    SetPS2ModelMemory(4100000)
    ReadDataFile("ingame.lvl")

    

--  Alliance Attacking (attacker is always #1)
    ALL = ATT
    IMP = DEF
    
    
    ReadDataFile("sound\\kam.lvl;kam1gcw")
    ReadDataFile("SIDE\\all.lvl",
                    "all_inf_rifleman_fleet",
                    "all_inf_rocketeer_jungle",
                    "all_inf_sniper_fleet",
                    "all_inf_engineer_fleet",
                    "all_hero_hansolo_tat",
                    "all_inf_wookiee",
                    "all_inf_officer")
                               
     ReadDataFile("SIDE\\imp.lvl",
					"imp_inf_rifleman",
					"imp_inf_rocketeer",
					"imp_inf_engineer",
					"imp_inf_sniper",
					"imp_inf_officer",
					"imp_inf_dark_trooper",
					"imp_hero_bobafett")
                

    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser")          
                
     
    
    SetupTeams{    
        all = {
          team = ALL,
          units = 28,
          reinforcements = 150,
			soldier = { "all_inf_rifleman_fleet",9, 25},
			assault = { "all_inf_rocketeer_jungle",1, 4},
			engineer = { "all_inf_engineer_fleet",1, 4},
			sniper  = { "all_inf_sniper_fleet",1, 4},
			officer = { "all_inf_officer",1, 4},
			special = { "all_inf_wookiee",1,4},
		},
        imp = {
          team = IMP,
          units = 28,
          reinforcements = 150,
			soldier = { "imp_inf_rifleman",9, 25},
			assault = { "imp_inf_rocketeer",1, 4},
			engineer = { "imp_inf_engineer", 1, 4},
			sniper  = { "imp_inf_sniper",1, 4},
			officer = { "imp_inf_officer",1, 4},
            special = { "imp_inf_dark_trooper",1, 4},
      
		}
     }
    SetHeroClass(ALL, "all_hero_hansolo_tat")
    SetHeroClass(IMP, "imp_hero_bobafett")

   

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

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    OpenAudioStream("sound\\kam.lvl",  "kam1")
    OpenAudioStream("sound\\kam.lvl",  "kam1")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    -- OpenAudioStream("sound\\pol.lvl",  "pol1_emt")

    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(ALL, "Allleaving")
    SetOutOfBoundsVoiceOver(IMP, "Impleaving")

    SetAmbientMusic(ALL, 1.0, "all_kam_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_kam_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2,"all_kam_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_kam_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_kam_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2,"imp_kam_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_kam_amb_victory")
    SetDefeatMusic (ALL, "all_kam_amb_defeat")
    SetVictoryMusic(IMP, "imp_kam_amb_victory")
    SetDefeatMusic (IMP, "imp_kam_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
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


