 --
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveTDM")

    --  REP Attacking (attacker is always #1)
    local REP = 2;
    local CIS = 1;
    --  These variables do not change
    local ATT = 1;
    local DEF = 2;
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
	SetTeamAsFriend(2,2)
	SetTeamAsEnemy(1, 2)
	SetTeamAsEnemy(2, 1)
	
	--fix the jettrooper sniper
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetJump", "5.0")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetPush", "8.0")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetAcceleration", "30.0")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetEffect", "rep_sfx_jetpack")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetType", "hover")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetFuelRechargeRate", "0.12")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetFuelCost", "0.16")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetFuelInitialCost", "0.25")
	SetClassProperty("rep_inf_ep2_jettrooper_sniper", "JetFuelMinBorder", "0.24")
	
	SetProperty("cp1", "Team", "1")
    SetProperty("cp1", "CaptureRegion", " ")
    SetProperty("cp2", "Team", "2")
    SetProperty("cp2", "spawnpath", "cp2_spawn")
    SetProperty("cp2", "CaptureRegion", " ")
	SetProperty("cp3", "Team", "1")
    SetProperty("cp3", "CaptureRegion", " ")
	SetProperty("cp4", "Team", "2")
    SetProperty("cp4", "CaptureRegion", " ")
	SetProperty("cp5", "Team", "1")
    SetProperty("cp5", "CaptureRegion", " ")
	SetProperty("cp6", "Team", "2")
    SetProperty("cp6", "CaptureRegion", " ")
	
	SetClassProperty("rep_inf_ep2_jettrooper_rifleman", "PointsToUnlock", "0")
    SetClassProperty("rep_inf_ep2_jettrooper_sniper", "PointsToUnlock", "0")
	SetClassProperty("rep_inf_ep2_jettrooper", "PointsToUnlock", "6")
	SetClassProperty("imp_inf_dark_trooper", "PointsToUnlock", "6")
	SetClassProperty("rep_inf_ep2_rocketeer_chaingun", "WeaponName4", "imp_weap_inf_powerup_dispenser")
	
DisableBarriers("frog")
DisableBarriers("close")
DisableBarriers("camp")

    UnblockPlanningGraphArcs("connection71")

     SetProperty("cp1", "Team", "1")
    SetProperty("cp2", "Team", "2")
    SetProperty("cp3", "Team", "2")
    SetProperty("cp4", "Team", "2")
    SetProperty("cp5", "Team", "1")
    SetProperty("cp6", "Team", "1")
    SetAIDamageThreshold("Comp1", 0 )
    SetAIDamageThreshold("Comp2", 0 )
    SetAIDamageThreshold("Comp3", 0 )
    SetAIDamageThreshold("Comp4", 0 )
    SetAIDamageThreshold("Comp5", 0 )
  	SetAIDamageThreshold("Comp6", 0 )
    SetAIDamageThreshold("Comp7", 0 )
    SetAIDamageThreshold("Comp8", 0 )
    SetAIDamageThreshold("Comp9", 0 )
    SetAIDamageThreshold("Comp10", 0 )



	        SetProperty("Kam_Bldg_Podroom_Door32", "Islocked", 1)

    SetProperty("Kam_Bldg_Podroom_Door33", "Islocked", 1)
        SetProperty("Kam_Bldg_Podroom_Door32", "Islocked", 1)
                SetProperty("Kam_Bldg_Podroom_Door34", "Islocked", 1)
    SetProperty("Kam_Bldg_Podroom_Door35", "Islocked", 1)
        SetProperty("Kam_Bldg_Podroom_Door27", "Islocked", 0)       
            SetProperty("Kam_Bldg_Podroom_Door28", "Islocked", 1)       
    SetProperty("Kam_Bldg_Podroom_Door36", "Islocked", 1)
        SetProperty("Kam_Bldg_Podroom_Door20", "Islocked", 0)
    UnblockPlanningGraphArcs("connection71")
        
   --Objective1
    UnblockPlanningGraphArcs("connection85")
        UnblockPlanningGraphArcs("connection48")
            UnblockPlanningGraphArcs("connection63")
                UnblockPlanningGraphArcs("connection59")
                         UnblockPlanningGraphArcs("close")
                         UnblockPlanningGraphArcs("open")
                         DisableBarriers("frog")
                         DisableBarriers("close")
                         DisableBarriers("open")
        
    --blocking Locked Doors
    UnblockPlanningGraphArcs("connection194");
        UnblockPlanningGraphArcs("connection200");
            UnblockPlanningGraphArcs("connection118");
               DisableBarriers("FRONTDOOR2-3");
                DisableBarriers("FRONTDOOR2-1");  
                 DisableBarriers("FRONTDOOR2-2");  
   
    --Lower cloning facility
    UnblockPlanningGraphArcs("connection10")
        UnblockPlanningGraphArcs("connection159")
            UnblockPlanningGraphArcs("connection31")
               DisableBarriers("FRONTDOOR1-3")
                DisableBarriers("FRONTDOOR1-1")  
                 DisableBarriers("FRONTDOOR1-2")
    
        --This defines the CPs.  These need to happen first
    --[[cp1 = CommandPost:New{name = "cp1"}
    cp2 = CommandPost:New{name = "cp2"}
    cp3 = CommandPost:New{name = "cp3"}
    cp4 = CommandPost:New{name = "cp4"}
    cp5 = CommandPost:New{name = "cp5"}
   	cp6 = CommandPost:New{name = "cp6"}]]--
    
    hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2, pointsPerKillATT = 2, pointsPerKillDEF = 1, textATT = "game.modes.hunt", textDEF = "game.modes.hunt2", multiplayerRules = true}
    
    hunt.OnStart = function(self)
    	AddAIGoal(ATT, "Deathmatch", 1000)
    	AddAIGoal(DEF, "Deathmatch", 1000)
    end
   

	hunt:Start()  
    
    BlockPlanningGraphArcs("group1");
        BlockPlanningGraphArcs("connection165");
            BlockPlanningGraphArcs("connection162");
                BlockPlanningGraphArcs("connection160");
                    BlockPlanningGraphArcs("connection225");
