--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
Conquest = ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 

--  Empire Attacking (attacker is always #1)
ALL = 2
IMP = 1
GAR = 3
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
	SetClassProperty("gun_inf_soldier", "WeaponName1", "imp_weap_inf_fusioncutter")
	SetClassProperty("gun_inf_defender", "WeaponName1", "imp_weap_inf_fusioncutter")
	SetClassProperty("gun_inf_soldier", "FoleyFXClass", "all_inf_soldier")
	SetClassProperty("gun_inf_defender", "FoleyFXClass", "all_inf_soldier")
	SetClassProperty("gar_inf_soldier", "FoleyFXClass", "all_inf_soldier")
	SetClassProperty("gar_inf_vanguard", "FoleyFXClass", "all_inf_soldier")
	SetClassProperty("gar_inf_pilot", "FoleyFXClass", "all_inf_soldier")
	SetClassProperty("gar_inf_naboo_queen", "FoleyFXClass", "all_inf_soldier")
	SetClassProperty("gar_inf_vanguard", "WeaponName3", "imp_weap_inf_thermaldetonator")
	SetClassProperty("gar_inf_vanguard", "WeaponAmmo3", 2)
	SetClassProperty("gar_inf_vanguard", "WeaponChannel3", 1)
	SetClassProperty("gar_inf_vanguard", "WeaponName4", "imp_weap_inf_mine_dispenser")
	SetClassProperty("gar_inf_vanguard", "WeaponAmmo4", 3)
	SetClassProperty("gar_inf_vanguard", "WeaponChannel4", 1)
	SetClassProperty("gar_inf_pilot", "WeaponName3", "imp_weap_inf_detpack")
	SetClassProperty("gar_inf_pilot", "WeaponAmmo3", 3)
	SetClassProperty("gar_inf_pilot", "WeaponChannel3", 1)
	SetClassProperty("gar_inf_pilot", "WeaponName4", "imp_weap_inf_powerup_dispenser")
	SetClassProperty("gar_inf_pilot", "WeaponAmmo4", 5)
	SetClassProperty("gar_inf_pilot", "WeaponChannel4", 1)
	
	
	DisableBarriers("camveh")
	DisableBarriers("turbar1")
	DisableBarriers("turbar2")
	DisableBarriers("turbar3")
			DisableBarriers("cambar1")
		DisableBarriers("cambar2")
		DisableBarriers("cambar3")

    SetMapNorthAngle(180, 1)
    
    

	
	AICanCaptureCP("CP1", GAR, false)
	AICanCaptureCP("CP2", GAR, false)
	AICanCaptureCP("CP3", GAR, false)
	AICanCaptureCP("CP4", GAR, false)
	AICanCaptureCP("CP5", GAR, false)
	AICanCaptureCP("CP6", GAR, false)

	
	AddAIGoal (GAR, "Deathmatch", 100)


 --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP1"}
    cp2 = CommandPost:New{name = "CP2"}
    cp3 = CommandPost:New{name = "CP3"}
    cp4 = CommandPost:New{name = "CP4"}
    cp5 = CommandPost:New{name = "CP5"}
    cp6 = CommandPost:New{name = "CP6"}
    
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
    
    conquest:Start()
    EnableSPHeroRules()
    
end

function ScriptInit()
    StealArtistHeap(1800*1024)
    -- Designers, these two lines *MUST* be first!
    SetPS2ModelMemory(2097152 + 65536 * 10)
    ReadDataFile("ingame.lvl")

    


    

    ReadDataFile("sound\\nab.lvl;nab2gcw")
     --ReadDataFile("SIDE\\all.lvl",
                    --"all_inf_rifleman",
                    --"all_inf_rocketeer",
                    --"all_inf_engineer",
                    --"all_inf_sniper",
                    --"all_inf_officer",
                    --"all_inf_wookiee")
    --ReadDataFile("SIDE\\all.lvl", "all_hover_combatspeeder")
	ReadDataFile("SIDE\\gian.lvl", "all_hover_combatspeeder")
        
     ReadDataFile("SIDE\\imp.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_engineer",
                    "imp_inf_sniper",
                    "imp_inf_officer",
                    "imp_inf_dark_trooper",                   
                    "imp_hero_emperor",
                    "imp_hover_fightertank")
                    
    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser") 
                
	ReadDataFile("SIDE\\gar.lvl",
				 "gar_inf_soldier",
				 --"gar_inf_pilot", --not in vanilla lvl
				 "gar_inf_vanguard")			 		
	ReadDataFile("SIDE\\gar_fix.lvl", "gar_inf_pilot")			 
	ReadDataFile("SIDE\\gar.lvl", "gar_inf_naboo_queen")
	ReadDataFile("SIDE\\gun.lvl",
				"gun_inf_defender",
				"gun_inf_soldier")
    

   -- set up teams
    SetupTeams{
        imp = {
            team = IMP,
            units = 22,
            reinforcements = 150,
            soldier  = { "imp_inf_rifleman",9, 25},
            assault  = { "imp_inf_rocketeer",1, 4},
            engineer = { "imp_inf_engineer",1, 4},
            sniper   = { "imp_inf_sniper",1, 4},
            officer = {"imp_inf_officer",1, 4},
            special = { "imp_inf_dark_trooper",1, 4},
        }
    }
    
    SetupTeams{
        all = {
            team = ALL,
            units = 22,
            reinforcements = 150,
            soldier  = { "gar_inf_soldier",9, 25},
            assault  = { "gar_inf_vanguard",1, 4},
            engineer = { "gar_inf_pilot",1, 4},
            sniper   = { "gun_inf_defender",1, 4},
            officer = {"gun_inf_soldier",1, 4},
            --special = { "gar_inf_naboo_queen",0, 1},
        }
    }
    
--    SetupTeams{
--        gar = {
--            team = GAR,
--            units = 5,
--            reinforcements = -1,
--           soldier  = { "gar_inf_soldier",6},
--            assault  = { "gar_inf_vanguard",5},
--        }
--    }


	--SetTeamName(ALL, "locals")
    SetHeroClass(ALL, "gar_inf_naboo_queen")
    
    SetHeroClass(IMP, "imp_hero_emperor")
         
    
--    SetTeamAsEnemy(GAR, ATT)
--    SetTeamAsEnemy(ATT, GAR)
--       
--    
--    SetTeamAsFriend(GAR, DEF)
--    SetTeamAsFriend(DEF, GAR)
    
    
    --  Level Stats
    ClearWalkers()
    AddWalkerType(1, 0) -- 0 atsts with 1 leg pairs each
    local weaponCnt = 240
    SetMemoryPoolSize("Aimer", 35)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 128)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth", 24)
    SetMemoryPoolSize("EntityHover", 4)
    SetMemoryPoolSize("EntitySoundStream", 1)
    SetMemoryPoolSize("EntitySoundStatic", 45)
    SetMemoryPoolSize("MountedTurret", 17)
    SetMemoryPoolSize("Navigator", 55)
    SetMemoryPoolSize("Obstacle", 450)
    SetMemoryPoolSize("PathNode", 100)
    SetMemoryPoolSize("ShieldEffect", 0)
    SetMemoryPoolSize("TentacleSimulator", 8)
    SetMemoryPoolSize("TreeGridStack", 325)
    SetMemoryPoolSize("UnitAgent", 55)
    SetMemoryPoolSize("UnitController", 55)
    SetMemoryPoolSize("Weapon", weaponCnt)
	SetMemoryPoolSize("EntityFlyer", 6)   

    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("NAB\\nab2.lvl","naboo2_Conquest")
    SetDenseEnvironment("true")
    --AddDeathRegion("Water")
    AddDeathRegion("Waterfall")
    --SetMaxFlyHeight(20)

    

    --  Sound
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "gun_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\nab.lvl",  "nab2")
    OpenAudioStream("sound\\nab.lvl",  "nab2")
    OpenAudioStream("sound\\nab.lvl",  "nab2_emt")

    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing", 1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing", 1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(2, "allleaving")
    SetOutOfBoundsVoiceOver(1, "impleaving")

    SetAmbientMusic(ALL, 1.0, "all_nab_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_nab_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2,"all_nab_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_nab_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_nab_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2,"imp_nab_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_nab_amb_victory")
    SetDefeatMusic (ALL, "all_nab_amb_defeat")
    SetVictoryMusic(IMP, "imp_nab_amb_victory")
    SetDefeatMusic (IMP, "imp_nab_amb_defeat")

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
    --Nab2 Theed
    --Palace
