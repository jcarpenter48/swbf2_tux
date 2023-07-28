--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams")
--ScriptCB_DoFile("ObjectiveConquest")

    --  Empire Attacking (attacker is always #1)
    local ALL = 1
    local IMP = 2
    --  These variables do not change
    local ATT = 1
    local DEF = 2

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
                
    TrashStuff();
    PlayAnimExtend();
    PlayAnimTakExtend();
    
    BlockPlanningGraphArcs("compactor")
    OnObjectKillName(CompactorConnectionOn, "grate01")
    
    DisableBarriers("start_room_barrier")
    DisableBarriers("dr_left")
    DisableBarriers("circle_bar1")
    DisableBarriers("circle_bar2")
    
    -- handle reinforcment loss and defeat condition
    OnCharacterDeathTeam(function(character, killer) AddReinforcements(1, -1) end, 1)
    OnTicketCountChange(function(team, count) if count == 0 then 
			MapRemoveClassMarker("all_hero_luke_storm")
			MapRemoveClassMarker("all_hero_hansolo_storm")
			MapRemoveClassMarker("all_hero_chewbacca")
			MapRemoveClassMarker("all_hero_leia")
			MapRemoveClassMarker("rep_hero_obiwan")
			MapRemoveClassMarker("all_inf_lukeskywalker")
			MapRemoveClassMarker("imp_hero_darthvader")
			MissionDefeat(team) 
			end 
		end)

    OnObjectRespawnName(PlayAnimExtend, "Panel-Chasm");
    OnObjectKillName(PlayAnimRetract, "Panel-Chasm");

    OnObjectRespawnName(PlayAnimTakExtend, "Panel-Tak");
    OnObjectKillName(PlayAnimTakRetract, "Panel-Tak");
    
    EnableSPHeroRules()
    KillObject("CP6")
    SetProperty("CP1", "Team", "2")
    SetProperty("CP2", "Team", "1")
    SetProperty("CP3", "Team", "2")
    SetProperty("CP4", "Team", "3")
    SetProperty("CP5", "Team", "2")
    SetProperty("CP7", "Team", "3")
    SetProperty("CP1", "CaptureRegion", "nil")
    SetProperty("CP2", "CaptureRegion", "nil")
    SetProperty("CP3", "CaptureRegion", "nil")
    SetProperty("CP4", "CaptureRegion", "nil")
    SetProperty("CP5", "CaptureRegion", "nil")
    SetProperty("CP7", "CaptureRegion", "nil")
    SetProperty("CP1", "HUDIndexDisplay", "")
    SetProperty("CP2", "HUDIndexDisplay", "")
    SetProperty("CP3", "HUDIndexDisplay", "")
    SetProperty("CP4", "HUDIndexDisplay", "")
    SetProperty("CP5", "HUDIndexDisplay", "")
    SetProperty("CP7", "HUDIndexDisplay", "")
    SetClassProperty("com_bldg_major_controlzone", "SwitchClassRadius", 5.0)
    SetClassProperty("rep_hero_obiwan", "PointsToUnlock", 24)
	SetClassProperty("all_hero_luke_storm", "WeaponName1", "imp_weap_inf_rifle")

		-- This is the actual objective setup
    hunt = Objective:New{textATT = "game.modes.hunt2", textDEF = "game.modes.hunt", multiplayerRules = true, hideCPs = true}
    
    hunt.OnStart = function(self)
    	AddAIGoal(ATT, "Deathmatch", 1000)
    	AddAIGoal(DEF, "Deathmatch", 1000)
    	AddAIGoal(3, "Deathmatch", 1000)
        ----[[
		MapAddClassMarker("all_hero_luke_storm", "hud_objective_icon_circle", 3.5, DEF, "YELLOW", true)
        MapAddClassMarker("all_hero_hansolo_storm", "hud_objective_icon_circle", 3.5, DEF, "YELLOW", true)
        MapAddClassMarker("all_hero_chewbacca", "hud_objective_icon_circle", 3.5, DEF, "YELLOW", true)
        MapAddClassMarker("all_hero_leia", "hud_objective_icon_circle", 3.5, DEF, "YELLOW", true)
        MapAddClassMarker("rep_hero_obiwan", "hud_objective_icon_circle", 3.5, DEF, "YELLOW", true)
        MapAddClassMarker("all_inf_lukeskywalker", "hud_objective_icon_circle", 3.5, DEF, "YELLOW", true)
        MapAddClassMarker("imp_hero_darthvader", "hud_objective_icon_circle", 3.5, ATT, "YELLOW", true)
		--]]--
    end
    
    hunt.OnComplete = function (self)
        ----[[
		MapRemoveClassMarker("all_hero_luke_storm")
        MapRemoveClassMarker("all_hero_hansolo_storm")
        MapRemoveClassMarker("all_hero_chewbacca")
        MapRemoveClassMarker("all_hero_leia")
        MapRemoveClassMarker("rep_hero_obiwan")
        MapRemoveClassMarker("all_inf_lukeskywalker")
        MapRemoveClassMarker("imp_hero_darthvader")
		--]]--
    end

    hunt_timer = CreateTimer("hunt_timer")
    SetTimerValue(hunt_timer, 300)
    StartTimer(hunt_timer)
    victory = OnTimerElapse(
    	function(timer)
			MapRemoveClassMarker("all_hero_luke_storm")
			MapRemoveClassMarker("all_hero_hansolo_storm")
			MapRemoveClassMarker("all_hero_chewbacca")
			MapRemoveClassMarker("all_hero_leia")
			MapRemoveClassMarker("rep_hero_obiwan")
			MapRemoveClassMarker("all_inf_lukeskywalker")
			MapRemoveClassMarker("imp_hero_darthvader")
    		MissionVictory(ATT)
    		ReleaseTimerElapse(victory)
    	end,
    	hunt_timer
    	)
    ShowTimer(hunt_timer)
   

	hunt:Start()

    AddDeathRegion("DeathRegion01")
    AddDeathRegion("DeathRegion02")
    AddDeathRegion("DeathRegion03")
    AddDeathRegion("DeathRegion04")
    AddDeathRegion("DeathRegion05")
    
    end

function CompactorConnectionOn()
    UnblockPlanningGraphArcs ("compactor")
end
--START BRIDGEWORK!

-- OPEN
function PlayAnimExtend()
      PauseAnimation("bridgeclose");    
      RewindAnimation("bridgeopen");
      PlayAnimation("bridgeopen");
        
    -- allow the AI to run across it
    UnblockPlanningGraphArcs("Connection122");
    DisableBarriers("BridgeBarrier");
    
end
-- CLOSE
function PlayAnimRetract()
      PauseAnimation("bridgeopen");
      RewindAnimation("bridgeclose");
      PlayAnimation("bridgeclose");
            
    -- prevent the AI from running across it
    BlockPlanningGraphArcs("Connection122");
    EnableBarriers("BridgeBarrier");
      
end

--START BRIDGEWORK TAK!!!

-- OPEN
function PlayAnimTakExtend()
      PauseAnimation("TakBridgeOpen");  
      RewindAnimation("TakBridgeClose");
      PlayAnimation("TakBridgeClose");
        
    -- allow the AI to run across it
    UnblockPlanningGraphArcs("Connection128");
    DisableBarriers("Barrier222");
    
end
-- CLOSE
function PlayAnimTakRetract()
      PauseAnimation("TakBridgeClose");
      RewindAnimation("TakBridgeOpen");
      PlayAnimation("TakBridgeOpen");
            
    -- prevent the AI from running across it
    BlockPlanningGraphArcs("Connection128");
    EnableBarriers("Barrier222");
      
end

function TrashStuff()

    trash_open = 1
    trash_closed = 0
    
    trash_timer = CreateTimer("trash_timer")
    SetTimerValue(trash_timer, 7)
    StartTimer(trash_timer)
    trash_death = OnTimerElapse(
        function(timer)
            if trash_open == 1 then
                AddDeathRegion("deathregion")
                SetTimerValue(trash_timer, 5)
                StartTimer(trash_timer)
                trash_closed = 1
                trash_open = 0
                print("death region added")
            
            elseif trash_closed == 1 then
                RemoveRegion("deathregion")
                SetTimerValue(trash_timer, 15)
                StartTimer(trash_timer)
                print("death region removed")
                trash_closed = 0
                trash_open = 1
            end
        end,
        trash_timer
        )
end




function ScriptInit()
    -- Designers, these two lines *MUST* be first.
    SetPS2ModelMemory(4000000)
    ReadDataFile("ingame.lvl")

--    SetUberMode(1);
    
    --  Empire Attacking (attacker is always #1)
    local ALL = 1
    local IMP = 2
    --  These variables do not change
    local ATT = 1
    local DEF = 2
    
    --ReadDataFile("dc:sound\\bf2.lvl;dea1eli")

	SetMemoryPoolSize ("ClothData",14)
    SetMemoryPoolSize ("Combo",15)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",300)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",300) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",300)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",200)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",2000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",44)     -- should be ~1x #combo  
    
    SetMaxFlyHeight(72)
    SetMaxPlayerFlyHeight (72)
    AISnipeSuitabilityDist(30)

	ReadDataFile("sound\\dea.lvl;dea1gcw")
	
    ReadDataFile("SIDE\\all.lvl",
                    "all_inf_rifleman",
                    "all_hero_chewbacca",
                    "all_hero_leia")
	ReadDataFile("SIDE\\all_256.lvl",
				"all_hero_hansolo_storm",
			   -- "all_hero_hansolo_tat",
				"all_hero_luke_storm",
				"rep_hero_obiwan")
					
    ReadDataFile("SIDE\\imp.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_engineer",
                    "imp_inf_sniper",
                    "imp_inf_officer",
                    "imp_inf_dark_trooper",
                    "imp_hero_darthvader")

    SetupTeams{

        hero={
            team = ALL,
            units = 5,
            reinforcements = 35,
            soldier = {"all_hero_luke_storm",1, 2},
            assault = {"all_hero_hansolo_storm",1, 2},
            engineer = {"all_hero_chewbacca",1, 2},
            sniper  = {"all_hero_leia",1, 2},
            officer = {"rep_hero_obiwan",1, 2},
            
        },
        
        imp={
            team = IMP,
            units = 24,
            reinforcements = -1,
            soldier = {"imp_inf_rifleman",7, 25},
            assault = {"imp_inf_rocketeer",1, 4},
            engineer = {"imp_inf_engineer",1, 4},
            sniper  = {"imp_inf_sniper",1, 4},
            officer = {"imp_inf_officer",1, 4},
            special = {"imp_inf_dark_trooper",1, 4},

        }
    }

    --SetHeroClass(ALL, "all_inf_lukeskywalker")
    SetHeroClass(IMP, "imp_hero_darthvader")

    --  Local Stats
    SetTeamName(3, "imp")
    AddUnitClass(3, "imp_inf_rifleman")
    SetUnitCount(3, 12)
    SetTeamAsEnemy(3, ATT)
    SetTeamAsEnemy(ATT, 3)
    SetTeamAsFriend(3, DEF)
    SetTeamAsFriend(DEF, 3)

 --  Level Stats
    ClearWalkers()
    --    AddWalkerType(0, 0) -- 8 droidekas (special case: 0 leg pairs)
    --    AddWalkerType(1, 0) -- 8 droidekas (special case: 0 leg pairs)
    --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
    --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
    local weaponCnt = 180
    SetMemoryPoolSize ("Aimer", 0)
    SetMemoryPoolSize ("AmmoCounter", weaponCnt)
    SetMemoryPoolSize ("BaseHint", 300)
    SetMemoryPoolSize ("EnergyBar", weaponCnt)
    SetMemoryPoolSize ("EntityCloth", 18)
    SetMemoryPoolSize ("EntityLight", 100)
    SetMemoryPoolSize ("EntitySoundStatic", 30)
    SetMemoryPoolSize ("SoundSpaceRegion", 50)    
    SetMemoryPoolSize ("MountedTurret", 0)
    SetMemoryPoolSize ("Navigator", 50)
    SetMemoryPoolSize ("Obstacle", 260)
    SetMemoryPoolSize ("PathFollower", 50)
    SetMemoryPoolSize ("PathNode", 512)
    SetMemoryPoolSize ("RedOmniLight", 130)
    SetMemoryPoolSize ("ShieldEffect", 0)
    SetMemoryPoolSize ("TreeGridStack", 200)
    SetMemoryPoolSize ("UnitAgent", 50)
    SetMemoryPoolSize ("UnitController", 50)
    SetMemoryPoolSize ("Weapon", weaponCnt)
    SetMemoryPoolSize ("EntityFlyer", 6)

    --  Local Stats
    --SetTeamName (3, "locals")
    --AddUnitClass (3, "ewk_inf_trooper", 4)
    --AddUnitClass (3, "ewk_inf_repair", 6)
    --SetUnitCount (3, 14)
    --SetTeamAsFriend(3,ATT)
    --SetTeamAsEnemy(3,DEF)


    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("dea\\dea1.lvl", "dea1_Conquest")
    --ReadDataFile("dc:bf2\\dea.lvl", "dea_mf")
    SetDenseEnvironment("true")
    
    --SetStayInTurrets(1)


    --  Movies
    --  SetVictoryMovie(ALL, "all_end_victory")
    --  SetDefeatMovie(ALL, "imp_end_victory")
    --  SetVictoryMovie(IMP, "imp_end_victory")
    --  SetDefeatMovie(IMP, "all_end_victory")

    --  Sound
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\dea.lvl",  "dea1")
    OpenAudioStream("sound\\dea.lvl",  "dea1")
    -- OpenAudioStream("sound\\cor.lvl",  "dea1gcw_emt")

    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(1, "allleaving")
    SetOutOfBoundsVoiceOver(2, "impleaving")

    SetAmbientMusic(ALL, 1.0, "all_dea_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_dea_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2,"all_dea_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_dea_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_dea_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2,"imp_dea_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_dea_amb_victory")
    SetDefeatMusic (ALL, "all_dea_amb_defeat")
    SetVictoryMusic(IMP, "imp_dea_amb_victory")
    SetDefeatMusic (IMP, "imp_dea_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --  SetSoundEffect("BirdScatter",         "birdsFlySeq1")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")

   
    SetAttackingTeam(ATT)



    AddCameraShot(-0.404895, 0.000992, -0.514360, -0.002240, -121.539894, 62.536297, -257.699493)
    --Homestead
    AddCameraShot(0.040922, -0.004049, -0.994299, -0.098381, -103.729523, 55.546598, -225.360893)
    --Sarlac Pit
    AddCameraShot(-1.0, 0.0, -0.514360, 0.0, -55.381485, 50.450953, -96.514324)
end

