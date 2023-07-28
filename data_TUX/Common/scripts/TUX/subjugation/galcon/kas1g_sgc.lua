--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 

--  Empire Attacking (attacker is always #1)
ALL = 2
IMP = 1
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
	SetClassProperty("all_inf_wookiee", "PointsToUnlock", "8")
	--SetClassProperty("all_inf_wookiee", "WeaponName2", "imp_weap_inf_mortar_launcher")
	--SetClassProperty("all_inf_wookiee", "WeaponName4", "imp_weap_inf_remotedroid")
	--fix wookiee rocketeer
	SetClassProperty("wok_inf_rocketeer", "WeaponName1", "imp_weap_inf_rocket_launcher")
	SetClassProperty("wok_inf_rocketeer", "WeaponName3", "imp_weap_award_rocket_launcher")
	SetClassProperty("wok_inf_rocketeer", "WeaponAmmo3", "imp_weap_award_rocket_launcher")
	
	
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP4"}
    cp2 = CommandPost:New{name = "CP6"}
    cp3 = CommandPost:New{name = "CP5"}
    cp4 = CommandPost:New{name = "CP2"}
    cp5 = CommandPost:New{name = "CP3"}
    
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
    
    conquest:Start()
 
    EnableSPHeroRules()
    
    
 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(600*1024)
    SetPS2ModelMemory(4100000)
    ReadDataFile("ingame.lvl")

    

--  Alliance Attacking (attacker is always #1)
    CIS = ATT
    REP = DEF
 
    SetMaxFlyHeight(55)
    SetMaxPlayerFlyHeight (55)
    
	--[[SetMemoryPoolSize ("Combo",3)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",50)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",50) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",50)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",400)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",4000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",5)     -- should be ~1x #combo]]--
	--SetMemoryPoolSize("SoldierAnimation", 600)
    
    ReadDataFile("sound\\kas1.lvl;kas2gcw")
    ReadDataFile("SIDE\\all_256.lvl",
                    --"all_inf_rifleman_jungle",
                    --"all_inf_rocketeer_jungle",
                    --"all_inf_sniper_jungle",
                    --"all_inf_engineer",
                    --"all_inf_officer",
                    --"all_hover_combatspeeder",
                    "all_hero_chewbacca",
                    "all_inf_wookiee")
    ReadDataFile("SIDE\\imp_256.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_engineer",
                    "imp_inf_sniper",
                    "imp_inf_dark_trooper",
                    --"imp_hover_fightertank",
                    --"imp_hover_speederbike",
                    "imp_inf_officer",
                    --"imp_walk_atst",
                    "imp_hero_bobafett")
                
	ReadDataFile("SIDE\\wok.lvl",
                             "wok_inf_basic")
							 
    --ReadDataFile("SIDE\\tur.lvl", 
    --            "tur_bldg_laser")          
    ReadDataFile("SIDE\\all_256.lvl",
                "all_fly_xwing_sc")
                
                
    ReadDataFile("SIDE\\imp_256.lvl",
                "imp_fly_tiefighter_sc")            
     
    
    SetupTeams{

        all={
            team = ALL,
            units = 18,
            reinforcements = 150,
			soldier  = { "wok_inf_warrior",1, 25},
			assault  = { "wok_inf_rocketeer",1, 8},
			engineer  = { "wok_inf_mechanic",1, 8},
			officer = {"all_inf_wookiee",1, 4},
            --sniper  = {"all_inf_sniper_jungle",1, 4},
            --special = {"all_inf_officer",1, 4},
            
        },
        
        imp={
            team = IMP,
            units = 18,
            reinforcements = 150,
            soldier = {"imp_inf_rifleman",10, 25},
            assault = {"imp_inf_rocketeer",1, 4},
            engineer = {"imp_inf_engineer",1, 4},
            sniper  = {"imp_inf_sniper",1, 4},
            officer = {"imp_inf_officer",1, 4},
            special = {"imp_inf_dark_trooper",1, 4},
        }
    }
    

    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 0) -- 0 droidekas (special case: 0 leg pairs)
        --   AddWalkerType(1, 3) 
        --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
        local weaponCnt = 60
        --SetMemoryPoolSize ("Aimer", 60)
        SetMemoryPoolSize ("AmmoCounter", weaponCnt)
       -- SetMemoryPoolSize ("BaseHint", 245)
        SetMemoryPoolSize ("EnergyBar", weaponCnt)
        --SetMemoryPoolSize ("EntityCloth", 17)
        SetMemoryPoolSize ("EntityHover",1)
        SetMemoryPoolSize("EntitySoundStream", 2)
		SetMemoryPoolSize("EntitySoundStatic", 43)
        SetMemoryPoolSize ("MountedTurret", 4)
        --SetMemoryPoolSize ("Navigator", 45)
       -- SetMemoryPoolSize ("Obstacle", 390)
       -- SetMemoryPoolSize ("PathFollower", 45)
        --SetMemoryPoolSize ("PathNode", 128)
        --SetMemoryPoolSize ("SoundSpaceRegion", 34)
        --SetMemoryPoolSize ("TentacleSimulator", 0)
        --SetMemoryPoolSize ("TreeGridStack", 180)
       -- SetMemoryPoolSize ("UnitAgent", 45)
       -- SetMemoryPoolSize ("UnitController", 45)
        SetMemoryPoolSize ("Weapon", weaponCnt)
		SetMemoryPoolSize("TentacleSimulator", 30)
		SetMemoryPoolSize("EntityFlyer", 6)   

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("kas\\ks1.lvl","ks1_Conquest")

--  Sound
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "wok_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick) 
    AudioStreamAppendSegments("sound\\global.lvl", "wok_unit_vo_quick", voiceQuick)
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\kas.lvl",  "kas")
    OpenAudioStream("sound\\kas.lvl",  "kas")

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

    SetAmbientMusic(ALL, 1.0, "all_kas_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_kas_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2,"all_kas_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_kas_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_kas_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2,"imp_kas_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_kas_amb_victory")
    SetDefeatMusic (ALL, "all_kas_amb_defeat")
    SetVictoryMusic(IMP, "imp_kas_amb_victory")
    SetDefeatMusic (IMP, "imp_kas_amb_defeat")

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
	--Kas 1 Islands
	--Huts
	AddCameraShot(-0.421137, 0.025737, -0.904943, -0.055304, 216.391846, -19.422512, -249.231918);
	--Grand Hut
	AddCameraShot(0.701411, 0.037622, -0.710742, 0.038123, 49.056309, -29.080774, -87.605171);
	--Huts
	AddCameraShot(0.916854, -0.005262, 0.399181, 0.002291, 222.269363, -30.438093, -130.609543);

	--[[AddUnitClass(ALL, "wok_inf_warrior", 1, 1)

	SetTeamName(3, "locals")
    SetTeamIcon(3, "all_icon")
    AddUnitClass(3, "wok_inf_warrior",4)
    

    SetUnitCount(3, 4)
	AddAIGoal(3, "Deathmatch", 100)
	SetTeamAsNeutral(ATT,3)
    SetTeamAsNeutral(3,ATT)
    SetTeamAsNeutral(DEF,3)
    SetTeamAsNeutral(3,DEF)]]--  
   --SetTeamName(ALL, "locals")
    --  Alliance Stats
    SetHeroClass(ALL, "all_hero_chewbacca")

    --    Imperial Stats
    SetHeroClass(IMP, "imp_hero_bobafett")
end


