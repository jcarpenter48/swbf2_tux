--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveTDM")

    --  Republic Attacking (attacker is always #1)
    local REP = 1
    local CIS = 2
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
	SetProperty("cp1-1", "Team", "1")
	SetProperty("cp2-1", "Team", "2")
	SetProperty("cp3-1", "Team", "1")
	SetProperty("cp4-1", "Team", "2")
    SetProperty("cp5-1", "Team", "2")
    SetProperty("cp6-1", "Team", "1")
    SetProperty("cp1-1", "CaptureRegion", "nil")
    SetProperty("cp2-1", "CaptureRegion", "nil")
    SetProperty("cp3-1", "CaptureRegion", "nil")
    SetProperty("cp4-1", "CaptureRegion", "nil")
    SetProperty("cp5-1", "CaptureRegion", "nil")
    SetProperty("cp6-1", "CaptureRegion", "nil")
    SetProperty("cp1-1", "HUDIndexDisplay", "")
    SetProperty("cp2-1", "HUDIndexDisplay", "")
    SetProperty("cp3-1", "HUDIndexDisplay", "")
    SetProperty("cp4-1", "HUDIndexDisplay", "")
    SetProperty("cp5-1", "HUDIndexDisplay", "")
	SetProperty("cp6-1", "HUDIndexDisplay", "")
	
    SetClassProperty("rep_inf_ep3_officer", "PointsToUnlock", 0)
    SetClassProperty("rep_inf_ep3_jettrooper", "PointsToUnlock", 0)

	--fix Acklays so they're not unpleasant to play
	SetClassProperty("geo_inf_acklay", "JumpHeight", 0)
	SetClassProperty("geo_inf_acklay", "ControlSpeed", "sprint 1.00 1.25 1.00")
	SetClassProperty("geo_inf_acklay", "EnergyBar", 0)
	
    hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2, pointsPerKillATT = 3, pointsPerKillDEF = 1, textATT = "game.modes.hunt", textDEF = "game.modes.hunt2", multiplayerRules = true, hideCPs = true}
    
    hunt.OnStart = function(self)
    	AddAIGoal(ATT, "Deathmatch", 1000)
    	AddAIGoal(DEF, "Deathmatch", 1000)
    end
   
	hunt:Start()

    EnableSPHeroRules()

end

function ScriptInit()
	StealArtistHeap(132*1024)
    -- Designers, these two lines *MUST* be first.
    SetPS2ModelMemory(3200000)
    ReadDataFile("ingame.lvl")

--    SetUberMode(1);    

    SetMemoryPoolSize("Music", 39)

    ReadDataFile("sound\\fel.lvl;fel1cw")
    SetMaxFlyHeight(53)
    SetMaxPlayerFlyHeight (53)

    ReadDataFile("SIDE\\rep.lvl",
                        "rep_inf_ep3_rifleman",
                        "rep_inf_ep3_rocketeer",
                        "rep_inf_ep3_engineer",
                        "rep_inf_ep3_sniper_felucia", 
                        "rep_inf_ep3_jettrooper",
                        "rep_inf_ep3_officer")
 --                       "rep_hero_aalya")

    ReadDataFile("SIDE\\geo.lvl",
                        "geo_inf_acklay")

    SetAttackingTeam(ATT)

SetupTeams{
    rep = {
        team = REP,
        units = 24,
        reinforcements = -1,
        soldier = { "rep_inf_ep3_rifleman"},
        assault = { "rep_inf_ep3_rocketeer"},
        engineer = { "rep_inf_ep3_engineer"},
        sniper  = { "rep_inf_ep3_sniper_felucia"},
        officer = { "rep_inf_ep3_officer"},
        special = { "rep_inf_ep3_jettrooper"},
    },
    acklay = {
        team = CIS,
        units = 24,
        reinforcements = -1,
        soldier = { "geo_inf_acklay", 6, 12},
    },
}

--    SetHeroClass(REP, "rep_hero_aalya")
	SetTeamName (2, "acklay")

    --  Level Stats 
    ClearWalkers()
    local weaponCnt = 260
    SetMemoryPoolSize("Aimer", 20)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 200)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityHover", 3)
    SetMemoryPoolSize("EntityFlyer", 6)
    SetMemoryPoolSize("EntitySoundStream", 1)
    SetMemoryPoolSize("EntitySoundStatic", 0)
    SetMemoryPoolSize("EntityWalker", 5)
    SetMemoryPoolSize("MountedTurret", 6)
    SetMemoryPoolSize("Obstacle", 400)
    SetMemoryPoolSize("PathNode", 512)
    SetMemoryPoolSize("TreeGridStack", 280)
    SetMemoryPoolSize("Weapon", weaponCnt)
    
    SetSpawnDelay(10.0, 0.25)

    ReadDataFile("fel\\fel1.lvl", "fel1_conquest")
    SetDenseEnvironment("false")
    SetAIViewMultiplier(0.65)
    --AddDeathRegion("Sarlac01")

    --  Birdies
    SetNumBirdTypes(1)
    SetBirdType(0,1.0,"bird")

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\fel.lvl",  "fel1")
    OpenAudioStream("sound\\fel.lvl",  "fel1")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    -- OpenAudioStream("sound\\fel.lvl",  "fel1_emt")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

    SetOutOfBoundsVoiceOver(1, "Repleaving")
    SetOutOfBoundsVoiceOver(2, "Cisleaving")

    SetAmbientMusic(REP, 1.0, "rep_fel_amb_hunt",  0,1)
    --SetAmbientMusic(REP, 0.8, "rep_fel_amb_middle", 1,1)
    --SetAmbientMusic(REP, 0.2,"rep_fel_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_fel_amb_hunt",  0,1)
    --SetAmbientMusic(CIS, 0.8, "cis_fel_amb_middle", 1,1)
    --SetAmbientMusic(CIS, 0.2,"cis_fel_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_fel_amb_victory")
    SetDefeatMusic (REP, "rep_fel_amb_defeat")
    SetVictoryMusic(CIS, "cis_fel_amb_victory")
    SetDefeatMusic (CIS, "cis_fel_amb_defeat")

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
    AddCameraShot(0.896307, -0.171348, -0.401716, -0.076796, -116.306931, 31.039505, 20.757469)
    AddCameraShot(0.909343, -0.201967, -0.355083, -0.078865, -116.306931, 31.039505, 20.757469)
    AddCameraShot(0.543199, 0.115521, -0.813428, 0.172990, -108.378189, 13.564240, -40.644150)
    AddCameraShot(0.970610, 0.135659, 0.196866, -0.027515, -3.214346, 11.924586, -44.687294)
    AddCameraShot(0.346130, 0.046311, -0.928766, 0.124267, 87.431061, 20.881388, 13.070729)
    AddCameraShot(0.468084, 0.095611, -0.860724, 0.175812, 18.063482, 19.360580, 18.178158)

end


