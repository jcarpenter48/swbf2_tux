--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams")

--  Empire Attacking (attacker is always #1)
CIS = 1
REP = 2
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
	SetHistorical()
	
 	SetProperty("CP19", "Team", "1")
    SetProperty("CP19", "CaptureRegion", " ")
    SetProperty("CP12", "Team", "1")
    SetProperty("CP12", "CaptureRegion", " ")
	SetProperty("CP17", "Team", "2")
    SetProperty("CP17", "CaptureRegion", " ")
	SetProperty("CP18", "Team", "2")
    SetProperty("CP18", "CaptureRegion", " ")
	SetProperty("CP16", "Team", "1")
    SetProperty("CP16", "CaptureRegion", " ")
	SetProperty("CP9", "Team", "2")
    SetProperty("CP9", "CaptureRegion", " ")
	SetProperty("CP15", "Team", "2")
    SetProperty("CP15", "CaptureRegion", " ")
	
	SetTeamAggressiveness(REP, 1.0)
    SetTeamAggressiveness(CIS, 1.0)
	
    hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2,
            pointsPerKillATT = 1, pointsPerKillDEF = 1,
            textATT = "game.modes.hunt", textDEF = "game.modes.hunt2", multiplayerRules = true}            

	hunt:Start()


    
    hunt.OnStart = function(self)
    	AddAIGoal(ATT, "Deathmatch", 1000)
    	AddAIGoal(DEF, "Deathmatch", 1000)
    end
    
    
 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(600*1024)
    SetPS2ModelMemory(4100000)
    ReadDataFile("ingame.lvl")

    CIS = ATT
    REP = DEF
    
	ReadDataFile("sound\\cor.lvl;cor1gcw")
    ReadDataFile("SOUND\\BS1.lvl;BS1gcw") 
    --ReadDataFile("sound\\pol.lvl;pol1gcw")
    ReadDataFile("SIDE\\all.lvl",
                "all_inf_rifleman")
    
	ReadDataFile("SIDE\\bespin.lvl",
                "bes_inf_guard")	
                
	ReadDataFile("SIDE\\imp_256.lvl",
					"imp_fly_tiefighter_sc",
                    "imp_inf_pilot")
                

    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser")          
                
     
    
    SetupTeams{
             
        rep = {
            team = REP,
            units = 24,
            reinforcements = 150,
            soldier  = { "bes_inf_guard",9, 25},
            
        },
        cis = {
            team = CIS,
            units = 24,
            reinforcements = 150,
            soldier  = { "imp_inf_pilot",9, 25},
            --assault  = { "imp_inf_rifleman",1, 4},
        }
     }
    SetTeamName(CIS, "Empire")
    SetTeamName(REP, "locals")

   

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
		--SetMemoryPoolSize("EntityCloth", 58)
		SetMemoryPoolSize("EntityFlyer", 12)
		--SetMemoryPoolSize("EntitySoundStream", 3)
		--SetMemoryPoolSize("EntitySoundStatic", 120)
		SetMemoryPoolSize("MountedTurret", 12)
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
     ReadDataFile("bes\\bs1.lvl","bs1_conquest")
     SetDenseEnvironment("True")   
     AddDeathRegion("death_region")
	 
    SetMapNorthAngle(0)
    SetMinFlyHeight(-300)
    SetMaxFlyHeight(500)
    SetMinPlayerFlyHeight(-300)
    SetMaxPlayerFlyHeight(500)

    SetAIVehicleNotifyRadius(64)
    SetStayInTurrets(1)
	
    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
	OpenAudioStream("sound\\BS1.lvl",  "BS1")
    OpenAudioStream("sound\\BS1.lvl",  "BS1")
    --OpenAudioStream("sound\\bes.lvl",  "pol1")
    --OpenAudioStream("sound\\pol.lvl",  "pol1")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    -- OpenAudioStream("sound\\pol.lvl",  "pol1_emt")

    SetBleedingVoiceOver(CIS, CIS, "imp_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(CIS, REP, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(REP, CIS, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(REP, REP, "all_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(CIS, CIS, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, REP, "imp_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, REP, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, CIS, "all_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(2, "allleaving")
    SetOutOfBoundsVoiceOver(1, "impleaving")

    SetAmbientMusic(REP, 1.0, "all_cor_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "all_cor_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2, "all_cor_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "imp_cor_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "imp_cor_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2, "imp_cor_amb_end",    2,1)

    SetVictoryMusic(REP, "all_cor_amb_victory")
    SetDefeatMusic (REP, "all_cor_amb_defeat")
    SetVictoryMusic(CIS, "imp_cor_amb_victory")
    SetDefeatMusic (CIS, "imp_cor_amb_defeat")

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
	--Bes1 Platforms
	--Platform Sky
	AddCameraShot(0.793105, -0.062986, -0.603918, -0.047962, -170.583618, 118.981544, -150.443253);
	--Control Room
	AddCameraShot(0.189716, 0.000944, -0.981826, 0.004887, -27.594292, 100.583740, -176.478012);
	--Extractor
	AddCameraShot(0.492401, 0.010387, -0.870113, 0.018354, 19.590666, 100.493599, -47.846901);


end


