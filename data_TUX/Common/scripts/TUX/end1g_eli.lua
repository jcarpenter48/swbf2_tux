--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams")

---------------------------------------------------------------------------
-- ScriptPostLoad
---------------------------------------------------------------------------
function ScriptPostLoad()

    SetProperty("CP4", "Team", "1")
    SetProperty("CP5", "Team", "2")
    SetProperty("CP1", "CaptureRegion", " ")
    SetProperty("CP2", "CaptureRegion", " ")
    SetProperty("CP4", "CaptureRegion", " ")
    SetProperty("CP5", "CaptureRegion", " ")
    SetProperty("CP6", "CaptureRegion", " ")
    SetProperty("CP10", "CaptureRegion", " ")
    SetProperty("CP1", "HUDIndexDisplay", "")
    SetProperty("CP2", "HUDIndexDisplay", "")
    SetProperty("CP4", "HUDIndexDisplay", "")
    SetProperty("CP5", "HUDIndexDisplay", "")
    SetProperty("CP6", "HUDIndexDisplay", "")
    SetProperty("CP10", "HUDIndexDisplay", "")
    SetClassProperty("com_bldg_major_controlzone", "SwitchClassRadius", 5.0)

	TDM = ObjectiveTDM:New{teamATT = 1, teamDEF = 2, 
						multiplayerScoreLimit = 100,
						textATT = "game.modes.tdm",
						textDEF = "game.modes.tdm2", multiplayerRules = true, isCelebrityDeathmatch = true}
	TDM:Start()

    AddAIGoal(1, "Deathmatch", 100)
    AddAIGoal(2, "Deathmatch", 100)

	EnableSPHeroRules()
end

---------------------------------------------------------------------------
-- ScriptInit
---------------------------------------------------------------------------
function ScriptInit()
	StealArtistHeap(2048*1024)
	
	-- Designers, these two lines *MUST* be first.
	SetPS2ModelMemory(2460000)
    ReadDataFile("ingame.lvl")

	local numPlayers = ScriptCB_GetNumCameras() --better than checking number of plugged in controllers
    local isMultiplayer = ScriptCB_InMultiplayer() --I prefer checking once than for each if-block


    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",30)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",500)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",500) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",500)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",400)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",4000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",88)     -- should be ~1x #combo
	
	SetWorldExtents(1277.3)

	local ALL = 1
	local IMP = 2

	local ATT = 1
	local DEF = 2

	ReadDataFile("sound\\eli.lvl;eligcw")
    ReadDataFile("sound\\end.lvl;end1gcw")

--	SetTeamAggressiveness(ALL, 1.0)
--	SetTeamAggressiveness(IMP, 0.7)

	SetMaxFlyHeight(43)
	SetMaxPlayerFlyHeight(43)

	ReadDataFile("SIDE\\all_128.lvl",
                "all_hero_luke_jedi",
                "all_hero_hansolo_tat",
                "all_hero_leia",
                "all_hero_chewbacca")
                    
    ReadDataFile("SIDE\\imp_128.lvl",
                "imp_hero_darthvader",
                "imp_hero_emperor",
                "imp_hero_bobafett")
                
    ReadDataFile("SIDE\\rep_128.lvl",
                --"rep_hero_yoda",
                "rep_hero_macewindu",
                "rep_hero_anakin",
                "rep_hero_aalya",
                "rep_hero_kiyadimundi",
                "rep_hero_obiwan")
                
    ReadDataFile("SIDE\\cis_128.lvl",
                --"cis_hero_grievous",
                "cis_hero_darthmaul",
                "cis_hero_countdooku",
                "cis_hero_jangofett")
					
	--ReadDataFile("SIDE\\tur.lvl",
	--			"tur_bldg_laser")	
	
	--ReadDataFile("SIDE\\dlc.lvl",
			--"dlc_hero_ventress")
			--"dlc_hero_fisto")	
				