end

function ScriptInit()
	StealArtistHeap(2048*1024)
    -- Designers, these two lines *MUST* be first!
    SetPS2ModelMemory(3000000)
    ReadDataFile("ingame.lvl")

    ReadDataFile("sound\\kam.lvl;kam1cross")
    ReadDataFile("SIDE\\rep.lvl",
                             "rep_inf_ep2_jettrooper_sniper",
                             "rep_inf_ep2_jettrooper_rifleman",
							 "rep_inf_ep2_jettrooper",
                             "rep_inf_ep2_rocketeer_chaingun")
                           
                            
        ReadDataFile("SIDE\\imp.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_engineer",
                    "imp_inf_sniper",
                    "imp_inf_dark_trooper",
                    "imp_inf_officer")

	ReadDataFile("SIDE\\tur.lvl",
						"tur_bldg_chaingun_roof",
						"tur_weap_built_gunturret")	

   SetAttackingTeam(ATT)
	SetupTeams{
		rep = {
			team = REP,
			units = 26,
			reinforcements = 150,
			soldier = { "rep_inf_ep2_jettrooper_rifleman",9, 25},
			sniper  = { "rep_inf_ep2_jettrooper_sniper",1, 4},
			officer = { "rep_inf_ep2_rocketeer_chaingun",1, 4},
			special = { "rep_inf_ep2_jettrooper",1,4},
				
		},
		cis = {
			team = CIS,
			units = 26,
			reinforcements = 150,
			soldier = { "imp_inf_rifleman",9, 25},
			assault = { "imp_inf_rocketeer",1, 4},
			engineer = { "imp_inf_engineer", 1, 4},
			sniper  = { "imp_inf_sniper",1, 4},
			officer = { "imp_inf_officer",1, 4},
			special = { "imp_inf_dark_trooper",1,4},
		  
		},

	}
    SetTeamName(CIS, "Empire")
        SetTeamName(REP, "locals")
		SetTeamIcon(REP, "rep_icon")
    --SetTeamAsNeutral(1, 2)
	SetTeamAsEnemy(2, 1)
	SetTeamAsNeutral(1, 2)
	SetTeamAsNeutral(2, 2)
    --  Level Stats
    ClearWalkers()
 
    --AddWalkerType(0, 6) -- droidekas
    local weaponCnt = 215
    SetMemoryPoolSize("Aimer", 39)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 210)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth", 18)
    SetMemoryPoolSize("EntityLight", 70)
    SetMemoryPoolSize("EntitySoundStream", 3)
    SetMemoryPoolSize("EntitySoundStatic", 84)
    SetMemoryPoolSize("MountedTurret", 22)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 800)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("PathNode", 256)
    SetMemoryPoolSize("SoundSpaceRegion", 36)
    SetMemoryPoolSize("TentacleSimulator", 0)
    SetMemoryPoolSize("TreeGridStack", 338)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("EntityFlyer", 6)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon", weaponCnt)
    
    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("kam\\kam1.lvl", "kamino1_conquest")
    SetDenseEnvironment("false")

    --  AI
    SetMinFlyHeight(60)
    SetAllowBlindJetJumps(0)
       SetMaxFlyHeight(102)
    SetMaxPlayerFlyHeight(102)

    --  Sound
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_quick", voiceQuick)   
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\kam.lvl",  "kam1")
    OpenAudioStream("sound\\kam.lvl",  "kam1")


    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, REP, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "imp_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, REP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, CIS, "imp_off_victory_im", .1, 1)    

    SetAmbientMusic(REP, 1.0, "rep_kam_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_kam_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2, "rep_kam_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_kam_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_kam_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2, "cis_kam_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_kam_amb_victory")
    SetDefeatMusic (REP, "rep_kam_amb_defeat")
    SetVictoryMusic(CIS, "cis_kam_amb_victory")
    SetDefeatMusic (CIS, "cis_kam_amb_defeat")

    SetOutOfBoundsVoiceOver(2, "repleaving")
    SetOutOfBoundsVoiceOver(1, "impleaving")

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

    AddDeathRegion("deathregion")

 		    AddCameraShot(0.564619, -0.121047, 0.798288, 0.171142, 68.198814, 79.137611, 110.850922);

            AddCameraShot(-0.281100, 0.066889, -0.931340, -0.221616, 10.076019, 82.958336, -26.261774);

            AddCameraShot(0.209553, -0.039036, -0.960495, -0.178923, 92.558563, 58.820618, 130.675919);

            AddCameraShot(0.968794, 0.154227, 0.191627, -0.030506, -173.914413, 69.858940, 52.532421);

            AddCameraShot(0.744389, 0.123539, 0.647364, -0.107437, 97.475639, 53.216236, 76.477089);

            AddCameraShot(-0.344152, 0.086702, -0.906575, -0.228393, 95.062233, 105.285820, -37.661552);
end
