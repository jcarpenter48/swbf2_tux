--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveTDM")

--  Empire Attacking (attacker is always #1)
ALL = 1
IMP = 2
--  These variables do not change
ATT = 1
DEF = 2
---------------------------------------------------------------------------
-- ScriptPostLoad
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

    --[[
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",40)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",668)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",668) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",668)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",532)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",5332)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",117)     -- should be ~1x #combo
	]]--
	SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",40)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",800)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",800) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",800)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",800)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",8000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",167)     -- should be ~1x #combo
	SetMemoryPoolSize("SoldierAnimation", 600)
 
    SetMaxFlyHeight(55)
    SetMaxPlayerFlyHeight (55)
    
	--ReadDataFile("sound\hero.lvl;herogcw")
	ReadDataFile("sound\\eli.lvl;eligcw")
    ReadDataFile("sound\\kas.lvl;kas2gcw")
	--ReadDataFile("sound\\dag.lvl;dag1gcw")
    --ReadDataFile("sound\\tat.lvl;tat2gcw")
	if((not isMultiplayer) and numPlayers < 3) then
		ReadDataFile("SIDE\\all_256.lvl",
					"all_hero_luke_jedi",
					"all_hero_hansolo_tat",
					"all_hero_leia",
					"all_hero_chewbacca")
						
		ReadDataFile("SIDE\\imp_256.lvl",
					"imp_hero_darthvader",
					"imp_hero_emperor",
					"imp_hero_bobafett")
					
		ReadDataFile("SIDE\\rep_256.lvl",
					"rep_hero_yoda",
					--"rep_hero_macewindu",
					--"rep_hero_anakin",
					--"rep_hero_aalya",
					"rep_hero_kiyadimundi",
					--"rep_hero_quigon",
					"rep_hero_obiwan")
					
		ReadDataFile("SIDE\\cis_256.lvl",
					"cis_hero_grievous",
					--"cis_hero_darthmaul",
					"cis_hero_countdooku",
					"cis_hero_sevranncetann_hvv",
					"cis_hero_jangofett")
    end
	if(numPlayers > 2 or isMultiplayer) then
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
					"rep_hero_yoda",
					--"rep_hero_macewindu",
					--"rep_hero_anakin",
					--"rep_hero_aalya",
					"rep_hero_kiyadimundi",
					--"rep_hero_quigon",
					"rep_hero_obiwan")
					
		ReadDataFile("SIDE\\cis_128.lvl",
					"cis_hero_grievous",
					--"cis_hero_darthmaul",
					"cis_hero_countdooku",
					"cis_hero_sevranncetann_hvv",
					"cis_hero_jangofett")
	end
    ReadDataFile("SIDE\\dlc.lvl",
			"dlc_hero_fisto")	               
     
    
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
                --special = { "rep_hero_macewindu",   1,2},           
        },
    }   
    AddUnitClass(ALL,"all_hero_leia",   1,2)
    --AddUnitClass(ALL,"rep_hero_aalya",  1,2)
    AddUnitClass(ALL,"rep_hero_kiyadimundi",1,2)
	--AddUnitClass(ALL,"rep_hero_quigon",1,2)
	AddUnitClass(ALL,"dlc_hero_fisto",1,2)
	--AddUnitClass(ALL,"rep_hero_padme",1,2)

    SetupTeams{
        villain = {
            team = IMP,
            units = 12,
            reinforcements = -1,
                soldier = { "imp_hero_bobafett",    1,2},
                assault = { "imp_hero_darthvader",1,2},
                --engineer= { "cis_hero_darthmaul", 1,2},
                sniper  = { "cis_hero_jangofett", 1,2},
                officer = { "cis_hero_grievous",    1,2},
                special = { "imp_hero_emperor", 1,2},

        },
    }   
    --AddUnitClass(IMP, "rep_hero_anakin",1,2)
    AddUnitClass(IMP, "cis_hero_countdooku",1,2)
	AddUnitClass(IMP, "cis_hero_sevranncetann_hvv",1,2)


   

    --  Level Stats
        ClearWalkers()
        --[[AddWalkerType(0, 0) -- 0 droidekas (special case: 0 leg pairs)
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
		SetMemoryPoolSize("MountedTurret", 6)
		--SetMemoryPoolSize("Navigator", 50)
		--SetMemoryPoolSize("Obstacle", 300)
		--SetMemoryPoolSize("PathFollower", 50)
		--SetMemoryPoolSize("PathNode", 512)
		--SetMemoryPoolSize("TentacleSimulator", 8)
		--SetMemoryPoolSize("TreeGridStack", 300)
		SetMemoryPoolSize("UnitAgent", 50)
		SetMemoryPoolSize("UnitController", 50)
		--SetMemoryPoolSize("Weapon", weaponCnt)
				]]--
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
		
    SetSpawnDelay(10.0, 0.25)
	
     ReadDataFile("kas\\ks2low.lvl","ks2_eli")
     SetDenseEnvironment("True")   
     AddDeathRegion("deathregion1")
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
    OpenAudioStream("sound\\kas.lvl",   "kas2")
    OpenAudioStream("sound\\kas.lvl",   "kas2")
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

    SetAmbientMusic(ALL, 1.0, "all_kas_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_kas_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2, "all_kas_amb_cor",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_kas_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_kas_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2, "imp_kas_amb_cor",    2,1)

    SetVictoryMusic(ALL, "all_kas_amb_victory")
    SetDefeatMusic (ALL, "all_kas_amb_defeat")
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

    SetAttackingTeam(ATT)

    --  Camera Stats
	--Kas2 Docks
	--Wide beach shot
	AddCameraShot(0.999802, -0.015964, 0.011840, 0.000189, 113.108002, 1.022731, 269.666748);
	--Dock
	AddCameraShot(0.953681, -0.012084, -0.300552, -0.003808, 19.168949, 2.542728, 119.974800);
	--Platform
	AddCameraShot(0.523602, -0.007785, 0.851833, 0.012665, 262.619171, 16.203047, -53.650951);


end


