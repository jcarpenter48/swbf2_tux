--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 

local profileName1 = ScriptCB_ununicode(ScriptCB_GetCurrentProfileName(1))
local profileName2 = ScriptCB_ununicode(ScriptCB_GetCurrentProfileName(2))
local profileName3 = ScriptCB_ununicode(ScriptCB_GetCurrentProfileName(3))
local profileName4 = ScriptCB_ununicode(ScriptCB_GetCurrentProfileName(4))
--  Empire Attacking (attacker is always #1)
CIS = 2
REP = 1
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
	--SetTeamAsFriend(1,1)
	--SetTeamAsEnemy(1, 2)
	--SetTeamAsEnemy(2, 1)
	--fix tusken rocketeer
	SetClassProperty("all_inf_rocketeer", "forcemode", 1)
	SetClassProperty("all_inf_rocketeer", "GeometryName", "tat_inf_tusken")
	SetClassProperty("all_inf_rocketeer", "GeometryLowRes", "tat_inf_tusken_low1")
	SetClassProperty("all_inf_rocketeer", "VOSound", " ")
	SetClassProperty("all_inf_rocketeer", "HurtSound", "tusken_hurt")
	SetClassProperty("all_inf_rocketeer", "DeathSound", "tusken_die")
	SetClassProperty("all_inf_rocketeer", "HidingSound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer", "ApproachingTargetSound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer", "FleeSound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer", "PreparingForDamageSound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer", "HeardEnemySound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer", "VOUnitType", 173)
	SetClassProperty("all_inf_rocketeer", "WeaponName1", "rep_weap_inf_rocket_launcher")
	SetClassProperty("all_inf_rocketeer", "WeaponName2", "rep_weap_inf_pistol")
	SetClassProperty("all_inf_rocketeer", "WeaponName3", "rep_weap_inf_thermaldetonator")
	SetClassProperty("all_inf_rocketeer", "WeaponName4", "rep_weap_inf_mine_dispenser")
	SetClassProperty("all_inf_rocketeer", "WeaponName5", "rep_weap_award_pistol")
	SetClassProperty("all_inf_rocketeer", "WeaponName6", "rep_weap_award_rocket_launcher")
	SetClassProperty("all_inf_rocketeer", "FoleyFXClass", "rep_inf_soldier")
	
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP2"}
    cp2 = CommandPost:New{name = "CP7"}
    cp3 = CommandPost:New{name = "CP10"}
    cp4 = CommandPost:New{name = "CP1"}
    cp5 = CommandPost:New{name = "CP3"}
    cp6 = CommandPost:New{name = "CP4"}
 
	SetProperty("CP1", "Team", "2")
    SetProperty("CP3", "Team", "2")
    SetProperty("CP2", "Team", "3")
    SetProperty("CP7", "Team", "3")
	
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
    
	local numPlayers = ScriptCB_GetNumCameras() --better than checking number of plugged in controllers
    local isMultiplayer = ScriptCB_InMultiplayer() --I prefer checking once than for each if-block
	
    --SetMemoryPoolSize ("Combo",3)              -- should be ~ 2x number of jedi classes
    --SetMemoryPoolSize ("Combo::State",50)      -- should be ~12x #Combo
    --SetMemoryPoolSize ("Combo::Transition",50) -- should be a bit bigger than #Combo::State
    --SetMemoryPoolSize ("Combo::Condition",50)  -- should be a bit bigger than #Combo::State
    --SetMemoryPoolSize ("Combo::Attack",400)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",1000)  -- should be ~8-12x #Combo::Attack
    --SetMemoryPoolSize ("Combo::Deflect",5)     -- should be ~1x #combo
	SetMemoryPoolSize("SoldierAnimation", 450)
	
	SetGroundFlyerMap(1)
	
	ReadDataFile("sound\\TatMusicFix.lvl")
    --ReadDataFile("sound\\yav.lvl;yav1cw")
	ReadDataFile("sound\\tat.lvl;tat2cw")
    ReadDataFile("sound\\TDS.lvl;TDS_cw")
	ReadDataFile("sound\\TatMusicFix.lvl")
	
	ReadDataFile("SIDE\\rep_256.lvl",
				"rep_inf_ep3_rifleman",
				"rep_inf_ep3_rocketeer",
				"rep_inf_ep3_engineer",
				"rep_inf_ep3_sniper", 
				"rep_inf_ep3_officer",
				"rep_hover_barcspeeder",
				"rep_hover_fightertank",
				"rep_hero_kiyadimundi",
				"rep_inf_ep3_jettrooper")
	ReadDataFile("SIDE\\all_256.lvl",
				"all_inf_rocketeer")  --tusken rocketeer
				
	ReadDataFile("SIDE\\cis_256.lvl",
				"cis_inf_marine",
				--"cis_inf_rocketeer",
				"cis_inf_engineer",
				"cis_inf_sniper",
				"cis_inf_officer",
				"cis_inf_droideka",
				--"cis_hero_darthmaul",
				"cis_hero_jangofett",
				"Cis_hover_stap",
				"cis_hover_aat")
				
		-- flyer sounds at the mo'
	ReadDataFile("SIDE\\rep_256.lvl",
                "rep_fly_arc170fighter_sc")   
    ReadDataFile("SIDE\\cis_256.lvl",
                "cis_fly_droidfighter_sc")	
				
	ReadDataFile("SIDE\\des.lvl",
						 "tat_inf_jawa")			
    ReadDataFile("SIDE\\des.lvl",
                             "tat_inf_tuskenraider",
                             "tat_inf_tuskenhunter")
				
    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser")          
                
     
    
    SetupTeams{
             
        rep = {
            team = REP,
            units = 18,
            reinforcements = 150,
            soldier  = { "rep_inf_ep3_rifleman",9, 20},
            assault  = { "rep_inf_ep3_rocketeer",1, 4},
            engineer = { "rep_inf_ep3_engineer",1, 4},
            sniper   = { "rep_inf_ep3_sniper",1, 4},
            officer = {"rep_inf_ep3_officer",1, 4},
            special = { "rep_inf_ep3_jettrooper",1, 4},
            
        },
        cis = {
            team = CIS,
            units = 12,
            reinforcements = 150,
            soldier  = { "tat_inf_tuskenraider",4, 7},
            assault  = { "all_inf_rocketeer",1, 4},
            engineer = { "tat_inf_jawa",1, 4},
            sniper   = { "tat_inf_tuskenhunter",1, 4},
            --officer = {"cis_inf_officer",1, 4},
            --special = { "cis_inf_droideka",1, 4},
        }
     }
	
	if ((profileName1 == "tusken") or (profileName2 == "tusken") or (profileName3 == "tusken") or (profileName4 == "tusken")) then
		AddUnitClass(1, "tat_inf_tuskenraider", 1, 1);
		--AddUnitClass(2, "tat_inf_tuskenraider", 1, 1);
	end
	
    SetHeroClass(2, "cis_hero_jangofett")
    SetHeroClass(REP, "rep_hero_kiyadimundi")

	--SetTeamName(2, "locals")
	
	SetTeamName(3, "CIS")
    AddUnitClass(3, "cis_inf_marine", 6);
    AddUnitClass(3, "cis_inf_engineer", 2);
	AddUnitClass(3, "cis_inf_sniper", 2);
	AddUnitClass(3, "cis_inf_officer", 2);
	AddUnitClass(3, "cis_inf_droideka", 2);
    SetUnitCount(3, 18)
	AddAIGoal(3, "Conquest", 100)
   
	--SetTeamAsEnemy(2, 1)
	--SetTeamAsNeutral(1, 2)
	--SetTeamAsNeutral(2, 2)
  	SetTeamAsEnemy(3, 1)
    SetTeamAsEnemy(1, 3)
    SetTeamAsEnemy(3, 2)
    SetTeamAsEnemy(2, 3)

    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 3) -- 3 droidekas (special case: 0 leg pairs)
        --   AddWalkerType(1, 3) 
        --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
        local weaponCnt = 96
        SetMemoryPoolSize ("Aimer", 60)
        SetMemoryPoolSize ("AmmoCounter", weaponCnt)
        SetMemoryPoolSize ("BaseHint", 245)
        SetMemoryPoolSize ("EnergyBar", weaponCnt)
        SetMemoryPoolSize ("EntityCloth", 17)
        --SetMemoryPoolSize ("EntityHover",5)
        SetMemoryPoolSize("EntitySoundStream", 2)
		SetMemoryPoolSize("EntitySoundStatic", 43)
        --SetMemoryPoolSize ("MountedTurret", 5) --these work but are kinda low
		SetMemoryPoolSize ("EntityHover",12)
        SetMemoryPoolSize ("MountedTurret", 12)
        SetMemoryPoolSize ("Navigator", 45)
        SetMemoryPoolSize ("Obstacle", 390)
        SetMemoryPoolSize ("PathFollower", 45)
        SetMemoryPoolSize ("PathNode", 128)
        --SetMemoryPoolSize ("SoundSpaceRegion", 34)
        SetMemoryPoolSize ("TentacleSimulator", 0)
        SetMemoryPoolSize ("TreeGridStack", 180)
        SetMemoryPoolSize ("UnitAgent", 45)
        SetMemoryPoolSize ("UnitController", 45)
        SetMemoryPoolSize ("Weapon", weaponCnt)
		SetMemoryPoolSize("EntityFlyer", 6)   

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("tat\\tds.lvl","tds_Conquest")
    --AddDeathRegion("Sarlac01")
    SetMaxFlyHeight(125)
    SetMaxPlayerFlyHeight(125)
    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "des_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)     
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\tat.lvl",  "tat2")
    OpenAudioStream("sound\\tat.lvl",  "tat2")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
   -- SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    --SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)
    --SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
    --SetLowReinforcementsVoiceOver(CIS, REP, "cis_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(1, "repleaving")
    --SetOutOfBoundsVoiceOver(2, "cisleaving")

    SetAmbientMusic(REP, 1.0, "rep_tat_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_tat_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_tat_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_tat_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_tat_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2,"cis_tat_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_tat_amb_victory")
    SetDefeatMusic (REP, "rep_tat_amb_defeat")
    SetVictoryMusic(CIS, "cis_tat_amb_victory")
    SetDefeatMusic (CIS, "cis_tat_amb_defeat")

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
	--Tat 1 - Dune Sea
	--Crawler
	AddCameraShot(-0.404895, 0.000992, -0.914360, -0.002240, -85.539894, 20.536297, 141.699493);
	--Homestead
	AddCameraShot(0.040922, 0.004049, -0.994299, 0.098381, -139.729523, 17.546598, -34.360893);
	--Sarlac Pit
	AddCameraShot(-0.312360, 0.016223, -0.948547, -0.049263, -217.381485, 20.150953, 54.514324);


end


