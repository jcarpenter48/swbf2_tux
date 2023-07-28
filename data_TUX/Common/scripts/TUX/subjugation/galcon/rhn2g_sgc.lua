----
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")

function ScriptPostLoad()
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "cp1"}
    cp2 = CommandPost:New{name = "cp2"}   
    cp3 = CommandPost:New{name = "cp3"}
    cp4 = CommandPost:New{name = "cp4"}  
	cp5 = CommandPost:New{name = "cp5"}   
    cp6 = CommandPost:New{name = "cp6"}
    cp7 = CommandPost:New{name = "cp7"}  	
    
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
    conquest:AddCommandPost(cp7)
    
    conquest:Start()

    EnableSPHeroRules()
    
 	--create Jedi Knight hero
	SetClassProperty("jed_knight_01", "MaxHealth", 1100.0)
	SetClassProperty("jed_knight_01", "AddHealth", 0.0)
	SetClassProperty("jed_knight_01", "FleeLikeAHero", 1)
	SetClassProperty("jed_knight_01", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("jed_knight_01", "SoldierMusic", "all_hero_Chewbacca_lp")    
    
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
	if(ScriptCB_GetPlatform() == "PS2") then
        StealArtistHeap(1024*1024)	-- steal 1MB from art heap
    end
    
    -- Designers, these two lines *MUST* be first.
    --SetPS2ModelMemory(4500000)
    SetPS2ModelMemory(3300000)
    ReadDataFile("ingame.lvl")
    
     --  Empire Attacking (attacker is always #1)
    ALL = 1
    IMP = 2
    --  These variables do not change
    ATT = 1
    DEF = 2

    --SetAttackingTeam(ATT)


    SetMaxFlyHeight(30)
    SetMaxPlayerFlyHeight(30)

     --ReadDataFile("sound\\myg.lvl;myg1gcw")
	 ReadDataFile("sound\\mus.lvl;mus1cross")
	--ReadDataFile("sound\\TDS.lvl;TDS_gcw")
	
	SetMemoryPoolSize ("ClothData",30)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",260)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",260) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",260)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",260)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",2800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",24)     -- should be ~1x #combo       -- should be ~1x #combo 

    --ReadDataFile("SIDE\\rep_128.lvl", "rep_hero_cloakedanakin") --dependency for some jedi
		
	ReadDataFile("SIDE\\jed.lvl",
		--"jed_master_03",
		--"jed_master_02",
		"jed_knight_01")
		
    ReadDataFile("SIDE\\cis.lvl",
                  "cis_inf_rifleman",
                  "cis_inf_rocketeer",
                  "cis_inf_engineer",
                  "cis_inf_sniper",
                  "cis_inf_droideka",
                  "CIS_inf_officer")
                    
     ReadDataFile("SIDE\\imp.lvl",
					 "imp_inf_rifleman_snow",
					 "imp_inf_rocketeer_snow",
					 "imp_inf_sniper_snow",
					 "imp_inf_engineer_snow",
					 "imp_inf_officer",
					"imp_hero_darthvader",
                    "imp_inf_dark_trooper") 
   
       ReadDataFile("SIDE\\tur.lvl",
        "tur_bldg_laser")
        
	SetupTeams{
		all = {
			team = ALL,
			units = 16,
			reinforcements = 150,
			soldier = { "cis_inf_rifleman",7, 25},
			assault = { "cis_inf_rocketeer",1, 4},
			engineer = { "cis_inf_engineer",1, 4},
			sniper  = { "cis_inf_sniper",1, 4},
			officer = { "cis_inf_droideka",1, 4},
			special = { "CIS_inf_officer",1, 4},
		},
	}   

	SetupTeams{
		imp = {
			team = IMP,
			units = 16,
			reinforcements = 150,
			soldier = { "imp_inf_rifleman_snow",9, 25},
			assault = { "imp_inf_rocketeer_snow",1, 4},
			engineer = { "imp_inf_engineer_snow",1, 4},
			sniper  = { "imp_inf_sniper_snow",1, 4},
			officer = { "imp_inf_officer",1, 4},
			special = { "imp_inf_dark_trooper",1, 4},
		 },
	}
