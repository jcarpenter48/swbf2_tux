--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 

--  Empire Attacking (attacker is always #1)
CIS = 2
REP = 1
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
	SetTeamAggressiveness(REP, 1.0)
    SetTeamAggressiveness(CIS, 1.0)
	
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP19"}
    cp2 = CommandPost:New{name = "CP12"}
    cp3 = CommandPost:New{name = "CP17"}
    cp4 = CommandPost:New{name = "CP18"}
    cp5 = CommandPost:New{name = "CP16"}
    cp6 = CommandPost:New{name = "CP9"}
	cp7 = CommandPost:New{name = "CP15"}
    
    --This sets up the actual objective.  This needs to happen after cp's are defined
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, 
                                     textATT = "level.yavin1.con.att", 
                                     textDEF = "level.yavin1.con.def",
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
    
    
 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first!
	local numPlayers = ScriptCB_GetNumCameras() --better than checking number of plugged in controllers
    local isMultiplayer = ScriptCB_InMultiplayer() --I prefer checking once than for each if-block
	
    StealArtistHeap(600*1024)
    SetPS2ModelMemory(4100000)
    ReadDataFile("ingame.lvl")
    
    ReadDataFile("sound\\pol.lvl;pol1cw")
	ReadDataFile("sound\\TDS.lvl;TDS_cw")
	
	if((not isMultiplayer) and numPlayers < 3) then
		ReadDataFile("SIDE\\rep.lvl",
					"rep_inf_ep3_rifleman",
					"rep_inf_ep3_rocketeer",
					"rep_inf_ep3_engineer",
					"rep_inf_ep3_sniper", 
					"rep_inf_ep3_officer",
					--"rep_hero_macewindu",
					--"rep_fly_anakinstarfighter_sc",
					--"rep_fly_arc170fighter_sc",
					--"rep_fly_gunship_sc",
					"rep_inf_ep3_jettrooper")
					
		-- flyer sounds at the mo'
		ReadDataFile("SIDE\\rep_256.lvl",
					--"rep_hero_macewindu",
					"rep_hero_padme",
					--"rep_fly_gunship_sc",
					--"rep_fly_arc170fighter_sc",
					"rep_fly_jedifighter_sc")
					
		ReadDataFile("SIDE\\cis.lvl",
					"cis_inf_rifleman",
					"cis_inf_rocketeer",
					"cis_inf_engineer",
					"cis_inf_sniper",
					--"cis_hero_countdooku",
					--"cis_inf_droideka",
					--"cis_fly_droidgunship",
					--"cis_fly_droidfighter_sc",
					"cis_inf_officer")
										
		ReadDataFile("SIDE\\cis_256.lvl",
					"cis_inf_droideka",
					"cis_hero_zam",
					--"cis_hero_countdooku",
					--"cis_fly_droidgunship",
					"cis_fly_droidfighter_sc")
	end
	if(numPlayers > 2 or isMultiplayer) then
		    ReadDataFile("SIDE\\rep_256.lvl",
                "rep_inf_ep3_rifleman",
                "rep_inf_ep3_rocketeer",
                "rep_inf_ep3_engineer",
                "rep_inf_ep3_sniper", 
                "rep_inf_ep3_officer",
                --"rep_hero_macewindu",
				"rep_hero_padme",
				--"rep_fly_anakinstarfighter_sc",
				--"rep_fly_arc170fighter_sc",
				"rep_fly_jedifighter_sc",
				--"rep_fly_gunship_sc",
				"rep_inf_ep3_jettrooper")
                
                
			ReadDataFile("SIDE\\cis_256.lvl",
						"cis_inf_rifleman",
						"cis_inf_rocketeer",
						"cis_inf_engineer",
						"cis_inf_sniper",
						--"cis_hero_countdooku",
						"cis_hero_zam",
						"cis_inf_droideka",
						--"cis_fly_droidgunship",
						"cis_fly_droidfighter_sc",
						"cis_inf_officer")		
	end	
                

    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser")          
                
     
    
    SetupTeams{
             
        rep = {
            team = REP,
            units = 20,
            reinforcements = 150,
            soldier  = { "rep_inf_ep3_rifleman",9, 25},
            assault  = { "rep_inf_ep3_rocketeer",1, 4},
            engineer = { "rep_inf_ep3_engineer",1, 4},
            sniper   = { "rep_inf_ep3_sniper",1, 4},
            officer = {"rep_inf_ep3_officer",1, 4},
            special = { "rep_inf_ep3_jettrooper",1, 4},
            
        },
        cis = {
            team = CIS,
            units = 20,
            reinforcements = 150,
            soldier  = { "cis_inf_rifleman",9, 25},
            assault  = { "cis_inf_rocketeer",1, 4},
            engineer = { "cis_inf_engineer",1, 4},
            sniper   = { "cis_inf_sniper",1, 4},
            officer = {"cis_inf_officer",1, 4},
            special = { "cis_inf_droideka",1, 4},
        }
     }
    --SetHeroClass(CIS, "cis_hero_countdooku")
    --SetHeroClass(REP, "rep_hero_macewindu")
    SetHeroClass(CIS, "cis_hero_zam")
    SetHeroClass(REP, "rep_hero_padme")
   

    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 4) -- 3 droidekas (special case: 0 leg pairs)
        --   AddWalkerType(1, 3) 
        --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
		local weaponCnt = 230
		SetMemoryPoolSize("Aimer", 70)
		SetMemoryPoolSize("AmmoCounter", weaponCnt)
		SetMemoryPoolSize("BaseHint", 220)
		SetMemoryPoolSize("EnergyBar", weaponCnt)
		--SetMemoryPoolSize("EntityHover", 11)
		--SetMemoryPoolSize("EntityLight", 40)
		--SetMemoryPoolSize("EntityCloth", 58)
		SetMemoryPoolSize("EntityFlyer", 18)
		--SetMemoryPoolSize("EntitySoundStream", 3)
		--SetMemoryPoolSize("EntitySoundStatic", 120)
		SetMemoryPoolSize("MountedTurret", 12)
		SetMemoryPoolSize("Navigator", 50)
		SetMemoryPoolSize("Obstacle", 300)
		SetMemoryPoolSize("PathFollower", 50)
		SetMemoryPoolSize("PathNode", 512)
		--SetMemoryPoolSize("TentacleSimulator", 8)
		SetMemoryPoolSize("TreeGridStack", 300)
		SetMemoryPoolSize("UnitAgent", 50)
		SetMemoryPoolSize("UnitController", 50)
		--SetMemoryPoolSize("Weapon", weaponCnt)

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("bes\\bs1.lvl","bs1_Conquest")
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
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\bes.lvl",  "pol1")
    OpenAudioStream("sound\\pol.lvl",  "pol1")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    -- OpenAudioStream("sound\\pol.lvl",  "pol1_emt")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, REP, "cis_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(1, "cisleaving")
    SetOutOfBoundsVoiceOver(2, "repleaving")

    SetAmbientMusic(REP, 1.0, "rep_pol_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_pol_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_pol_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_pol_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_pol_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2,"cis_pol_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_pol_amb_victory")
    SetDefeatMusic (REP, "rep_pol_amb_defeat")
    SetVictoryMusic(CIS, "cis_pol_amb_victory")
    SetDefeatMusic (CIS, "cis_pol_amb_defeat")

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


