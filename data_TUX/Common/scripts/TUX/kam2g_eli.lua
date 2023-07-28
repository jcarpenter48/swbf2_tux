--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams") 

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
	EnableSPHeroRules()
 	-- This is the actual objective setup
	TDM = ObjectiveTDM:New{teamATT = 1, teamDEF = 2, 
						multiplayerScoreLimit = 100,
						textATT = "game.modes.tdm",
						textDEF = "game.modes.tdm2", multiplayerRules = true, isCelebrityDeathmatch = true}
	TDM:Start()

    AddAIGoal(1, "Deathmatch", 100)
    AddAIGoal(2, "Deathmatch", 100)

 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(600*1024)
    SetPS2ModelMemory(4100000)
    ReadDataFile("ingame.lvl")

	local numPlayers = ScriptCB_GetNumCameras() --better than checking number of plugged in controllers
    local isMultiplayer = ScriptCB_InMultiplayer() --I prefer checking once than for each if-block


    SetMemoryPoolSize ("ClothData",30)
    SetMemoryPoolSize ("Combo",50)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",600)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",600) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",600)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",500)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",5000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",100)     -- should be ~1x #combo  

    ReadDataFile("ingame.lvl")

	ALL = 1
	IMP = 2
	--  These variables do not change
	ATT = 1
	DEF = 2
    
    
    ReadDataFile("sound\\eli.lvl;eligcw")
    ReadDataFile("sound\\kam.lvl;kam1gcw")
	
    ReadDataFile("SIDE\\all_128.lvl",
                "all_hero_luke_jedi",
                "all_hero_hansolo_tat",
                --"all_hero_chewbacca",
                "all_hero_leia")
                    
    ReadDataFile("SIDE\\imp_128.lvl",
                "imp_hero_darthvader",
                --"imp_hero_emperor",
                "imp_hero_bobafett")
                
    ReadDataFile("SIDE\\rep_128.lvl",
                --"rep_hero_yoda",
                "rep_hero_macewindu",
                "rep_hero_anakin",
                --"rep_hero_aalya",
                --"rep_hero_kiyadimundi",
                "rep_hero_obiwan")
                
    ReadDataFile("SIDE\\cis_128.lvl",
                "cis_hero_grievous",
                --"cis_hero_darthmaul",
                --"cis_hero_countdooku",
                "cis_hero_jangofett")

    --ReadDataFile("SIDE\\tur.lvl", 
    --            "tur_bldg_laser")          
                
    ReadDataFile("SIDE\\dlc.lvl",
			"dlc_hero_ventress")
			--"dlc_hero_fisto")	 
    
    SetupTeams{
        hero = {
            team = ALL,
            units = 16,
                reinforcements = -1,
                soldier = { "all_hero_hansolo_tat",1,2},
                --assault = { "all_hero_chewbacca",   1,2},
                engineer= { "all_hero_luke_jedi",   1,2},
                sniper  = { "rep_hero_obiwan",  1,2},
                --officer = { "rep_hero_yoda",        1,2},
                special = { "rep_hero_macewindu",   1,2},           
        },
    }   

    AddUnitClass(ALL,"all_hero_leia",   1,2)
    --AddUnitClass(ALL,"rep_hero_aalya",  1,2)
    --AddUnitClass(ALL,"rep_hero_kiyadimundi",1,2)
	--AddUnitClass(ALL,"dlc_hero_fisto",1,2)

    SetupTeams{
        villain = {
            team = IMP,
            units = 16,
            reinforcements = -1,
                soldier = { "imp_hero_bobafett",    1,2},
                assault = { "imp_hero_darthvader",1,2},
                --engineer= { "cis_hero_darthmaul", 1,2},
                sniper  = { "cis_hero_jangofett", 1,2},
                officer = { "cis_hero_grievous",    1,2},
                --special = { "imp_hero_emperor", 1,2},

        },
    }   
    --AddUnitClass(IMP, "rep_hero_anakin",1,2)
    --AddUnitClass(IMP, "cis_hero_countdooku",1,2)
	AddUnitClass(IMP,"dlc_hero_ventress",1,2)
   

    --  Level Stats
        ClearWalkers()
		
    local weaponCnt = 96
    SetMemoryPoolSize("Aimer", 1)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 320)
    SetMemoryPoolSize("ConnectivityGraphFollower", 23)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth",41)
    --SetMemoryPoolSize("EntityDefenseGridTurret", 0)
    SetMemoryPoolSize("EntityDroid", 0)
	SetMemoryPoolSize("EntityFlyer", 5) -- to account for 5 chewbaccas
    --SetMemoryPoolSize("EntityLight", 80, 80) -- stupid trickery to actually set lights to 80
    SetMemoryPoolSize("EntityPortableTurret", 0) -- nobody has autoturrets AFAIK - MZ
    SetMemoryPoolSize("EntitySoundStream", 2)
    SetMemoryPoolSize("EntitySoundStatic", 45)
    SetMemoryPoolSize("FLEffectObject::OffsetMatrix", 120)
    SetMemoryPoolSize("MountedTurret", 0)
    SetMemoryPoolSize("Navigator", 23)
    SetMemoryPoolSize("Obstacle", 512)
    SetMemoryPoolSize("Ordnance", 80)	-- not much ordnance going on in the level
    SetMemoryPoolSize("ParticleEmitter", 448)
    SetMemoryPoolSize("ParticleEmitterInfoData", 448)
    SetMemoryPoolSize("PathFollower", 23)
    SetMemoryPoolSize("PathNode", 128)
    SetMemoryPoolSize("ShieldEffect", 0)
    SetMemoryPoolSize("TentacleSimulator", 24)
    SetMemoryPoolSize("TreeGridStack", 290)
    SetMemoryPoolSize("UnitAgent", 23)
    SetMemoryPoolSize("UnitController", 23)
    SetMemoryPoolSize("Weapon", weaponCnt)

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("kam\\km1.lvl","km1_eli")
	 
    SetMinFlyHeight(60)
    SetMaxFlyHeight(140)
    SetAllowBlindJetJumps(0)

    --  Sound Stats
    
    ScriptCB_EnableHeroMusic(0)
    ScriptCB_EnableHeroVO(0)
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    OpenAudioStream("sound\\tat.lvl",  "tat2")
    OpenAudioStream("sound\\tat.lvl",  "tat2")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")

    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(1, "Allleaving")
    SetOutOfBoundsVoiceOver(2, "Impleaving")

    SetAmbientMusic(ALL, 1.0, "all_kam_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_kam_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2, "all_kam_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_kam_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_kam_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2, "imp_kam_amb_end",    2,1)

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

    SetAttackingTeam(ATT)

    --  Camera Stats
	--Kamino
	--Alpha
	AddCameraShot(0.190478, -0.010945, -0.980014, -0.056312, -26.091288, 55.965012, 159.458099);
	--Clonecenter
	AddCameraShot(-0.376571, -0.019637, -0.924923, 0.048232, 176.042465, 53.957565, 244.261139);
	--Overhead many alphas
	AddCameraShot(0.639254, -0.073533, 0.760457, 0.087475, 78.395348, 72.538582, 344.086609);


end