AddCameraShot(0.038177, -0.005598, -0.988683, -0.144973, -0.985535, 18.617458, -123.316505);
    AddCameraShot(0.993106, -0.109389, 0.041873, 0.004612, 6.576932, 24.040697, -25.576218);
    AddCameraShot(0.851509, -0.170480, 0.486202, 0.097342, 158.767715, 22.913860, -0.438658);
    AddCameraShot(0.957371, -0.129655, -0.255793, -0.034641, 136.933548, 20.207420, 99.608246);
    AddCameraShot(0.930364, -0.206197, 0.295979, 0.065598, 102.191856, 22.665434, 92.389435);
    AddCameraShot(0.997665, -0.068271, 0.002086, 0.000143, 88.042351, 13.869274, 93.643898);
    AddCameraShot(0.968900, -0.100622, 0.224862, 0.023352, 4.245263, 13.869274, 97.208542);
    AddCameraShot(0.007091, -0.000363, -0.998669, -0.051089, -1.309990, 16.247049, 15.925866);
    AddCameraShot(-0.274816, 0.042768, -0.949121, -0.147705, -55.505108, 25.990822, 86.987534);
    AddCameraShot(0.859651, -0.229225, 0.441156, 0.117634, -62.493008, 31.040747, 117.995369);
    AddCameraShot(0.703838, -0.055939, 0.705928, 0.056106, -120.401054, 23.573559, -15.484946);
    AddCameraShot(0.835474, -0.181318, -0.506954, -0.110021, -166.314774, 27.687098, -6.715797);
    AddCameraShot(0.327573, -0.024828, -0.941798, -0.071382, -109.700180, 15.415476, -84.413605);
    AddCameraShot(-0.400505, 0.030208, -0.913203, -0.068878, 82.372711, 15.415476, -42.439548);
end
