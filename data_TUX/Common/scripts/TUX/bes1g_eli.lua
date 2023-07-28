
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams") 

--  Empire Attacking (attacker is always #1)
ALL = 1
IMP = 2
--  These variables do not change
ATT = 1
DEF = 2

 ---------------------------------------------------------------------------
 -- FUNCTION:    ScriptInit
 -- PURPOSE:     This function is only run oncgar_inf_naboo_queen
 -- OUTPUT:
 -- NOTES:       The name, 'ScriptInit' is a chosen convention, and each
 --              mission script must contain a version of this function, as
 --              it is called from C to start the mission.
 ---------------------------------------------------------------------------
 function ScriptPostLoad()
	SetTeamAggressiveness(ALL, 1.0)
    SetTeamAggressiveness(IMP, 1.0)
	
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
 
    SetMinFlyHeight(-300)
    SetMaxFlyHeight(500)
    SetMinPlayerFlyHeight(-300)
    SetMaxPlayerFlyHeight(500)

    SetAIVehicleNotifyRadius(64)
    SetStayInTurrets(1)
    
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",40)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",668)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",668) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",668)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",532)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",5332)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",117)     -- should be ~1x #combo
    
    ReadDataFile("sound\\eli.lvl;eligcw")
    ReadDataFile("sound\\cor.lvl;cor1gcw")
	ReadDataFile("SIDE\\all_256.lvl",
                "all_hero_luke_jedi",
                "all_hero_hansolo_tat",
                "all_hero_leia",
				"rep_hero_obiwan",
                "all_hero_chewbacca")
                    
    ReadDataFile("SIDE\\imp_256.lvl",
                "imp_hero_darthvader",
                "imp_hero_emperor",
				--"imp_hero_guard",
                "imp_hero_bobafett")
                
    ReadDataFile("SIDE\\rep_256.lvl",
                "rep_hero_yoda",
                --"rep_hero_obiwan",
                "rep_hero_anakin",
                "rep_hero_aalya",
                "rep_hero_kiyadimundi",
				"rep_hero_padme",
				--"rep_hero_quigon",
                "rep_hero_macewindu")
                
    ReadDataFile("SIDE\\cis_256.lvl",
                "cis_hero_grievous",
                "cis_hero_darthmaul",
                "cis_hero_countdooku",
				"cis_hero_zam",
				--"cis_hero_sevranncetann_hvv",
                "cis_hero_jangofett")
                       
              
     
    
	SetupTeams{
        hero = {
            team = ALL,
            units = 12,
                reinforcements = -1,
                soldier = { "all_hero_hansolo_tat",1,2},
                assault = { "all_hero_chewbacca",   1,2},
                engineer= { "all_hero_luke_jedi",   1,2},
                sniper  = { "rep_hero_obiwan",  1,2},
                officer = { "rep_hero_yoda",        1,2},
                special = { "rep_hero_macewindu",   1,2},           
        },
    }   
    AddUnitClass(ALL,"all_hero_leia",   1,2)
    AddUnitClass(ALL,"rep_hero_aalya",  1,2)
    AddUnitClass(ALL,"rep_hero_kiyadimundi",1,2)
	--AddUnitClass(ALL,"rep_hero_quigon",1,2)
	AddUnitClass(ALL,"rep_hero_padme",1,2)

    SetupTeams{
        villain = {
            team = IMP,
            units = 12,
            reinforcements = -1,
                soldier = { "imp_hero_bobafett",    1,2},
                assault = { "imp_hero_darthvader",1,2},
                engineer= { "cis_hero_darthmaul", 1,2},
                sniper  = { "cis_hero_jangofett", 1,2},
                officer = { "cis_hero_grievous",    1,2},
                special = { "imp_hero_emperor", 1,2},

        },
    }   
    AddUnitClass(IMP, "rep_hero_anakin",1,2)
    AddUnitClass(IMP, "cis_hero_countdooku",1,2)
	--AddUnitClass(IMP, "cis_hero_sevranncetann_hvv",1,2)
	--AddUnitClass(IMP, "imp_hero_guard",1,2)
	AddUnitClass(IMP, "cis_hero_zam",1,2)

   

    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 0) -- 0 droidekas (special case: 0 leg pairs)
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
		SetMemoryPoolSize("EntityCloth", 29)
		SetMemoryPoolSize("EntityFlyer", 6)
		--SetMemoryPoolSize("EntitySoundStream", 3)
		--SetMemoryPoolSize("EntitySoundStatic", 120)
		SetMemoryPoolSize("MountedTurret", 15)
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
     ReadDataFile("bes\\bs1.lvl","bs1_eli")
     SetDenseEnvironment("True")   
     AddDeathRegion("death_region")
     --SetStayInTurrets(1)

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

    SetAmbientMusic(ALL, 1.0, "all_cor_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_cor_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2, "all_cor_amb_cor",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_cor_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_cor_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2, "imp_cor_amb_cor",    2,1)

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

    SetAttackingTeam(ATT)

    --  Camera Stats
	--Bes1 Platforms
	--Platform Sky
	AddCameraShot(0.793105, -0.062986, -0.603918, -0.047962, -170.583618, 118.981544, -150.443253);
	--Control Room
	AddCameraShot(0.189716, 0.000944, -0.981826, 0.004887, -27.594292, 100.583740, -176.478012);
	--Extractor
	AddCameraShot(0.492401, 0.010387, -0.870113, 0.018354, 19.590666, 100.493599, -47.846901);


end


