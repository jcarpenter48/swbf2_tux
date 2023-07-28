--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")

     --  Empire Attacking (attacker is always #1)
     CIS = 2
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
 
    DisableBarriers("dropship")
    DisableBarriers("shield_03")
    DisableBarriers("shield_02")
    DisableBarriers("shield_01")
    DisableBarriers("ctf")
    DisableBarriers("ctf1")
    DisableBarriers("ctf2")
    DisableBarriers("ctf3")
    DisableBarriers("coresh1")

    EnableSPHeroRules()
    
    cp1 = CommandPost:New{name = "CP1_CON"}
    cp2 = CommandPost:New{name = "CP2_CON"}
    --cp3 = CommandPost:New{name = "CP3_CON"}
    cp4 = CommandPost:New{name = "CP4_CON"}
    cp5 = CommandPost:New{name = "CP5_CON"}
    cp7 = CommandPost:New{name = "CP7_CON"}
    --cp8 = CommandPost:New{name = "CP8_CON"}
    
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, textATT = "game.modes.con", textDEF = "game.modes.con2", multiplayerRules = true}
    
    conquest:AddCommandPost(cp1)
    conquest:AddCommandPost(cp2)
    --conquest:AddCommandPost(cp3)
    conquest:AddCommandPost(cp4)
    conquest:AddCommandPost(cp5)
    conquest:AddCommandPost(cp7)
    --conquest:AddCommandPost(cp8)
    
    conquest:Start()

	--create Jedi Knight hero
	SetClassProperty("jed_knight_04", "MaxHealth", 1100.0)
	SetClassProperty("jed_knight_04", "AddHealth", 0.0)
	SetClassProperty("jed_knight_04", "FleeLikeAHero", 1)
	SetClassProperty("jed_knight_04", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("jed_knight_04", "SoldierMusic", "all_hero_Chewbacca_lp")       
end

 
 function ScriptInit()
    StealArtistHeap(2048 * 1024)
     -- Designers, these two lines *MUST* be first!
     SetPS2ModelMemory(4000000)
     ReadDataFile("ingame.lvl")

	SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",260)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",260) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",260)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",260)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",2800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",24)     -- should be ~1x #combo       -- should be ~1x #combo
	
     --ReadDataFile("sound\\myg.lvl;myg1gcw")
	 ReadDataFile("sound\\mus.lvl;mus1cross")
	--ReadDataFile("sound\\TDS.lvl;TDS_gcw")

     SetMaxFlyHeight(20)
    SetMaxPlayerFlyHeight(20)
	
    ReadDataFile("SIDE\\rep_128.lvl",
        "rep_hero_cloakedanakin") --dependency for some jedi
		
	ReadDataFile("SIDE\\jed.lvl",
	--"jed_master_03",
	--"jed_master_02",
	"jed_knight_04")
		
    ReadDataFile("SIDE\\cis_256.lvl",
                  "cis_inf_rifleman",
                  "cis_inf_rocketeer",
                  "cis_inf_engineer",
                  "cis_inf_sniper",
                  "cis_inf_droideka",
                  "CIS_inf_officer")
				  
     --ReadDataFile("SIDE\\all.lvl", "all_hover_combatspeeder")
                    
     ReadDataFile("SIDE\\imp_256.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_officer",
                    "imp_inf_sniper",
                    --"imp_hover_fightertank",
                    "imp_inf_dark_trooper",
                    "imp_hero_emperor",
                    "imp_inf_engineer")
                    
   --ReadDataFile("SIDE\\tur.lvl",
   --                         "tur_bldg_recoilless_lg")
                    
	SetupTeams{
		cis = {
			team = CIS,
			units = 22,
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
			units = 22,
			reinforcements = 150,
			soldier = { "imp_inf_rifleman",9, 25},
			assault = { "imp_inf_rocketeer",1, 4},
			engineer = { "imp_inf_engineer",1, 4},
			sniper  = { "imp_inf_sniper",1, 4},
			officer = { "imp_inf_officer",1, 4},
			special = { "imp_inf_dark_trooper",1, 4},
		 },
	}
	--Setting up Heros--

	SetTeamIcon(CIS, "cis_icon")
	SetTeamName(CIS, "CIS")
     SetHeroClass(CIS, "jed_knight_04")
     --SetHeroClass(IMP, "imp_hero_darthvader")  

-- Hero Setup -- 

         SetHeroClass(IMP, "imp_hero_emperor")
         --SetHeroClass(CIS, "all_hero_luke_jedi")


     --  Level Stats
     ClearWalkers()
         AddWalkerType(0, 4) -- 8 droidekas (special case: 0 leg pairs)
     AddWalkerType(1, 0) -- ATst- 2 legged Walkers
     --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
     --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
     SetMemoryPoolSize("Aimer", 80)
     SetMemoryPoolSize("EntityCloth", 37)
     SetMemoryPoolSize("EntityHover", 7)
     SetMemoryPoolSize("EntityFlyer", 6)
     SetMemoryPoolSize("EntityLight", 36)
     SetMemoryPoolSize("MountedTurret", 14)
     SetMemoryPoolSize("Obstacle", 500)
     SetMemoryPoolSize("PathNode", 512)
     SetMemoryPoolSize("EntitySoundStream", 1)
     SetMemoryPoolSize("EntitySoundStatic", 76)     
     SetMemoryPoolSize("TreeGridStack", 300)
     SetMemoryPoolSize("Weapon", 260)


     SetSpawnDelay(10.0, 0.25)
     ReadDataFile("myg\\myg1.lvl", "myg1_conquest")
     SetDenseEnvironment("false")
     AddDeathRegion("deathregion")
     --SetStayInTurrets(1)


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

        --Camera Shizzle--
        
        -- Collector Shot
    AddCameraShot(0.008315, 0.000001, -0.999965, 0.000074, -64.894348, 5.541570, 201.711090);
	AddCameraShot(0.633584, -0.048454, -0.769907, -0.058879, -171.257629, 7.728924, 28.249359);
	AddCameraShot(-0.001735, -0.000089, -0.998692, 0.051092, -146.093109, 4.418306, -167.739212);
	AddCameraShot(0.984182, -0.048488, 0.170190, 0.008385, 1.725611, 8.877428, 88.413887);
	AddCameraShot(0.141407, -0.012274, -0.986168, -0.085598, -77.743042, 8.067328, 42.336128);
	AddCameraShot(0.797017, 0.029661, 0.602810, -0.022434, -45.726467, 7.754435, -47.544712);
	AddCameraShot(0.998764, 0.044818, -0.021459, 0.000963, -71.276566, 4.417432, 221.054550);
 end