--	ReadDataFile("SIDE\\ewk.lvl",
--				"ewk_inf_basic")

	SetupTeams{
        hero = {
            team = ALL,
            units = 12,
                reinforcements = -1,
                soldier = { "all_hero_hansolo_tat",1,2},
                assault = { "all_hero_chewbacca",   1,2},
                engineer= { "all_hero_luke_jedi",   1,2},
                sniper  = { "rep_hero_obiwan",  1,2},
                --officer = { "rep_hero_yoda",        1,2},
                special = { "rep_hero_macewindu",   1,2},           
        },
    }   
    AddUnitClass(ALL,"all_hero_leia",   1,2)
    AddUnitClass(ALL,"rep_hero_aalya",  1,2)
    AddUnitClass(ALL,"rep_hero_kiyadimundi",1,2)
	--AddUnitClass(ALL,"dlc_hero_fisto",1,2)

    SetupTeams{
        villain = {
            team = IMP,
            units = 12,
            reinforcements = -1,
                soldier = { "imp_hero_bobafett",    1,2},
                assault = { "imp_hero_darthvader",1,2},
                engineer= { "cis_hero_darthmaul", 1,2},
                sniper  = { "cis_hero_jangofett", 1,2},
                --officer = { "cis_hero_grievous",    1,2},
                special = { "imp_hero_emperor", 1,2},

        },
    }   
    AddUnitClass(IMP, "rep_hero_anakin",1,2)
    AddUnitClass(IMP, "cis_hero_countdooku",1,2)
	--AddUnitClass(IMP,"dlc_hero_ventress",1,2)

	--	Local Stats
--	SetTeamName(3, "locals")
--	AddUnitClass(3, "ewk_inf_trooper", 3)
--	AddUnitClass(3, "ewk_inf_repair", 3)
--	SetUnitCount(3, 6)
	
--	SetTeamAsFriend(3,ATT)
--	SetTeamAsEnemy(3,DEF)

	--	Level Stats
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
		SetMemoryPoolSize("Obstacle", 667)
		SetMemoryPoolSize("Ordnance", 80)	-- not much ordnance going on in the level
		SetMemoryPoolSize("ParticleEmitter", 512)
		SetMemoryPoolSize("ParticleEmitterInfoData", 512)
		SetMemoryPoolSize("PathFollower", 23)
		SetMemoryPoolSize("PathNode", 128)
		SetMemoryPoolSize("ShieldEffect", 0)
		SetMemoryPoolSize("TentacleSimulator", 24)
		SetMemoryPoolSize("TreeGridStack", 290)
		SetMemoryPoolSize("UnitAgent", 23)
		SetMemoryPoolSize("UnitController", 23)
		SetMemoryPoolSize("Weapon", weaponCnt)
	
	--	Attacker Stats
--	SetTeamAsFriend(ATT, 3)


	--	Defender Stats
--	SetTeamAsEnemy(DEF, 3)

	SetSpawnDelay(10.0, 0.25)
	ReadDataFile("end\\end1.lvl", "end1_conquest")
	SetDenseEnvironment("true")
	AddDeathRegion("deathregion")
	SetStayInTurrets(1)


	--	Movies
	--	SetVictoryMovie(ALL, "all_end_victory")
	--	SetDefeatMovie(ALL, "imp_end_victory")
	--	SetVictoryMovie(IMP, "imp_end_victory")
	--	SetDefeatMovie(IMP, "all_end_victory")

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

    SetAmbientMusic(ALL, 1.0, "all_end_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_end_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2, "all_end_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_end_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_end_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2, "imp_end_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_end_amb_victory")
    SetDefeatMusic (ALL, "all_end_amb_defeat")
    SetVictoryMusic(IMP, "imp_end_amb_victory")
    SetDefeatMusic (IMP, "imp_end_amb_defeat")

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

	--Endor
	--Shield Bunker
	AddCameraShot(0.997654, 0.066982, 0.014139, -0.000949, 155.137131, 0.911505, -138.077072)
	--Village
	AddCameraShot(0.729761, 0.019262, 0.683194, -0.018033, -98.584869, 0.295284, 263.239288)
	--Village
	AddCameraShot(0.694277, 0.005100, 0.719671, -0.005287, -11.105947, -2.753207, 67.982201)
end

