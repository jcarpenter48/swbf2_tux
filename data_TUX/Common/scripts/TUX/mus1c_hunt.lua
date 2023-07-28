--

-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveTDM")
    --  Empire Attacking (attacker is always #1)
ALL = 2
IMP = 1
    --  These variables do not change
ATT = 1
DEF = 2
function ScriptPostLoad()
    
	hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2, pointsPerKillATT = 1, pointsPerKillDEF = 1,
						 textATT = "game.modes.hunt", textDEF = "game.modes.hunt2", multiplayerRules = true}
    
    hunt.OnStart = function(self)
    	AddAIGoal(ATT, "Deathmatch", 1000)
    	AddAIGoal(DEF, "Deathmatch", 1000)

    end
    

	hunt:Start()
          PlayAnimRise()
    DisableBarriers("BALCONEY")
    DisableBarriers("bALCONEY2")
    DisableBarriers("hallway_f")
    DisableBarriers("hackdoor")
    DisableBarriers("outside")
    
    OnObjectRespawnName(PlayAnimRise, "DingDong");
    OnObjectKillName(PlayAnimDrop, "DingDong");
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
 

     
 
 --START BRIDGEWORK!

-- OPEN
function PlayAnimDrop()
      PauseAnimation("lava_bridge_raise");    
      RewindAnimation("lava_bridge_drop");
      PlayAnimation("lava_bridge_drop");
        
    -- prevent the AI from running across it
    BlockPlanningGraphArcs("Connection82");
    BlockPlanningGraphArcs("Connection83");
    EnableBarriers("Bridge");
    
end
-- CLOSE
function PlayAnimRise()
      PauseAnimation("lava_bridge_drop");
      RewindAnimation("lava_bridge_raise");
      PlayAnimation("lava_bridge_raise");
            

        -- allow the AI to run across it
    UnblockPlanningGraphArcs("Connection82");
    UnblockPlanningGraphArcs("Connection83");
    DisableBarriers("Bridge");
      

 end

function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap( 2048 * 1024) 
     -- Designers, these two lines *MUST* be first!
    if (ScriptCB_GetPlatform() == "PSP") then 
        SetPSPModelMemory(6000000)
        SetPSPClipper(1)
    end         
    SetPS2ModelMemory(3600000)

    ReadDataFile("ingame.lvl")

        AddMissionObjective(IMP, "red", "game.modes.tdm")
    --  AddMissionObjective(IMP, "orange", "level.tat2.objectives.2")
    AddMissionObjective(ALL, "green", "lgame.modes.tdm")
    --  AddMissionObjective(ALL, "orange", "level.tat2.objectives.3")

    AISnipeSuitabilityDist(40)
    ReadDataFile("sound\\mus.lvl;mus1cw")

	--ReadDataFile("sound\\mus.lvl;mus1cross")

    ReadDataFile("SIDE\\mus.lvl",
                             "mus_inf_soldier",
							 "mus_inf_officer",
							 "mus_inf_engineer")
                             ----"rep_bldg_defensegridturret")
    ReadDataFile("SIDE\\rep.lvl",     
                             "rep_inf_ep3_sniper",
                             "rep_inf_ep3_rifleman")

    --  Local Stats
	SetTeamName (3, "locals")
    SetTeamName (1, "CIS")
    AddUnitClass (1, "mus_inf_engineer", 2, 12)
    AddUnitClass (1, "mus_inf_officer", 2, 12)
    SetUnitCount (1, 32)
    SetTeamAsEnemy(ATT, DEF)
    SetReinforcementCount(1, -1)

    --  Local Stats
    SetTeamName (2, "Republic")
    AddUnitClass (2, "rep_inf_ep3_sniper", 15)
    AddUnitClass (2, "rep_inf_ep3_rifleman", 12)	
    SetUnitCount (2, 36)
    SetTeamAsEnemy(DEF, ATT)
    SetReinforcementCount(2, -1)
 

    --  Level Stats
    ClearWalkers()
    AddWalkerType(0, 4)
    local weaponCnt = 220
    SetMemoryPoolSize("Aimer", 15)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 200)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth", 20)
    SetMemoryPoolSize("EntitySoundStream", 2)
    SetMemoryPoolSize("EntitySoundStatic", 133)
    SetMemoryPoolSize("FlagItem", 2)
    SetMemoryPoolSize("EntityFlyer", 4)
    SetMemoryPoolSize("MountedTurret", 3)
    SetMemoryPoolSize("Obstacle", 309)
    SetMemoryPoolSize("TreeGridStack", 200)
    SetMemoryPoolSize("Weapon", weaponCnt)
    
    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("mus\\mus1.lvl", "mus1_conquest")

    SetDenseEnvironment("false")
    --AddDeathRegion("Sarlac01")
        SetMaxFlyHeight(90)
SetMaxPlayerFlyHeight(90)

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    OpenAudioStream("sound\\mus.lvl",  "mus1")
    OpenAudioStream("sound\\mus.lvl",  "mus1")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    -- OpenAudioStream("sound\\mus.lvl",  "mus1_emt")

    SetBleedingVoiceOver(ALL, ALL, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, ALL, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(ALL, ALL, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "rep_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "cis_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "cis_off_victory_im", .1, 1)  

    SetOutOfBoundsVoiceOver(1, "Repleaving")
    SetOutOfBoundsVoiceOver(2, "Cisleaving")

    SetAmbientMusic(ALL, 1.0, "rep_mus_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "rep_mus_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2,"rep_mus_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "cis_mus_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "cis_mus_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2,"cis_mus_amb_end",    2,1)

    SetVictoryMusic(ALL, "rep_mus_amb_victory")
    SetDefeatMusic (ALL, "rep_mus_amb_defeat")
    SetVictoryMusic(IMP, "cis_mus_amb_victory")
    SetDefeatMusic (IMP, "cis_mus_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")

	AddCameraShot(0.446393, -0.064402, -0.883371, -0.127445, -93.406929, 72.953865, -35.479401);
	
	AddCameraShot(-0.297655, 0.057972, -0.935337, -0.182169, -2.384067, 71.165306, 18.453350);
	
	AddCameraShot(0.972488, -0.098362, 0.210097, 0.021250, -42.577881, 69.453072, 4.454691);
	
	AddCameraShot(0.951592, -0.190766, -0.236300, -0.047371, -44.607018, 77.906273, 113.228661);
	
	AddCameraShot(0.841151, -0.105984, 0.526154, 0.066295, 109.567764, 77.906273, 7.873035);
	
	AddCameraShot(0.818472, -0.025863, 0.573678, 0.018127, 125.781593, 61.423031, 9.809184);
	
	AddCameraShot(-0.104764, 0.000163, -0.994496, -0.001550, -13.319855, 70.673264, 63.436607);
	
	AddCameraShot(0.971739, 0.102058, 0.211692, -0.022233, -5.680069, 68.543945, 57.904160);
	
	AddCameraShot(0.178437, 0.004624, -0.983610, 0.025488, -66.947433, 68.543945, 6.745875);

    AddCameraShot(-0.400665, 0.076364, -0896894, -0.170941, 96.201210, 79.913033, -58.604382)
end
    

