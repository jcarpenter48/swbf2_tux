--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("ObjectiveTDM")


    --  Republic Attacking (attacker is always #1)
IMP = 2
ALL = 1
    --  These variables do not change
ATT = 1
DEF = 2


function ScriptPostLoad()
       --force all the human players onto the attacking side
	--ScriptCB_SetCanSwitchSides(false)
	
	KillObject("CP1")
	KillObject("CP2")
	KillObject("CP3")
	KillObject("CP4")
	KillObject("CP5")
	KillObject("NPCCP1")
    
    --hunt = Objective:New{textATT = "game.modes.hunt", textDEF = "game.modes.hunt2",}
    hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2, pointsPerKillATT = 1, pointsPerKillDEF = 1, textATT = "game.modes.hunt", textDEF = "game.modes.hunt2", multiplayerRules = true, hideCPs = true}
	
    hunt.OnStart = function(self)
    	AddAIGoal(ATT, "Deathmatch", 1000)
    	AddAIGoal(DEF, "Deathmatch", 1000)
    end
    
	--[[
    hunt_timer = CreateTimer("hunt_timer")
    SetTimerValue(hunt_timer, 300)
    StartTimer(hunt_timer)
    victory = OnTimerElapse(
    	function(timer)
    		MissionVictory(ATT)
    		ReleaseTimerElapse(victory)
    	end,
    	hunt_timer
    	)
    ShowTimer(hunt_timer)
   ]]--

	hunt:Start()
    EnableSPHeroRules()

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
    -- Designers, these two lines *MUST* be first!
    SetPS2ModelMemory(3897152)
    ReadDataFile("ingame.lvl")

	SetMemoryPoolSize("Music", 39)

	ReadDataFile("sound\\TatMusicFix.lvl")
    ReadDataFile("sound\\tat.lvl;tat3gcw")
ReadDataFile("SIDE\\all.lvl",
                    "all_inf_engineer",
                    "all_hero_luke_jedi")
    ReadDataFile("SIDE\\imp.lvl",                 
                    "imp_hero_bobafett")

    ReadDataFile("SIDE\\gam.lvl",
                             "gam_inf_gamorreanguard")
    
SetupTeams{

         all = {
            team = ALL,
            units = 25,
            reinforcements = -1,
            
            engineer = { "all_inf_engineer",0},
           
            
        },
        imp = {
            team = IMP,
            units = 25,
            reinforcements = -1,
            soldier  = { "gam_inf_gamorreanguard",18},
            
        },
}
       
    SetHeroClass(ALL, "all_hero_luke_jedi")
    SetHeroClass(IMP, "imp_hero_bobafett")
	SetTeamName(2, "locals")
        --  Level Stats
    ClearWalkers()
    AddWalkerType(0, 0)
    AddWalkerType(1, 0)
    AddWalkerType(2, 0)
    --SetMemoryPoolSize("EntityHover", 12)
    --SetMemoryPoolSize("EntityFlyer", 5)
    --  SetMemoryPoolSize("EntityBuildingArmedDynamic", 16)
    --  SetMemoryPoolSize("EntityTauntaun", 0)
    --  SetMemoryPoolSize("MountedTurret", 22)
    SetMemoryPoolSize("PowerupItem", 60)
    --SetMemoryPoolSize("SoundSpaceRegion", 161)
    SetMemoryPoolSize("EntityDroid", 8)
    SetMemoryPoolSize("EntityMine", 40)
    SetMemoryPoolSize("EntityLight", 151)
    SetMemoryPoolSize("Aimer", 4)
    SetMemoryPoolSize("MountedTurret", 0)
    SetMemoryPoolSize("PassengerSlot", 0)
    SetMemoryPoolSize("Ordnance", 100)

    SetMemoryPoolSize("Obstacle", 200)
    SetMemoryPoolSize("BaseHint", 100)
    SetMemoryPoolSize("TreeGridStack", 150)


    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("TAT\\tat3.lvl", "tat3_hunt")
    SetDenseEnvironment("true")
    --AddDeathRegion("Sarlac01")
    SetMaxFlyHeight(90)
    SetMaxPlayerFlyHeight(90)


    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
	AudioStreamAppendSegments("sound\\global.lvl", "gam_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    OpenAudioStream("sound\\tat.lvl",  "tat3")
    OpenAudioStream("sound\\tat.lvl",  "tat3")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\tat.lvl",  "tat3_emt")

    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(2, "Allleaving")
    SetOutOfBoundsVoiceOver(1, "Impleaving")

    SetAmbientMusic(ALL, 1.0, "all_tat_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.9, "all_tat_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.1, "all_tat_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_tat_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.9, "imp_tat_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.1, "imp_tat_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_tat_amb_victory")
    SetDefeatMusic (ALL, "all_tat_amb_defeat")
    SetVictoryMusic(IMP, "imp_tat_amb_victory")
    SetDefeatMusic (IMP, "imp_tat_amb_defeat")



    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")



    --  Camera Stats
    --Tat 3 - Jabbas' Palace
    AddCameraShot(0.685601, -0.253606, -0.639994, -0.236735, -65.939224, -0.176558, 127.400444)
    AddCameraShot(0.786944, 0.050288, -0.613719, 0.039218, -80.626396, 1.175180, 133.205551)
    AddCameraShot(0.997982, 0.061865, -0.014249, 0.000883, -65.227898, 1.322798, 123.976990)
    AddCameraShot(-0.367869, -0.027819, -0.926815, 0.070087, -19.548307, -5.736280, 163.360519)
    AddCameraShot(0.773980, -0.100127, -0.620077, -0.080217, -61.123989, -0.629283, 176.066025)
    AddCameraShot(0.978189, 0.012077, 0.207350, -0.002560, -88.388947, 5.674968, 153.745255)
    AddCameraShot(-0.144606, -0.010301, -0.986935, 0.070304, -106.872772, 2.066469, 102.783096)
    AddCameraShot(0.926756, -0.228578, -0.289446, -0.071390, -60.819584, -2.117482, 96.400620)
    AddCameraShot(0.873080, 0.134285, 0.463274, -0.071254, -52.071609, -8.430746, 67.122437)
    AddCameraShot(0.773398, -0.022789, -0.633236, -0.018659, -32.738083, -7.379394, 81.508003)
    AddCameraShot(0.090190, 0.005601, -0.993994, 0.061733, -15.379695, -9.939115, 72.110054)
    AddCameraShot(0.971737, -0.118739, -0.202524, -0.024747, -16.591295, -1.371236, 147.933029)
    AddCameraShot(0.894918, 0.098682, -0.432560, 0.047698, -20.577391, -10.683214, 128.752563)

end
