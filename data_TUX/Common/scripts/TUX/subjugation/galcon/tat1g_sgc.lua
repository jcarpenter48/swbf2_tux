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
	--SetTeamAsFriend(1,1)
	--SetTeamAsEnemy(1, 2)
	--SetTeamAsEnemy(2, 1)
	--fix tusken rocketeer
	SetClassProperty("all_inf_rocketeer_jungle", "forcemode", 1)
	SetClassProperty("all_inf_rocketeer_jungle", "GeometryName", "tat_inf_tusken")
	SetClassProperty("all_inf_rocketeer_jungle", "GeometryLowRes", "tat_inf_tusken_low1")
	SetClassProperty("all_inf_rocketeer_jungle", "VOSound", " ")
	SetClassProperty("all_inf_rocketeer_jungle", "HurtSound", "tusken_hurt")
	SetClassProperty("all_inf_rocketeer_jungle", "DeathSound", "tusken_die")
	SetClassProperty("all_inf_rocketeer_jungle", "HidingSound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer_jungle", "ApproachingTargetSound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer_jungle", "FleeSound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer_jungle", "PreparingForDamageSound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer_jungle", "HeardEnemySound", "tusken_chatter")
	SetClassProperty("all_inf_rocketeer_jungle", "VOUnitType", 173)
	--SetClassProperty("all_inf_rocketeer_jungle", "FoleyFXClass", "rep_inf_soldier")
	
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
    
    --[[SetMemoryPoolSize ("Combo",3)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",50)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",50) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",50)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",400)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",4000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",5)     -- should be ~1x #combo]]--
	SetMemoryPoolSize("SoldierAnimation", 400)
	
	SetGroundFlyerMap(1)
	
	ReadDataFile("sound\\TatMusicFix.lvl")
    --ReadDataFile("sound\\yav.lvl;yav1gcw")
	ReadDataFile("sound\\TDS.lvl;TDS_gcw")
    ReadDataFile("sound\\tat.lvl;tat2gcw")
	ReadDataFile("sound\\TatMusicFix.lvl")
    ReadDataFile("SIDE\\all_256.lvl",
                    "all_inf_rifleman",
                    "all_inf_rocketeer",
					"all_inf_rocketeer_jungle",
                    "all_inf_sniper",
                    "all_inf_engineer",
                    "all_inf_officer",
                    "all_inf_wookiee",
					--"rep_hero_obiwan",
					"all_hover_combatspeeder")
                    
    ReadDataFile("SIDE\\imp_256.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_engineer",
                    "imp_inf_sniper",
                    "imp_inf_officer",
                    --"imp_hero_darthvader",
					"imp_hero_guard",
					"imp_hero_bobafett",
					"imp_hover_fightertank",
                    "imp_hover_speederbike",
                    "imp_inf_dark_trooper")
    
	--flyer sounds at the mo'
	ReadDataFile("SIDE\\all_256.lvl",
                "all_fly_xwing_sc")
                
                
    ReadDataFile("SIDE\\imp_256.lvl",
                "imp_fly_tiefighter_sc")
	
	--ReadDataFile("SIDE\\rep.lvl", 
    --            "rep_hero_obiwan") 
				
	ReadDataFile("SIDE\\des.lvl",
						 "tat_inf_jawa")			
    ReadDataFile("SIDE\\des.lvl",
                             "tat_inf_tuskenraider",
                             "tat_inf_tuskenhunter")
				
    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser")          
                
     
    
    SetupTeams{
             
        all = {
            team = ALL,
            units = 12,
            reinforcements = 150,
            soldier  = { "tat_inf_tuskenraider",4, 7},
            assault  = { "all_inf_rocketeer_jungle",1, 4},
            engineer = { "tat_inf_jawa",1, 4},
            sniper   = { "tat_inf_tuskenhunter",1, 4},
            --officer = {"all_inf_officer",1, 4},
            --special = { "all_inf_wookiee",1, 4},
            
        },
        imp = {
            team = IMP,
            units = 20,
            reinforcements = 150,
            soldier  = { "imp_inf_rifleman",9, 20},
            assault  = { "imp_inf_rocketeer",1, 4},
            engineer = { "imp_inf_engineer",1, 4},
            sniper   = { "imp_inf_sniper",1, 4},
            officer = {"imp_inf_officer",1, 4},
            special = { "imp_inf_dark_trooper",1, 4},
        }
     }
	if ((profileName1 == "tusken") or (profileName2 == "tusken") or (profileName3 == "tusken") or (profileName4 == "tusken")) then
		AddUnitClass(1, "tat_inf_tuskenraider", 1, 1);
		--AddUnitClass(2, "tat_inf_tuskenraider", 1, 1);
	end --ALL ADD UNIT CLASSES MUST COME BEFORE SETTING HERO CLASSES
    --SetHeroClass(IMP, "imp_hero_darthvader")
	SetHeroClass(IMP, "imp_hero_guard")
    SetHeroClass(ALL, "imp_hero_bobafett")

	--SetTeamName(2, "locals")
	
	SetTeamName(3, "Alliance")
    AddUnitClass(3, "all_inf_rifleman", 6);
    AddUnitClass(3, "all_inf_rocketeer", 2);
	AddUnitClass(3, "all_inf_sniper", 2);
	AddUnitClass(3, "all_inf_engineer", 2);
	AddUnitClass(3, "all_inf_officer", 1);
	AddUnitClass(3, "all_inf_wookiee", 1);
    SetUnitCount(3, 18)
	AddAIGoal(3, "Conquest", 100)
   
  	SetTeamAsEnemy(3, 1)
    SetTeamAsEnemy(1, 3)
    SetTeamAsEnemy(3, 2)
    SetTeamAsEnemy(2, 3)

    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 0) -- 3 droidekas (special case: 0 leg pairs)
        --   AddWalkerType(1, 3) 
        --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
        local weaponCnt = 80
        --SetMemoryPoolSize ("Aimer", 60)
        SetMemoryPoolSize ("AmmoCounter", weaponCnt)
        --SetMemoryPoolSize ("BaseHint", 245)
        SetMemoryPoolSize ("EnergyBar", weaponCnt)
        --SetMemoryPoolSize ("EntityCloth", 17)
        --SetMemoryPoolSize ("EntityHover",5)
        SetMemoryPoolSize("EntitySoundStream", 2)
		SetMemoryPoolSize("EntitySoundStatic", 43)
        --SetMemoryPoolSize ("MountedTurret", 5) --these work but are kinda low
		SetMemoryPoolSize ("EntityHover",12)
        SetMemoryPoolSize ("MountedTurret", 12)
        --SetMemoryPoolSize ("Navigator", 45)
        --SetMemoryPoolSize ("Obstacle", 390)
        --SetMemoryPoolSize ("PathFollower", 45)
        --SetMemoryPoolSize ("PathNode", 128)
       -- SetMemoryPoolSize ("SoundSpaceRegion", 34)
       -- SetMemoryPoolSize ("TreeGridStack", 180)
       -- SetMemoryPoolSize ("UnitAgent", 45)
       -- SetMemoryPoolSize ("UnitController", 45)
        SetMemoryPoolSize ("Weapon", weaponCnt)
		SetMemoryPoolSize("EntityFlyer", 6)   

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("tat\\tds.lvl","tds_Conquest")
    --AddDeathRegion("Sarlac01")
    SetMaxFlyHeight(125)
    SetMaxPlayerFlyHeight(125)
    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "des_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    OpenAudioStream("sound\\tat.lvl",  "tat2")
    OpenAudioStream("sound\\tat.lvl",  "tat2")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")

    --SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    --SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

    --SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    --SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)

    --SetOutOfBoundsVoiceOver(ALL, "Allleaving")
    SetOutOfBoundsVoiceOver(IMP, "Impleaving")

    SetAmbientMusic(ALL, 1.0, "all_tat_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_tat_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2, "all_tat_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_tat_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_tat_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2, "imp_tat_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_tat_amb_victory")
    SetDefeatMusic (ALL, "all_tat_amb_defeat")
    SetVictoryMusic(IMP, "imp_tat_amb_victory")
    SetDefeatMusic (IMP, "imp_tat_amb_defeat")

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