--Setting up Heros--

	SetTeamIcon(ALL, "cis_icon")
	--SetTeamName(ALL, "CIS")
     SetHeroClass(ALL, "jed_knight_01")
     SetHeroClass(IMP, "imp_hero_darthvader")  
    
   

       --  Level Stats
    ClearWalkers()
    AddWalkerType(0, 4) -- 0 droidekas
    --AddWalkerType(1, 5) -- 6 atsts with 1 leg pairs each
    --AddWalkerType(2, 2) -- 2 atats with 2 leg pairs each

	local weaponCnt = 221
	SetMemoryPoolSize("AmmoCounter", weaponCnt)
	SetMemoryPoolSize("BaseHint", 175)
	SetMemoryPoolSize("EnergyBar", weaponCnt)
	SetMemoryPoolSize("EntityFlyer", 10)
	SetMemoryPoolSize("EntityLight", 110)
	SetMemoryPoolSize("EntitySoundStatic", 16)
	SetMemoryPoolSize("EntitySoundStream", 5)
	SetMemoryPoolSize("MountedTurret", 30)
	SetMemoryPoolSize("Obstacle", 400)
	SetMemoryPoolSize("PathNode", 160)
	SetMemoryPoolSize("Weapon", weaponCnt)
	
	SetMemoryPoolSize("Aimer", 1)
    SetMemoryPoolSize("ConnectivityGraphFollower", 23)
    SetMemoryPoolSize("EntityCloth",41)
    SetMemoryPoolSize("EntityDefenseGridTurret", 0)
    SetMemoryPoolSize("EntityDroid", 0)
    SetMemoryPoolSize("EntityPortableTurret", 0) -- nobody has autoturrets AFAIK - MZ
    SetMemoryPoolSize("FLEffectObject::OffsetMatrix", 120)
    SetMemoryPoolSize("Navigator", 23)
    SetMemoryPoolSize("Ordnance", 80)	-- not much ordnance going on in the level
    SetMemoryPoolSize("ParticleEmitter", 512)
    SetMemoryPoolSize("ParticleEmitterInfoData", 512)
    SetMemoryPoolSize("PathFollower", 23)
    SetMemoryPoolSize("ShieldEffect", 0)
    SetMemoryPoolSize("TentacleSimulator", 24)
    SetMemoryPoolSize("TreeGridStack", 290)
    SetMemoryPoolSize("UnitAgent", 23)
    SetMemoryPoolSize("UnitController", 23)
    
    ReadDataFile("RHN\\RHN2.lvl", "rhenvar2_conquest")
    SetSpawnDelay(10.0, 0.25)
    SetDenseEnvironment("true")
    SetDefenderSnipeRange(170)
    AddDeathRegion("FalltoDeath")
	
     --  Sound
     
    voiceSlow = OpenAudioStream("sound\\global.lvl", "imp_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)     
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "cis_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_quick", voiceQuick)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_quick", voiceQuick) 
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
     OpenAudioStream("sound\\uta.lvl",  "uta1")
     OpenAudioStream("sound\\uta.lvl",  "uta1")
     -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
     -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
     -- OpenAudioStream("sound\\uta.lvl",  "uta1_emt")

     SetBleedingVoiceOver(ALL, ALL, "cis_off_com_report_us_overwhelmed", 1)
     SetBleedingVoiceOver(ALL, IMP, "cis_off_com_report_enemy_losing",   1)
     SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
     SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

     SetLowReinforcementsVoiceOver(ALL, ALL, "cis_off_defeat_im", .1, 1)
     SetLowReinforcementsVoiceOver(ALL, IMP, "cis_off_victory_im", .1, 1)
     SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
     SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)

     SetOutOfBoundsVoiceOver(ALL, "Cisleaving")
     SetOutOfBoundsVoiceOver(IMP, "impleaving")

     SetAmbientMusic(ALL, 1.0, "cis_mus_amb_start",  0,1)
     SetAmbientMusic(ALL, 0.8, "cis_mus_amb_middle", 1,1)
     SetAmbientMusic(ALL, 0.2,"cis_mus_amb_end",    2,1)
     SetAmbientMusic(IMP, 1.0, "rep_mus_amb_start",  0,1)
     SetAmbientMusic(IMP, 0.8, "rep_mus_amb_middle", 1,1)
     SetAmbientMusic(IMP, 0.2,"rep_mus_amb_end",    2,1)

     SetVictoryMusic(ALL, "cis_mus_amb_victory")
     SetDefeatMusic (ALL, "cis_mus_amb_defeat")
     SetVictoryMusic(IMP, "rep_mus_amb_victory")
     SetDefeatMusic (IMP, "rep_mus_amb_defeat")

     SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
     SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
     --  SetSoundEffect("BirdScatter",         "birdsFlySeq1")
     SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
     SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
     SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
     SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
     SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")

    --  Camera Stats
    --Rhen Var 2 Citadel
    --Statue
    AddCameraShot(0.994005, -0.109073, 0.007486, 0.000821, -203.097900, 26.624817, -101.682487)
    --Steps
    AddCameraShot(0.104328, -0.022317, -0.972296, -0.207984, -266.398132, 24.953222, -251.513596)
    --Terrace
    AddCameraShot(0.908227, 0.026135, 0.417489, -0.012014, -101.176414, 12.784149, -199.053940)
end