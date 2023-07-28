--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 
	
	--  REP Attacking (attacker is always #1)
    REP = 1;
    CIS = 2;
    --  These variables do not change
    ATT = REP;
    DEF = CIS;


function ScriptPostLoad()	   
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "cp1"}
    cp2 = CommandPost:New{name = "cp2"}   
    cp3 = CommandPost:New{name = "cp3"}
    cp4 = CommandPost:New{name = "cp4"}     
    
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
    
    conquest:Start()

    EnableSPHeroRules()
    
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
    StealArtistHeap(1024*1024)
     -- Designers, these two lines *MUST* be first!
    if (ScriptCB_GetPlatform() == "PSP") then 
        SetPSPModelMemory(6000000)
        SetPSPClipper(1)
    end 
	if (ScriptCB_GetPlatform() == "PS2") then 
        SetPS2ModelMemory(6000000)
        --SetPSPClipper(1)
    end 
    --local assetLocation = "addon\\005\\"
    --if (ScriptCB_GetPlatform() == "PC") then 
    --    assetLocation = "DC:"
    --end          
    SetPS2ModelMemory(6000000)
    ReadDataFile("ingame.lvl")
    --ReadDataFile(assetLocation .. "core.lvl")    
    
   
    SetMaxFlyHeight(30)
    SetMaxPlayerFlyHeight (30)
    
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",260)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",260) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",260)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",260)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",2800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",24)     -- should be ~1x #combo       -- should be ~1x #combo
    
    --ReadDataFile("sound\\yav.lvl;yav1cw")
	
	ReadDataFile("sound\\myg.lvl;myg1cw")
	--ReadDataFile("sound\\TDS.lvl;TDS_cw")
    ReadDataFile("SIDE\\rep.lvl",
                "rep_inf_ep3_rifleman",
				--"rep_fly_assault_DOME",
				--"rep_fly_gunship_DOME",
                "rep_inf_ep3_rocketeer",
                "rep_inf_ep3_engineer",
                "rep_inf_ep3_sniper", 
                "rep_hero_cloakedanakin",
                "rep_inf_ep3_jettrooper",
                "rep_inf_ep3_officer")
                
    ReadDataFile("SIDE\\cis.lvl",
                "cis_inf_rifleman",
				--"cis_fly_droidfighter_DOME",
				"cis_inf_rocketeer",
                "cis_inf_engineer",
                "cis_inf_officer",
                "cis_inf_sniper",
                "cis_hero_countdooku",
                "cis_inf_droideka",
                "cis_inf_officer")
                
    --ReadDataFile("SIDE\\tur.lvl", 
    --			"tur_bldg_laser")          
                
    
    SetupTeams{
             
        rep = {
            team = REP,
            units = 16,
            reinforcements = 150,
            soldier  = { "rep_inf_ep3_rifleman",8, 25},
            assault  = { "rep_inf_ep3_rocketeer",1, 4},
            engineer = { "rep_inf_ep3_engineer",1, 4},
            sniper   = { "rep_inf_ep3_sniper",1, 4},
            officer = {"rep_inf_ep3_officer",1, 4},
            special = { "rep_inf_ep3_jettrooper",1, 4},
            
	        
		},
		cis = {
			team = CIS,
			units = 16,
			reinforcements = 150,
			soldier  = { "cis_inf_rifleman",8, 25},
			assault  = { "cis_inf_rocketeer",1, 4},
			engineer = { "cis_inf_engineer",1, 4},
			sniper   = { "cis_inf_sniper",1, 4},
			officer = {"cis_inf_officer",1, 4},
			special = { "cis_inf_droideka",1, 4},
		}
	}
     
    SetHeroClass(CIS, "cis_hero_countdooku")
    SetHeroClass(REP, "rep_hero_cloakedanakin")
   

    --  Level Stats
    --  ClearWalkers()
    AddWalkerType(0, 4) -- special -> droidekas
    AddWalkerType(1, 0) -- 1x2 (1 pair of legs)
    AddWalkerType(2, 0) -- 2x2 (2 pairs of legs)
    AddWalkerType(3, 0) -- 3x2 (3 pairs of legs)
    SetMemoryPoolSize("Aimer", 14)
	SetMemoryPoolSize("EntityCloth", 16)
	SetMemoryPoolSize("EntityFlyer", 6) -- to account for rocket upgrade
    --SetMemoryPoolSize("MountedTurret", 14)
    SetMemoryPoolSize("Obstacle", 157)
    SetMemoryPoolSize("PathNode", 128)
    SetMemoryPoolSize("TreeGridStack", 600)
	SetMemoryPoolSize("UnitAgent", 39)
	SetMemoryPoolSize("UnitController", 39)
	SetMemoryPoolSize("SoldierAnimation", 400)
	
    SetSpawnDelay(10.0, 0.25)
    --ReadDataFile("dc:RAV\\RAV.lvl", "RAV_conquest")
    ReadDataFile("KOR\\kor1.lvl", "PSK_conquest")
    SetDenseEnvironment("false")

   --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\myg.lvl",  "myg1")
    OpenAudioStream("sound\\myg.lvl",  "myg1")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    -- OpenAudioStream("sound\\myg.lvl",  "myg1_emt")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, REP, "cis_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(CIS, "cisleaving")
    SetOutOfBoundsVoiceOver(REP, "repleaving")

    SetAmbientMusic(REP, 1.0, "rep_myg_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_myg_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_myg_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_myg_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_myg_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2,"cis_myg_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_myg_amb_victory")
    SetDefeatMusic (REP, "rep_myg_amb_defeat")
    SetVictoryMusic(CIS, "cis_myg_amb_victory")
    SetDefeatMusic (CIS, "cis_myg_amb_defeat")

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
	AddCameraShot(0.755959, 0.056311, -0.650391, 0.048447, -20.530973, 11.287577, -204.418076);
	AddCameraShot(0.231732, -0.020220, -0.968888, -0.084542, 28.562346, 11.287577, -170.938446);
	AddCameraShot(0.706486, -0.061646, 0.702368, 0.061287, -1.079526, 11.287577, -105.581268);

end

