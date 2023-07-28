--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")

	--  Alliance Attacking (attacker is always #1)
    local CIS = 2
    local IMP = 1
    --  These variables do not change
    local ATT = 1
    local DEF = 2
    
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

	--create Jedi Knight hero
	SetClassProperty("jed_knight_02", "MaxHealth", 1200.0)
	SetClassProperty("jed_knight_02", "AddHealth", 0.0)
	SetClassProperty("jed_knight_02", "FleeLikeAHero", 1)
	SetClassProperty("jed_knight_02", "FoleyFXClass", "cis_inf_droid")
	SetClassProperty("jed_knight_02", "SoldierMusic", "all_hero_Chewbacca_lp")    
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
	if (ScriptCB_GetPlatform() == "PS2") then 
        SetPS2ModelMemory(6000000)
        --SetPSPClipper(1)
    end 
    --local assetLocation = "addon\\005\\"
    --if (ScriptCB_GetPlatform() == "PC") then 
    --    assetLocation = "DC:"
   -- end          
    SetPS2ModelMemory(6000000)
    ReadDataFile("ingame.lvl")
    --ReadDataFile(assetLocation .. "core.lvl")     
    
	SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",10)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",260)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",260) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",260)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",260)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",2800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",24)     -- should be ~1x #combo       -- should be ~1x #combo
	
    SetMaxFlyHeight(25)
    SetMaxPlayerFlyHeight (25)
    
    ReadDataFile("sound\\mus.lvl;mus1cross")
	--ReadDataFile("sound\\TDS.lvl;TDS_gcw")

    ReadDataFile("SIDE\\rep_128.lvl",
        "rep_hero_cloakedanakin") --dependency for some jedi
		
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
        --"jed_master_02",
        "jed_knight_02")
					
	SetupTeams{
		cis = {
			team = CIS,
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
     SetHeroClass(CIS, "jed_knight_02")
     SetHeroClass(IMP, "imp_hero_darthvader")  

    --  Level Stats
    --  ClearWalkers()
    AddWalkerType(0, 4) -- special -> droidekas
    AddWalkerType(1, 0) -- 1x2 (1 pair of legs)
    AddWalkerType(2, 0) -- 2x2 (2 pairs of legs)
    AddWalkerType(3, 0) -- 3x2 (3 pairs of legs)
    SetMemoryPoolSize("Aimer", 14)
	SetMemoryPoolSize("EntityCloth", 8)
	SetMemoryPoolSize("EntityFlyer", 6) -- to account for rocket upgrade
    --SetMemoryPoolSize("MountedTurret", 14)
    SetMemoryPoolSize("Obstacle", 157)
    SetMemoryPoolSize("PathNode", 128)
    SetMemoryPoolSize("TreeGridStack", 600)
	SetMemoryPoolSize("UnitAgent", 39)
	SetMemoryPoolSize("UnitController", 39)
	SetMemoryPoolSize("SoldierAnimation", 400)
    
    SetSpawnDelay(10.0, 0.25)
    --ReadDataFile("dc:RAV\\RAV.lvl", "RAV_conquest")
    ReadDataFile("SAL\\sal1.lvl", "SAL_conquest")
    SetDenseEnvironment("false")


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

--OpeningSateliteShot
	AddCameraShot(0.901391, -0.061852, -0.427560, -0.029339, -61.664173, 17.944555, 8.238253);
	AddCameraShot(0.148669, -0.006079, -0.988043, -0.040397, -13.304453, 15.213711, -38.896919);
	AddCameraShot(-0.204501, -0.001639, -0.978833, 0.007845, 77.053955, 15.213711, -18.844965);
	AddCameraShot(0.872585, 0.017622, -0.488045, 0.009856, -6.536069, 2.943680, -96.764313);
	AddCameraShot(-0.194349, 0.009613, -0.979688, -0.048457, 27.295074, 16.449509, -0.125231);

end
