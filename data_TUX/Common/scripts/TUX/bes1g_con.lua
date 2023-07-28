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
	SetTeamAggressiveness(IMP, 1.0)
    SetTeamAggressiveness(ALL, 1.0)
	
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP19"}
    cp2 = CommandPost:New{name = "CP12"}
    cp3 = CommandPost:New{name = "CP17"}
    cp4 = CommandPost:New{name = "CP18"}
    cp5 = CommandPost:New{name = "CP16"}
    cp6 = CommandPost:New{name = "CP9"}
	cp7 = CommandPost:New{name = "CP15"}
    
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
	conquest:AddCommandPost(cp7)
    
    conquest:Start()
 
    EnableSPHeroRules()
    
    
 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(600*1024)
    SetPS2ModelMemory(4100000)
    ReadDataFile("ingame.lvl")

    ALL = ATT
    IMP = DEF
    
	ReadDataFile("sound\\cor.lvl;cor1gcw")
    ReadDataFile("sound\\BS1.lvl;BS1gcw") 
    --ReadDataFile("sound\\hot.lvl;hot1gcw")
     ReadDataFile("SIDE\\all_256.lvl",
                    "all_inf_rifleman_fleet",
                    "all_inf_rocketeer_jungle",
                    "all_inf_sniper_fleet",
                    "all_inf_engineer_fleet",
                    "all_inf_officer",
                    "all_hero_luke_tat", --tat is actually bes luke
					"all_fly_xwing_sc",
                    "all_inf_wookiee")
                    
     ReadDataFile("SIDE\\imp_256.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_officer",
                    "imp_inf_sniper",
                    "imp_inf_engineer",
                    "imp_inf_dark_trooper",
					"imp_fly_tiefighter_sc",
                    "imp_hero_darthvader")

	ReadDataFile("SIDE\\tur.lvl", 
			"tur_bldg_laser")  
                    
    SetupTeams{

        all={
            team = ALL,
            units = 20,
            reinforcements = 150,
            soldier  = {"all_inf_rifleman_fleet",7, 15},
            assault  = {"all_inf_rocketeer_jungle",1, 4},
            engineer = {"all_inf_engineer_fleet",1, 4},
            sniper   = {"all_inf_sniper_fleet",1, 4},
            officer  = {"all_inf_officer",1, 4},
            special  = {"all_inf_wookiee",1, 4},
            
            
        },
        
        imp={
            team = IMP,
            units = 20,
            reinforcements = 150,
            soldier  = {"imp_inf_rifleman",7, 15},
            assault  = {"imp_inf_rocketeer",1, 4},
            engineer = {"imp_inf_engineer",1, 4},
            sniper   = {"imp_inf_sniper",1, 4},
            officer  = {"imp_inf_officer",1, 4},
            special  = {"imp_inf_dark_trooper",1, 4},
        }
    }
    
    SetHeroClass(IMP, "imp_hero_darthvader")
    SetHeroClass(ALL, "all_hero_luke_tat")

   

    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 4) -- 3 droidekas (special case: 0 leg pairs)
        --   AddWalkerType(1, 3) 
        --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
		--local weaponCnt = 230
		--SetMemoryPoolSize("Aimer", 70)
		--SetMemoryPoolSize("AmmoCounter", weaponCnt)
		--SetMemoryPoolSize("BaseHint", 220)
		--SetMemoryPoolSize("EnergyBar", weaponCnt)
		--SetMemoryPoolSize("EntityHover", 11)
		--SetMemoryPoolSize("EntityLight", 40)
		--SetMemoryPoolSize("EntityCloth", 58)
		SetMemoryPoolSize("EntityFlyer", 18)
		SetMemoryPoolSize("EntitySoundStream", 3)
		SetMemoryPoolSize("EntitySoundStatic", 120)
		SetMemoryPoolSize("MountedTurret", 12)
		--SetMemoryPoolSize("Navigator", 50)
		--SetMemoryPoolSize("Obstacle", 300)
		--SetMemoryPoolSize("PathFollower", 50)
		--SetMemoryPoolSize("PathNode", 512)
		--SetMemoryPoolSize("TentacleSimulator", 8)
		--SetMemoryPoolSize("TreeGridStack", 300)
		--SetMemoryPoolSize("UnitAgent", 50)
		--SetMemoryPoolSize("UnitController", 50)
		--SetMemoryPoolSize("Weapon", weaponCnt)

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("bes\\bs1.lvl","bs1_Conquest")
     SetDenseEnvironment("True")   
     AddDeathRegion("death_region")
	 
    SetMapNorthAngle(0)
    SetMinFlyHeight(-300)
    SetMaxFlyHeight(500)
    SetMinPlayerFlyHeight(-300)
    SetMaxPlayerFlyHeight(500)

    SetAIVehicleNotifyRadius(64)
    SetStayInTurrets(1)
	
    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)   
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
	OpenAudioStream("sound\\BS1.lvl",  "BS1")
	OpenAudioStream("sound\\BS1.lvl",  "BS1")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    --OpenAudioStream("sound\\hot.lvl", "hot1gcw")
    --OpenAudioStream("sound\\hot.lvl", "hot1gcw")

    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

    -- SetLowReinforcementsVoiceOver(ALL, IMP, "all_hot_transport_away", .75, 1)
    -- SetLowReinforcementsVoiceOver(ALL, IMP, "all_hot_transport_away", .5, 1)
    -- SetLowReinforcementsVoiceOver(ALL, IMP, "all_hot_transport_away", .25, 1)

    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(2, "Allleaving")
    SetOutOfBoundsVoiceOver(1, "Impleaving")

    SetAmbientMusic(ALL, 1.0, "all_cor_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_cor_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2, "all_cor_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_cor_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_cor_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2, "imp_cor_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_cor_amb_victory")
    SetDefeatMusic (ALL, "all_cor_amb_defeat")
    SetVictoryMusic(IMP, "imp_cor_amb_victory")
    SetDefeatMusic (IMP, "imp_cor_amb_defeat")

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
	--Bes1 Platforms
	--Platform Sky
	AddCameraShot(0.793105, -0.062986, -0.603918, -0.047962, -170.583618, 118.981544, -150.443253);
	--Control Room
	AddCameraShot(0.189716, 0.000944, -0.981826, 0.004887, -27.594292, 100.583740, -176.478012);
	--Extractor
	AddCameraShot(0.492401, 0.010387, -0.870113, 0.018354, 19.590666, 100.493599, -47.846901);


end


