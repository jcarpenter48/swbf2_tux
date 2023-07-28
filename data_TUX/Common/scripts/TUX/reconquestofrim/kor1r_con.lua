--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 

--  Empire Attacking (attacker is always #1)
CIS = 2
IMP = 1
--  These variables do not change
ATT = 1
DEF = 2
 
    
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

	--[[sith lord hero
	SetClassProperty("jed_sith_01", "MaxHealth", 1400.0)
	SetClassProperty("jed_sith_01", "AddHealth", 0.0)
	SetClassProperty("jed_sith_01", "FleeLikeAHero", 1)
	SetClassProperty("jed_sith_01", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("jed_sith_01", "SoldierMusic", "all_hero_Chewbacca_lp")	  ]]--  
 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first.
    SetPS2ModelMemory(4030000)
    ReadDataFile("ingame.lvl")
    
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",64)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",650)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",650) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",650)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",650)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",8000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",96)     -- should be ~1x #combo
	SetMemoryPoolSize ("SoldierAnimation",350)   
    
    ReadDataFile("sound\\mus.lvl;mus1cross")
    SetMapNorthAngle(180, 1)
    SetMaxFlyHeight(25)
    SetMaxPlayerFlyHeight (25)
    AISnipeSuitabilityDist(30)

	ReadDataFile("SIDE\\cis_256.lvl", "cis_hero_darthmaul") --dependency for sith lord
    --ReadDataFile("SIDE\\jed.lvl", "jed_sith_01")
                
    ReadDataFile("SIDE\\imp_256.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_engineer",
                    "imp_inf_sniper",
                    "imp_inf_dark_trooper",
					"imp_hero_emperor",
                    "imp_inf_officer")

    ReadDataFile("SIDE\\cis_256.lvl",
                  "cis_inf_rifleman",
                  "cis_inf_rocketeer",
                  "cis_inf_engineer",
                  "cis_inf_sniper",
                  "cis_inf_droideka",
                  "CIS_inf_officer")
					
	SetupTeams{
		cis = {
			team = CIS,
			units = 18,
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
			units = 18,
			reinforcements = 150,
			soldier = { "imp_inf_rifleman",9, 25},
			assault = { "imp_inf_rocketeer",1, 4},
			engineer = { "imp_inf_engineer",1, 4},
			sniper  = { "imp_inf_sniper",1, 4},
			officer = { "imp_inf_officer",1, 4},
			special = { "imp_inf_dark_trooper",1, 4},
		 },
	}
    SetHeroClass(CIS, "cis_hero_darthmaul")    
    SetHeroClass(IMP, "imp_hero_emperor")
    

    -- SetTeamAsEnemy(DEF, 3)

    --  Level Stats
    ClearWalkers()
    AddWalkerType(0, 4) -- 8 droidekas (special case: 0 leg pairs)
    AddWalkerType(1, 0) -- 
    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
    local guyCnt = 50
    local weaponCnt = 190
    SetMemoryPoolSize("Aimer", 20)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth", 21)
    SetMemoryPoolSize("EntityLight", 96)
    SetMemoryPoolSize("MountedTurret", 13)
    SetMemoryPoolSize("PathFollower", guyCnt)
    SetMemoryPoolSize("Navigator", guyCnt)
    SetMemoryPoolSize("SoundSpaceRegion", 38)
    SetMemoryPoolSize("TreeGridStack", 256)
    SetMemoryPoolSize("UnitAgent", guyCnt)
    SetMemoryPoolSize("UnitController", guyCnt)
    SetMemoryPoolSize("Weapon", weaponCnt)
	SetMemoryPoolSize("EntityFlyer", 4)   

    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("KOR\\kor1.lvl", "PSK_conquest")
    SetDenseEnvironment("True")
      -- SetMaxFlyHeight(25)
     --SetMaxPlayerFlyHeight (25)
 AddDeathRegion("DeathRegion1")



    --  Movies
    --  SetVictoryMovie(CIS, "all_end_victory")
    --  SetDefeatMovie(CIS, "imp_end_victory")
    --  SetVictoryMovie(IMP, "imp_end_victory")
    --  SetDefeatMovie(IMP, "all_end_victory")

      --  Sound
     
    voiceSlow = OpenAudioStream("sound\\global.lvl", "imp_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)     
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "cis_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_quick", voiceQuick)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_quick", voiceQuick) 
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
     OpenAudioStream("sound\\myg.lvl",  "myg1")
     OpenAudioStream("sound\\myg.lvl",  "myg1")
     -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
     -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
     -- OpenAudioStream("sound\\uta.lvl",  "uta1_emt")

     SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)
     SetBleedingVoiceOver(CIS, IMP, "cis_off_com_report_enemy_losing",   1)
     SetBleedingVoiceOver(IMP, CIS, "imp_off_com_report_enemy_losing",   1)
     SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

     SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
     SetLowReinforcementsVoiceOver(CIS, IMP, "cis_off_victory_im", .1, 1)
     SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
     SetLowReinforcementsVoiceOver(IMP, CIS, "imp_off_victory_im", .1, 1)

     SetOutOfBoundsVoiceOver(CIS, "Cisleaving")
     SetOutOfBoundsVoiceOver(IMP, "impleaving")

     SetAmbientMusic(CIS, 1.0, "cis_mus_amb_start",  0,1)
     SetAmbientMusic(CIS, 0.8, "cis_mus_amb_middle", 1,1)
     SetAmbientMusic(CIS, 0.2,"cis_mus_amb_end",    2,1)
     SetAmbientMusic(IMP, 1.0, "rep_mus_amb_start",  0,1)
     SetAmbientMusic(IMP, 0.8, "rep_mus_amb_middle", 1,1)
     SetAmbientMusic(IMP, 0.2,"rep_mus_amb_end",    2,1)

     SetVictoryMusic(CIS, "cis_mus_amb_victory")
     SetDefeatMusic (CIS, "cis_mus_amb_defeat")
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


    SetAttackingTeam(ATT)



    --  Camera Stats
	AddCameraShot(0.755959, 0.056311, -0.650391, 0.048447, -20.530973, 11.287577, -204.418076);
	AddCameraShot(0.231732, -0.020220, -0.968888, -0.084542, 28.562346, 11.287577, -170.938446);
	AddCameraShot(0.706486, -0.061646, 0.702368, 0.061287, -1.079526, 11.287577, -105.581268);
end

