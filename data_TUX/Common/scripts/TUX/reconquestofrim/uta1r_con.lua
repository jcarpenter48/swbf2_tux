--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
ScriptCB_DoFile("setup_teams")

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")


    --  Empire Attacking (attacker is always #1)
    local CIS = 2
    local IMP = 1
    --  These variables do not change
    local ATT = 1
    local DEF = 2

function ScriptPostLoad()

    EnableSPHeroRules()
    
    --CP SETUP for CONQUEST
    
    cp1 = CommandPost:New{name = "CON_CP1"}
    cp2 = CommandPost:New{name = "con_CP1a"}
    cp3 = CommandPost:New{name = "CON_CP2"}
    cp4 = CommandPost:New{name = "CON_CP5"}
    cp5 = CommandPost:New{name = "CON_CP6"}
    cp6 = CommandPost:New{name = "CON_CP7"}


    
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, textATT = "game.modes.con", textDEF = "game.modes.con2", multiplayerRules = true}
    
    conquest:AddCommandPost(cp1)
    conquest:AddCommandPost(cp2)
    conquest:AddCommandPost(cp3)
    conquest:AddCommandPost(cp4)
    conquest:AddCommandPost(cp5)
    conquest:AddCommandPost(cp6)
   
    conquest:Start()
    DisableBarriers("Barrier445");
	
	--create Jedi Master hero
	SetClassProperty("jed_master_02", "MaxHealth", 1400.0)
	SetClassProperty("jed_master_02", "AddHealth", 0.0)
	SetClassProperty("jed_master_02", "FleeLikeAHero", 1)
	SetClassProperty("jed_master_02", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("jed_master_02", "SoldierMusic", "all_hero_Chewbacca_lp")
 end
 
 function ScriptInit()
     -- Designers, these two lines *MUST* be first!
     SetPS2ModelMemory(4880000)
     ReadDataFile("ingame.lvl")

	SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",260)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",260) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",260)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",260)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",2800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",24)     -- should be ~1x #combo       -- should be ~1x #combo  
	
     --ReadDataFile("sound\\uta.lvl;uta1gcw")

	
    ReadDataFile("sound\\mus.lvl;mus1cross")
	--ReadDataFile("sound\\TDS.lvl;TDS_gcw")
	
    ReadDataFile("SIDE\\imp_256.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_engineer",
                    "imp_inf_sniper",
                    "imp_inf_dark_trooper",
					"imp_hero_darthvader",
                    "imp_inf_officer")

    ReadDataFile("SIDE\\cis_256.lvl",
                  "cis_inf_rifleman",
                  "cis_inf_rocketeer",
                  "cis_inf_engineer",
                  "cis_inf_sniper",
                  "cis_inf_droideka",
                  "CIS_inf_officer")
    
    ReadDataFile("SIDE\\jed.lvl",
        --"jed_master_03",
        --"jed_master_01",
        "jed_master_02")
		
    ReadDataFile("SIDE\\imp_256.lvl",
                    --"imp_hover_fightertank",
                    "imp_fly_destroyer_dome")
	--ReadDataFile("SIDE\\all_256.lvl",
    --                "all_hover_combatspeeder")
					
  SetupTeams{
    cis = {
        team = CIS,
        units = 20,
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
        units = 20,
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
     SetHeroClass(CIS, "jed_master_02")
     SetHeroClass(IMP, "imp_hero_darthvader")  



     --  Level Stats
     ClearWalkers()
         AddWalkerType(0, 4) -- 8 droidekas (special case: 0 leg pairs)
     --    AddWalkerType(1, 4) -- 8 ATST (special case: 1 leg pairs)
     --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
     --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
     SetMemoryPoolSize ("EntityHover",6)
     SetMemoryPoolSize("EntityFlyer", 8)
     SetMemoryPoolSize ("EntityLight",80)
     SetMemoryPoolSize("EntitySoundStatic", 27)       
     SetMemoryPoolSize ("Obstacle", 400)
     SetMemoryPoolSize ("Weapon", 260)

     ReadDataFile("uta\\uta1.lvl", "uta1_Conquest")
     SetDenseEnvironment("false")
     AddDeathRegion("deathregion")
     SetMaxFlyHeight(29.5)
     SetMaxPlayerFlyHeight(29.5)


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


--  Camera Stats - Utapau: Sinkhole
    AddCameraShot(-0.428091, 0.045649, -0.897494, -0.095703, 162.714951, 45.857063, 40.647118)
    AddCameraShot(-0.194861, -0.001600, -0.980796, 0.008055, -126.179787, 16.113789, 70.012894);
    AddCameraShot(-0.462548, -0.020922, -0.885442, 0.040050, -16.947638, 4.561796, 156.926956);
    AddCameraShot(0.995310, 0.024582, -0.093535, 0.002310, 38.288612, 4.561796, 243.298508);
    AddCameraShot(0.827070, 0.017093, 0.561719, -0.011609, -24.457638, 8.834146, 296.544586);
    AddCameraShot(0.998875, 0.004912, -0.047174, 0.000232, -45.868237, 2.978215, 216.217880);

 end

