--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams") 
	
	--  Sith Empire Attacking (attacker is always #1)
    REP = 2;
    IMP = 1;
    --  These variables do not change
    ATT = IMP;
    DEF = REP;


function ScriptPostLoad()	     
	EnableSPHeroRules()
    --This sets up the actual objective.  This needs to happen after cp's are defined
	hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2,
						pointsPerKillATT = 1, pointsPerKillDEF = 1,
						textATT = "level.STC.objectives.hunt.DEF",
						textDEF = "level.STC.objectives.hunt.ATT", hideCPs = true, multiplayerRules = true}	
	hunt:Start()
	
	AddAIGoal(ATT, "Deathmatch", 1000)
	AddAIGoal(DEF, "Deathmatch", 1000)
    
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
    local assetLocation = "addon\\005\\"
    if (ScriptCB_GetPlatform() == "PC") then 
        assetLocation = "DC:"
    end          
    SetPS2ModelMemory(6000000)
    ReadDataFile(assetLocation .. "kotoricons.lvl") 
    ReadDataFile("ingame.lvl")
    ReadDataFile(assetLocation .. "core.lvl")    
    
   
    SetMaxFlyHeight(70)
    SetMaxPlayerFlyHeight (70)
    
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",50)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",650)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",650) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",650)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",550)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",6000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",100)     -- should be ~1x #combo  

    ReadDataFile("sound\\tat.lvl;tat2gcw")

    ReadDataFile(assetLocation .. "SIDE\\orp.lvl",
                             "jed_knight_01",
                             "jed_master_01",
                             "jed_sith_01")
    --ReadDataFile(assetLocation .. "SIDE\\sion.lvl",
    --                         "sith_hero_sion")                             
        
    SetupTeams{
        rep = {
            team = REP,
            units = 16,
                reinforcements = -1,
                soldier = { "jed_knight_01",1,14},
                assault = { "jed_master_01",   1,2},       
        },
    }   

    SetupTeams{
        imp = {
            team = IMP,
            units = 16,
            reinforcements = -1,
                soldier = { "jed_sith_01",    1,16},
                --assault = { "sith_hero_sion",   1,2}, 

        },
    }   
   

    --  Level Stats
    --  ClearWalkers()
    AddWalkerType(0, 4) -- special -> droidekas
    AddWalkerType(1, 0) -- 1x2 (1 pair of legs)
    AddWalkerType(2, 0) -- 2x2 (2 pairs of legs)
    AddWalkerType(3, 0) -- 3x2 (3 pairs of legs)
    local weaponCnt = 56
    SetMemoryPoolSize("Aimer", 9)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 100)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityFlyer", 6) -- to account for rocket upgrade
    SetMemoryPoolSize ("EntitySoundStream", 2)
    SetMemoryPoolSize ("EntitySoundStatic", 1)
    --SetMemoryPoolSize("MountedTurret", 0)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 157)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("PathNode", 128)
    --SetMemoryPoolSize("TentacleSimulator", 0)
    SetMemoryPoolSize("TreeGridStack", 200)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon", weaponCnt)
    
    SetSpawnDelay(10.0, 0.25)
    ReadDataFile(assetLocation .. "PSK\\PSK.lvl", "PSK_eli")
    SetDenseEnvironment("false")

    --  Sound Stats

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")
    
    ScriptCB_EnableHeroMusic(0)
    ScriptCB_EnableHeroVO(0)
    
		-- setup PSP sound options, we can only have one or the other
    if ScriptCB_IsFileExist("settings\\sound\\ingame\\voice.lvl") == 1 then
		-- read all the VO code
		voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
		AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
		AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
		voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
		AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)    
		OpenAudioStream("sound\\tat.lvl",  "tat2")
		OpenAudioStream("sound\\tat.lvl",  "tat2")
		SetBleedingVoiceOver(REP, REP, "all_off_com_report_us_overwhelmed", 1)
		SetBleedingVoiceOver(REP, IMP, "all_off_com_report_enemy_losing",   1)
		SetBleedingVoiceOver(IMP, REP, "imp_off_com_report_enemy_losing",   1)
		SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)
		SetLowReinforcementsVoiceOver(REP, REP, "all_off_defeat_im", .1, 1)
		SetLowReinforcementsVoiceOver(REP, IMP, "all_off_victory_im", .1, 1)
		SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
		SetLowReinforcementsVoiceOver(IMP, REP, "imp_off_victory_im", .1, 1)
		SetOutOfBoundsVoiceOver(1, "Allleaving")
		SetOutOfBoundsVoiceOver(2, "Impleaving")
		SetVictoryMusic(REP, "all_tat_amb_victory")
		SetDefeatMusic (REP, "all_tat_amb_defeat")
		SetVictoryMusic(IMP, "imp_tat_amb_victory")
		SetDefeatMusic (IMP, "imp_tat_amb_defeat")        
	else
		-- read CW or GCW music stream
		-- mark out the one that's not the era you're playing, only one can exist
		--OpenAudioStream("sound\\global.lvl",  "cw_music")
		OpenAudioStream("sound\\global.lvl",  "gcw_music")
		-- ambient code comes next
        OpenAudioStream("sound\\tat.lvl",	"tat2gcw")
        OpenAudioStream("sound\\tat.lvl",	"tat2gcw")
        OpenAudioStream("sound\\tat.lvl",	"tat2gcw_emt")
        
        SetAmbientMusic(REP, 1.0, "all_tat_amb_start",  0,1)
        SetAmbientMusic(REP, 0.8, "all_tat_amb_middle", 1,1)
        SetAmbientMusic(REP, 0.2, "all_tat_amb_end",    2,1)
        SetAmbientMusic(IMP, 1.0, "imp_tat_amb_start",  0,1)
        SetAmbientMusic(IMP, 0.8, "imp_tat_amb_middle", 1,1)
        SetAmbientMusic(IMP, 0.2, "imp_tat_amb_end",    2,1)
	end


    --  Camera Stats
	AddCameraShot(0.755959, 0.056311, -0.650391, 0.048447, -20.530973, 11.287577, -204.418076);
	AddCameraShot(0.231732, -0.020220, -0.968888, -0.084542, 28.562346, 11.287577, -170.938446);
	AddCameraShot(0.706486, -0.061646, 0.702368, 0.061287, -1.079526, 11.287577, -105.581268);

end

