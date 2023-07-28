--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
--credits to Noobasaurus
--needs to be updated with objective text
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("Ambush")
	--  REP Attacking (attacker is always #1)
    REP = 1;
    CIS = 2;
    TAR = 3;
    CIV = 4;
    --  These variables do not change
    ATT = REP;
    DEF = CIS;
	
local numPlayers = ScriptCB_GetNumCameras() --better than checking number of plugged in controllers
	
function ScriptPostLoad()

--our assassins
	SetClassProperty("all_inf_officer","PointsToUnlock","0")
	SetClassProperty("all_inf_wookiee","PointsToUnlock","0")

	SetClassProperty("all_inf_sniper_fleet", "GeometryName", "all_inf_bothanspy")
	SetClassProperty("all_inf_sniper_fleet", "GeometryLowRes", "all_inf_bothanspy_low1")

	SetClassProperty("all_inf_rifleman_fleet", "GeometryName", "all_inf_engineer")
	SetClassProperty("all_inf_rifleman_fleet", "GeometryLowRes", "all_inf_engineer_low1")

	SetClassProperty("all_inf_rocketeer_fleet", "GeometryName", "all_inf_engineer")
	SetClassProperty("all_inf_rocketeer_fleet", "GeometryLowRes", "all_inf_engineer_low1")	
--our defenders
	SetClassProperty("imp_inf_officer","PointsToUnlock","0")
	SetClassProperty("imp_inf_officer", "MaxHealth", 1400.0)
	SetClassProperty("imp_inf_officer", "AddHealth", 0.0)
	SetClassProperty("imp_inf_officer", "FleeLikeAHero", 0)
	
	SetClassProperty("imp_inf_rifleman", "GeometryName", "rep_inf_ep3trooper")
	SetClassProperty("imp_inf_rifleman", "GeometryLowRes", "rep_inf_ep3trooper_low1")
	
	if (numPlayers < 2) then
	  ForceHumansOntoTeam1() --if in singleplayer, force humans to team 1
	end
        --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "cp1"}
    cp2 = CommandPost:New{name = "cp2"}
    cp3 = CommandPost:New{name = "cp3"}

	cp6 = CommandPost:New{name = "cp6"}
	cp7 = CommandPost:New{name = "cp7"}
	cp8 = CommandPost:New{name = "cp8"}

    
    --This sets up the actual objective.  This needs to happen after cp's are defined
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, textATT = "game.modes.con", textDEF = "game.modes.con2", multiplayerRules = true}
    
    --This adds the CPs to the objective.  This needs to happen after the objective is set up
	conquest:AddCommandPost(cp1)
	conquest:AddCommandPost(cp2)
	conquest:AddCommandPost(cp3)

	conquest:AddCommandPost(cp6)
	conquest:AddCommandPost(cp7)
	conquest:AddCommandPost(cp8)


