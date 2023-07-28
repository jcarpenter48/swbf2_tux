--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 

--  Empire Attacking (attacker is always #1)
IMP = 1
ALL = 2
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
	SetClassProperty("gun_inf_soldier", "WeaponName1", "all_weap_inf_fusioncutter")

    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP4"}
    cp2 = CommandPost:New{name = "CP11"}
    cp3 = CommandPost:New{name = "CP2"}
    cp4 = CommandPost:New{name = "CP1"}
    cp5 = CommandPost:New{name = "CP3"}
    
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
    
    conquest:Start()
 
    EnableSPHeroRules() 
    
 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(600*1024)
    SetPS2ModelMemory(4100000)
    ReadDataFile("ingame.lvl")
	
    --ReadDataFile("sound\\fel.lvl;fel1gcw")
	ReadDataFile("sound\\kas.lvl;kas2gcw")
    ReadDataFile("SIDE\\all.lvl",
                    "all_inf_rifleman",
                    "all_inf_rocketeer",
                    "all_inf_sniper",
                    "all_inf_engineer",
                    "all_inf_officer",
                    "all_inf_wookiee",
					"all_hover_combatspeeder",
					"all_hero_leia",
                    "all_hero_hansolo_tat")
                    
    ReadDataFile("SIDE\\imp.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_engineer",
                    "imp_inf_sniper",
                    "imp_inf_officer",
                    "imp_hero_bobafett",
					"imp_walk_atst",
                    "imp_hover_speederbike", -- no sounds at the moment
                    "imp_inf_dark_trooper")
    
	--no flyer sounds at the mo'
	--ReadDataFile("SIDE\\all.lvl",
    --            "all_fly_xwing_sc")
                
                
    --ReadDataFile("SIDE\\imp.lvl",
    --            "imp_fly_tiefighter_sc")
				

    ReadDataFile("SIDE\\gun.lvl", 
                --"gun_walk_kaadu",
				"gun_inf_soldier")  
				
    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser")          
                
     
    
    SetupTeams{
             
        all = {
            team = ALL,
            units = 20,
            reinforcements = 150,
            soldier  = { "all_inf_rifleman",9, 25},
            assault  = { "all_inf_rocketeer",1, 4},
            engineer = { "all_inf_engineer",1, 4},
            sniper   = { "all_inf_sniper",1, 4},
            officer = {"all_inf_officer",1, 4},
            special = { "all_inf_wookiee",1, 4},
            
        },
        imp = {
            team = IMP,
            units = 20,
            reinforcements = 150,
            soldier  = { "imp_inf_rifleman",9, 25},
            assault  = { "imp_inf_rocketeer",1, 4},
            engineer = { "imp_inf_engineer",1, 4},
            sniper   = { "imp_inf_sniper",1, 4},
            officer = {"imp_inf_officer",1, 4},
            special = { "imp_inf_dark_trooper",1, 4},
        }
     }
    SetHeroClass(IMP, "imp_hero_bobafett")
    SetHeroClass(ALL, "all_hero_leia")
   
   	SetTeamName(3, "locals")
    SetTeamIcon(3, "all_icon")
    AddUnitClass(3, "gun_inf_soldier",6)
    

    SetUnitCount(3, 6)
	AddAIGoal(3, "Deathmatch", 100)
	--[[
	SetTeamAsNeutral(ATT,3)
    SetTeamAsNeutral(3,ATT)
    SetTeamAsNeutral(DEF,3)
    SetTeamAsNeutral(3,DEF)  
	]]--
	SetTeamAsFriend(DEF,3)
    SetTeamAsFriend(3,DEF)
    SetTeamAsEnemy(ATT,3)
    SetTeamAsEnemy(3,ATT)

    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 0) -- 0 droidekas (special case: 0 leg pairs)
           AddWalkerType(1, 2) -- 2 ATSTs
        --    AddWalkerType(2, 0) -- 0 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 0 attes with 3 leg pairs each
        local weaponCnt = 80
        --SetMemoryPoolSize ("Aimer", 60)
        SetMemoryPoolSize ("AmmoCounter", weaponCnt)
        --SetMemoryPoolSize ("BaseHint", 245)
        SetMemoryPoolSize ("EnergyBar", weaponCnt)
        --SetMemoryPoolSize ("EntityCloth", 17)
        SetMemoryPoolSize ("EntityHover",6)
		SetMemoryPoolSize ("EntityWalker",2)
        --SetMemoryPoolSize ("MountedTurret", 5) --this works but is kinda low
		SetMemoryPoolSize ("MountedTurret", 20)
        --SetMemoryPoolSize ("Navigator", 45)
        --SetMemoryPoolSize ("Obstacle", 390)
        --SetMemoryPoolSize ("PathFollower", 45)
        --SetMemoryPoolSize ("PathNode", 128)
        --SetMemoryPoolSize ("SoundSpaceRegion", 34)
        --SetMemoryPoolSize ("TreeGridStack", 180)
        --SetMemoryPoolSize ("UnitAgent", 45)
        --SetMemoryPoolSize ("UnitController", 45)
        SetMemoryPoolSize ("Weapon", weaponCnt)
		SetMemoryPoolSize("EntityFlyer", 4)   

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("nab\\na1.lvl","na1_Conquest")

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
	AudioStreamAppendSegments("sound\\global.lvl", "gun_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    OpenAudioStream("sound\\kas.lvl",  "kas2")
    OpenAudioStream("sound\\kas.lvl",  "kas2")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    -- OpenAudioStream("sound\\pol.lvl",  "pol1_emt")

    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    
    SetOutOfBoundsVoiceOver(ALL, "Allleaving")
    SetOutOfBoundsVoiceOver(IMP, "Impleaving")

    SetAmbientMusic(IMP, 1.0, "imp_kas_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_kas_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2,"imp_kas_amb_end",    2,1)
    SetAmbientMusic(ALL, 1.0, "all_kas_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_kas_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2,"all_kas_amb_end",    2,1)

    SetVictoryMusic(IMP, "imp_kas_amb_victory")
    SetDefeatMusic (IMP, "imp_kas_amb_defeat")
    SetVictoryMusic(ALL, "all_kas_amb_victory")
    SetDefeatMusic (ALL, "all_kas_amb_defeat")

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
	--Nab1 Plains
	--Hill
	AddCameraShot(0.983066, -0.039190, 0.178868, 0.007131, 44.779041, -92.555016, 223.609207);
	--Pillars
	AddCameraShot(0.558071, -0.004864, -0.829747, -0.007232, -99.522423, -104.189438, 102.993027);
	--Center
	AddCameraShot(-0.180345, 0.002299, -0.983521, -0.012535, 38.772453, -105.314598, 24.777697);


end


