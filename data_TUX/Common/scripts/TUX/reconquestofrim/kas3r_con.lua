--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 

--  Empire Attacking (attacker is always #1)
IMP = 1
CIS = 2
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
	SetTeamAsFriend(DEF,3)
    SetTeamAsFriend(3,DEF)
    SetTeamAsEnemy(ATT,3)
    SetTeamAsEnemy(3,ATT) 

	SetClassProperty("all_inf_wookiee", "PointsToUnlock", "8")
	--SetClassProperty("all_inf_wookiee", "WeaponName2", "imp_weap_inf_mortar_launcher")
	--SetClassProperty("all_inf_wookiee", "WeaponName4", "imp_weap_inf_remotedroid")
	--fix wookiee rocketeer
	SetClassProperty("wok_inf_rocketeer", "WeaponName1", "imp_weap_inf_rocket_launcher")
	SetClassProperty("wok_inf_rocketeer", "WeaponName3", "imp_weap_award_rocket_launcher")
	SetClassProperty("wok_inf_rocketeer", "WeaponAmmo3", "imp_weap_award_rocket_launcher")
	
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP1"}
    cp2 = CommandPost:New{name = "CP2"}
    cp3 = CommandPost:New{name = "CP3"}
    cp4 = CommandPost:New{name = "CP4"}
    cp5 = CommandPost:New{name = "CP5"}
    cp6 = CommandPost:New{name = "CP10"}
    cp7 = CommandPost:New{name = "CP11"}
    
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

    

--  Empire Attacking (attacker is always #1)
    IMP = ATT
    CIS = DEF
 
    SetMaxFlyHeight(55)
    SetMaxPlayerFlyHeight (55)
    
	--[[SetMemoryPoolSize ("Combo",2)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",26)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",26) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",26)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",80)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",3)     -- should be ~1x #combo
	SetMemoryPoolSize("SoldierAnimation", 220)]]--
    
	ReadDataFile("sound\\kas.lvl;kas2gcw")
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
                    "imp_walk_atst",
                    "imp_hero_bobafett")
                
    ReadDataFile("SIDE\\wok.lvl",
                             "wok_inf_basic")
							 
    --ReadDataFile("SIDE\\tur.lvl", 
    --            "tur_bldg_laser")          
                
     
    
    SetupTeams{

        cis={
            team = CIS,
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
	    --SetMemoryPoolSize("EntityWalker", -1)
        ClearWalkers()
        AddWalkerType(0, 0) -- 0 droidekas (special case: 0 leg pairs)
           AddWalkerType(1, 2)   -- 2 atsts with 2 leg pairs each
        --AddWalkerType(2, 2)
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
        --local weaponCnt = 200
        --SetMemoryPoolSize ("Aimer", 60)
        --SetMemoryPoolSize ("AmmoCounter", weaponCnt)
        --SetMemoryPoolSize ("BaseHint", 245)
        --SetMemoryPoolSize ("EnergyBar", weaponCnt)
        --SetMemoryPoolSize ("EntityCloth", 17)
		SetMemoryPoolSize ("EntityWalker",2)
        --SetMemoryPoolSize ("EntityHover",3)
        --SetMemoryPoolSize ("EntitySoundStatic", 9)
        SetMemoryPoolSize ("MountedTurret", 5)
        --SetMemoryPoolSize ("Navigator", 45)
        --SetMemoryPoolSize ("Obstacle", 390)
        --SetMemoryPoolSize ("PathFollower", 45)
        --SetMemoryPoolSize ("PathNode", 128)
        --SetMemoryPoolSize ("SoundSpaceRegion", 34)
        --SetMemoryPoolSize ("TreeGridStack", 180)
        --SetMemoryPoolSize ("UnitAgent", 45)
        --SetMemoryPoolSize ("UnitController", 45)
        --SetMemoryPoolSize ("Weapon", weaponCnt)
		SetMemoryPoolSize("TentacleSimulator", 30)
		SetMemoryPoolSize("EntityFlyer", 3)   

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("kas\\ks2.lvl","ks2_Conquest")

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

    SetBleedingVoiceOver(CIS, CIS, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(CIS, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, CIS, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

    SetLowReinforcementsVoiceOver(CIS, CIS, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, CIS, "imp_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(CIS, "Allleaving")
    SetOutOfBoundsVoiceOver(IMP, "Impleaving")

    SetAmbientMusic(CIS, 1.0, "all_kas_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "all_kas_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2,"all_kas_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_kas_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_kas_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2,"imp_kas_amb_end",    2,1)

    SetVictoryMusic(CIS, "all_kas_amb_victory")
    SetDefeatMusic (CIS, "all_kas_amb_defeat")
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
	--Kas2 Docks
	--Wide beach shot
	AddCameraShot(0.999802, -0.015964, 0.011840, 0.000189, 113.108002, 1.022731, 269.666748);
	--Dock
	AddCameraShot(0.953681, -0.012084, -0.300552, -0.003808, 19.168949, 2.542728, 119.974800);
	--Platform
	AddCameraShot(0.523602, -0.007785, 0.851833, 0.012665, 262.619171, 16.203047, -53.650951);

	--[[AddUnitClass(CIS, "wok_inf_warrior", 1, 1)

	SetTeamName(3, "locals")
    SetTeamIcon(3, "all_icon")
    AddUnitClass(3, "wok_inf_warrior",4)
    

    SetUnitCount(3, 4)
	AddAIGoal(3, "Deathmatch", 100)
	SetTeamAsNeutral(ATT,3)
    SetTeamAsNeutral(3,ATT)
    SetTeamAsNeutral(DEF,3)
    SetTeamAsNeutral(3,DEF)  ]]--
   --SetTeamName(CIS, "locals")
    --  Alliance Stats
    SetHeroClass(CIS, "all_hero_chewbacca")

    --    Imperial Stats
    SetHeroClass(IMP, "imp_hero_bobafett")
end