conquest:Start()
	-----------------KILL THE TARGET AND ESCAPE STARTS RIGHT HERE RIGHT NOW
	
	--ForceHumansOntoTeam1() --more fun not forcing this this way 
	AICanCaptureCP("cp1", 2, false)
	AICanCaptureCP("cp2", 2, false)
	AICanCaptureCP("cp3", 2, false)
	AICanCaptureCP("cp6", 2, false)
	AICanCaptureCP("cp7", 2, false)
	AICanCaptureCP("cp8", 2, false)
	AICanCaptureCP("cp1", 3, false)
	AICanCaptureCP("cp2", 3, false)
	AICanCaptureCP("cp3", 3, false)
	AICanCaptureCP("cp6", 3, false)
	AICanCaptureCP("cp7", 3, false)
	AICanCaptureCP("cp8", 3, false)
	    SetProperty("cp6", "Team", "4")
		SetProperty("cp2", "Team", "4")
	SetAIDifficulty(999, -999, "hard")
	target = GetTeamMember(3,0)
	AddAIGoal(4, "deathmatch", 100)
	AddAIGoal(4, "conquest", 100)
	AddAIGoal(3, "deathmatch", 100)
	--AddAIGoal(2, "deathmatch", 100)
	SelectCharacterClass(target, "imp_inf_officer")
	SpawnCharacter(target, GetPathPoint("CP3_SpawnPath", 0)) --target spawnpoint
	
	dumb = CreateTimer("dumb")
	SetTimerValue(dumb, 0.5)
	StartTimer(dumb)
	
	
	OnTimerElapse(
	  function(timer)
		ClearAIGoals(2)
		AddAIGoal(2, "follow", 1000, GetCharacterUnit(target))
		MapAddEntityMarker(GetCharacterUnit(target), "hud_objective_icon_circle", 5, 1, "RED", true, true, true)
		DestroyTimer(dumb)
		--spawn civilians
		Ambush("cp6_spawn", 4, 4)
		Ambush("cp2_spawn", 10, 4)
	  end,
	dumb
	)
	
	SetTeamAsFriend(2,1)
	SetTeamAsNeutral(1,3)
	SetTeamAsFriend(3,1)
	SetTeamAsFriend(1,2)
	SetTeamAsFriend(4,1)
	SetTeamAsFriend(4,2)
	SetTeamAsFriend(4,3)
	SetTeamAsFriend(1,4)
	SetTeamAsFriend(2,4)
	SetTeamAsFriend(3,4)
	SetTeamAsFriend(2,3)
	SetTeamAsFriend(3,2)
	
	tarhp = nil
	
      onfirstspawn = OnCharacterSpawn(
        function(character)
			if IsCharacterHuman(character) then
				ReleaseCharacterSpawn(onfirstspawn)
				onfirstspawn = nil
				MoveCameraToEntity(GetCharacterUnit(target))
				AllowAISpawn(2, false)
				AllowAISpawn(3, false)
				AllowAISpawn(4, true)
				AddAIGoal(4, "destroy", 1000, 0)
				Ambush("cp6_spawn", 4, 4)
				Ambush("cp2_spawn", 10, 4)
				tarhp = GetObjectHealth(GetCharacterUnit(target))
				--ShowMessageText("level.abc.kill")
				ShowMessageText("level.tat2.objectives.target")
			end
        end
		)
		
	deathcheck = OnCharacterDeath(
		function(character, killer)
			if GetNumTeamMembersAlive(1) == 0 then
				MissionDefeat(1)
			elseif GetNumTeamMembersAlive(3) == 0 then
				ClearAIGoals(2)
				AddAIGoal(2, "destroy", 1000, GetCharacterUnit(killer))
				ActivateRegion("CP2_Control")
				SetTeamAsEnemy(1,2)
				SetTeamAsEnemy(2,1)
				MapAddRegionMarker("CP2_Control", "hud_objective_icon_circle", 5, 1, "BLUE", true, true, true)
				ShowMessageText("level.tat2.objectives.escape")
			end
		end)
		
	i = 1
		
	TEAM = OnCharacterDeath(
		function(character, killer)
			if GetObjectTeam(killer) == 1 then
				SpawnCharacter(GetTeamMember(1,i),GetEntityMatrix(killer))
				i = i + 1
			end
		end)
		
	wincheck = OnEnterRegion(
		function(region, character)
			ShowMessageText("level.spa5.objectives.campaign.3c")
			MissionVictory(1)
		end,
		"CP2_Control"
		)
		
	x = 1
	
	AllowAISpawn(1, false)
	
	dmgcheck = OnObjectDamage(function(object, damager)
		print("check")
		if GetObjectTeam(GetCharacterUnit(damager)) == 1 and x == 1 then
			ClearAIGoals(3)
			AddAIGoal(3, "follow", 1000, "com_item_weaponrecharge0")
			ClearAIGoals(2)
			AddAIGoal(2, "destroy", 500, GetCharacterUnit(damager))
			AddAIGoal(2, "follow", 500, GetCharacterUnit(target))
			SetTeamAsEnemy(1,2)
			SetTeamAsEnemy(2,1)
			x = 2
		end
	end)
	
	SetClassProperty("imp_inf_officer", "IgnoreHintNodes", "1")
	SetClassProperty("imp_inf_rifleman", "IgnoreHintNodes", "1")
			
			SetTeamAggressiveness(2, 1.0)
			DisableAIAutoBalance()
			SetAIDifficulty(0, 3)
			
			-------------------------------KILL THE TARGET ENDS
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
    StealArtistHeap(256*1024)
    SetPS2ModelMemory(2097152 + 65536 * 10)
    ReadDataFile("ingame.lvl")



    SetTeamAggressiveness(REP, 0.95)
    SetTeamAggressiveness(CIS, 0.95)

    SetMaxFlyHeight(40)
	SetMaxPlayerFlyHeight(40)

    ReadDataFile("sound\\tat.lvl;tat2gcw")
    --[[ReadDataFile("SIDE\\rep.lvl",
                        "rep_inf_ep3_rocketeer",
                        "rep_inf_ep3_rifleman",
                        "rep_inf_ep3_sniper",
                        "rep_inf_ep3_engineer",
                        "rep_inf_ep3_jettrooper",
                        "rep_inf_ep3_officer",
                        "rep_hero_obiwan")]]--

    ReadDataFile("SIDE\\all.lvl",
                    "all_inf_rifleman_fleet",
                    "all_inf_rocketeer_fleet",
                    "all_inf_sniper_fleet",
                    "all_inf_engineer_fleet",
                    "all_inf_officer",
                    "all_inf_wookiee")

    ReadDataFile("SIDE\\imp_256.lvl",
					"imp_inf_officer",
                    "imp_inf_rifleman")
					
    --ReadDataFile("SIDE\\cis_256.lvl", "cis_hero_darthmaul")
					
	ReadDataFile("SIDE\\rep_256.lvl",	"rep_inf_ep3_rifleman")	
    --ReadDataFile("SIDE\\rep_256.lvl",	"rep_inf_ep3_rocketeer")	
 
    ReadDataFile("SIDE\\des.lvl",
                             "tat_inf_jawa")

	ReadDataFile("SIDE\\tur.lvl",
						"tur_bldg_tat_barge",	
						"tur_bldg_laser")	


	SetupTeams{
		rep = {
			team = REP,
			units = 10,
			reinforcements = -1,
			soldier  = { "all_inf_rifleman_fleet",1, 9},
			assault  = { "all_inf_rocketeer_fleet",0, 2},
			engineer = { "all_inf_engineer_fleet",0, 2},
			sniper   = { "all_inf_sniper_fleet",0, 2},
			officer = {"all_inf_officer",0, 2},
			special = { "all_inf_wookiee",0, 2},
	        
		},
		cis = {
			team = CIS,
			units = 10,
			reinforcements = -1,
			officer = {"imp_inf_rifleman",12, 12},
		}
	}

	AddUnitClass (REP, "tat_inf_jawa", 1)
	
    SetTeamName (3, "target")
    AddUnitClass (3, "imp_inf_officer", 1)
    SetUnitCount (3, 1)
	
    SetTeamName (4, "citizens")
    AddUnitClass (4, "all_inf_rifleman_fleet", 1,10)
    AddUnitClass (4, "all_inf_rocketeer_fleet", 1,10)
    AddUnitClass (4, "all_inf_engineer_fleet", 1,10)
    AddUnitClass (4, "all_inf_sniper_fleet", 1,10)
    AddUnitClass (4, "all_inf_officer", 1,10)
	AddUnitClass (4, "tat_inf_jawa", 1,10)
    SetUnitCount (4, 15)
	AddAIGoal(4, "conquest", 100)

	SetTeamAsNeutral(4,1)
	SetTeamAsNeutral(4,2)
	SetTeamAsNeutral(4,3)
	SetTeamAsNeutral(1,4)
	SetTeamAsNeutral(2,4)
	SetTeamAsNeutral(3,4)
	
    SetHeroClass(CIS, "imp_inf_officer")
      SetHeroClass(REP, "rep_hero_obiwan")

    --  Level Stats
    ClearWalkers()
    --AddWalkerType(0, 3) -- special -> droidekas
    AddWalkerType(1, 0) -- 1x2 (1 pair of legs)
    AddWalkerType(2, 0) -- 2x2 (2 pairs of legs)
    AddWalkerType(3, 0) -- 3x2 (3 pairs of legs)
    
    local weaponCnt = 128
    SetMemoryPoolSize("Aimer", 23)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 325)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth", 19)
	SetMemoryPoolSize("EntityFlyer", 6) -- to account for rocket upgrade
    SetMemoryPoolSize("EntityHover", 1)
    SetMemoryPoolSize("EntitySoundStream", 2)
    SetMemoryPoolSize("EntitySoundStatic", 43)
    SetMemoryPoolSize("SoldierAnimation", 500)
    SetMemoryPoolSize("MountedTurret", 15)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 667)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("PathNode", 256)
    SetMemoryPoolSize("TreeGridStack", 325)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon", weaponCnt)

    SetSpawnDelay(0.0, 0.0)
    ReadDataFile("TAT\\tat2.lvl", "tat2_con")
    SetDenseEnvironment("false")


    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "imp_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "all_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "des_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "imp_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "all_unit_vo_quick", voiceQuick)     
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\tat.lvl",  "tat2")
    OpenAudioStream("sound\\tat.lvl",  "tat2")

    SetOutOfBoundsVoiceOver(REP, "allleaving")
    SetOutOfBoundsVoiceOver(CIS, "impleaving")

    SetAmbientMusic(REP, 1.0, "all_tat_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "all_tat_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"all_tat_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "imp_tat_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "imp_tat_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2,"imp_tat_amb_end",    2,1)

    SetVictoryMusic(REP, "all_tat_amb_victory")
    SetDefeatMusic (REP, "all_tat_amb_defeat")
    SetVictoryMusic(CIS, "imp_tat_amb_victory")
    SetDefeatMusic (CIS, "imp_tat_amb_defeat")

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
    --Tat2 Mos Eisley
	AddCameraShot(0.974338, -0.222180, 0.035172, 0.008020, -82.664650, 23.668301, 43.955681);
	AddCameraShot(0.390197, -0.089729, -0.893040, -0.205362, 23.563562, 12.914885, -101.465561);
	AddCameraShot(0.169759, 0.002225, -0.985398, 0.012916, 126.972809, 4.039628, -22.020613);
	AddCameraShot(0.677453, -0.041535, 0.733016, 0.044942, 97.517807, 4.039628, 36.853477);
	AddCameraShot(0.866029, -0.156506, 0.467299, 0.084449, 7.685640, 7.130688, -10.895234);
end