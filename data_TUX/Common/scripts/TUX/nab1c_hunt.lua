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
	SetClassProperty("gun_inf_soldier", "WeaponName1", "cis_weap_inf_fusioncutter")
	SetClassProperty("gun_inf_defender", "WeaponName1", "cis_weap_inf_fusioncutter")
	SetClassProperty("gun_inf_rider", "WeaponName1", "cis_weap_inf_fusioncutter")
	SetClassProperty("gun_inf_rider", "WeaponName1", "cis_weap_inf_fusioncutter")
	SetClassProperty("cis_inf_marine", "WeaponName2", "cis_weap_inf_fusioncutter")
	SetClassProperty("rep_inf_ep3_sniper_felucia", "PointsToUnlock", "12")
	
    hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2, pointsPerKillATT = 1, pointsPerKillDEF = 2, textATT = "game.modes.hunt", textDEF = "game.modes.hunt2", multiplayerRules = true}
    
    hunt.OnStart = function(self)
    	AddAIGoal(ATT, "Deathmatch", 1000)
    	AddAIGoal(DEF, "Deathmatch", 1000)
    end
   

	hunt:Start()
    
    
 end
 
function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(600*1024)
    SetPS2ModelMemory(4100000)
    ReadDataFile("ingame.lvl")

    

--  Alliance Attacking (attacker is always #1)
    CIS = ATT
    REP = DEF
 
    SetMapNorthAngle(0)
    SetMaxFlyHeight(55)
    SetMaxPlayerFlyHeight (55)
    AISnipeSuitabilityDist(30)
    
    
    
    ReadDataFile("sound\\nab.lvl;nab2cw")
	ReadDataFile("SIDE\\cis.lvl",
			"cis_inf_engineer",
			"cis_inf_marine",
			--"cis_hover_aat",
			"cis_inf_sniper")
			
    ReadDataFile("SIDE\\rep.lvl",
                "rep_inf_ep3_sniper_felucia")           

    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser")          
                
    ReadDataFile("SIDE\\gun.lvl", 
                "gun_inf_soldier",
				--"gun_walk_kaadu",
				"gun_inf_rider",
				"gun_inf_defender")    
    
    SetupTeams{
             
        rep = {
            team = REP,
            units = 28,
            reinforcements = 150,
            soldier  = { "gun_inf_soldier",9, 10},
			engineer = { "gun_inf_defender",1, 8},
            sniper   = { "gun_inf_rider",1, 7},
            assault  = { "rep_inf_ep3_sniper_felucia",1, 2},
            
        },
        cis = {
            team = CIS,
            units = 22,
            reinforcements = 150,
            soldier = { "cis_inf_marine",1, 15},
            sniper   = { "cis_inf_sniper",1, 5},
			--engineer = { "cis_inf_engineer",1, 8},
        }
     }

   

    --  Level Stats
        ClearWalkers()
        --AddWalkerType(0, 3) -- 3 droidekas (special case: 0 leg pairs)
        --   AddWalkerType(1, 3) 
        --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
        local weaponCnt = 200
        SetMemoryPoolSize ("Aimer", 60)
        SetMemoryPoolSize ("AmmoCounter", weaponCnt)
        SetMemoryPoolSize ("BaseHint", 245)
        SetMemoryPoolSize ("EnergyBar", weaponCnt)
        SetMemoryPoolSize ("EntityCloth", 17)
        SetMemoryPoolSize ("EntityHover",5)
        SetMemoryPoolSize ("EntitySoundStatic", 9)
        SetMemoryPoolSize ("MountedTurret", 5)
        SetMemoryPoolSize ("Navigator", 45)
        SetMemoryPoolSize ("Obstacle", 390)
        SetMemoryPoolSize ("PathFollower", 45)
        SetMemoryPoolSize ("PathNode", 128)
        SetMemoryPoolSize ("SoundSpaceRegion", 34)
        SetMemoryPoolSize ("TentacleSimulator", 0)
        SetMemoryPoolSize ("TreeGridStack", 180)
        SetMemoryPoolSize ("UnitAgent", 45)
        SetMemoryPoolSize ("UnitController", 45)
        SetMemoryPoolSize ("Weapon", weaponCnt)
		SetMemoryPoolSize("EntityFlyer", 4)   

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("nab\\na1.lvl","na1_eli")

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\nab.lvl",  "nab2")
    OpenAudioStream("sound\\nab.lvl",  "nab2")
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

    SetAmbientMusic(REP, 1.0, "rep_nab_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_nab_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_nab_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_nab_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_nab_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2,"cis_nab_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_nab_amb_victory")
    SetDefeatMusic (REP, "rep_nab_amb_defeat")
    SetVictoryMusic(CIS, "cis_nab_amb_victory")
    SetDefeatMusic (CIS, "cis_nab_amb_defeat")

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
	--Nab1 Plains
	--Hill
	AddCameraShot(0.983066, -0.039190, 0.178868, 0.007131, 44.779041, -92.555016, 223.609207);
	--Pillars
	AddCameraShot(0.558071, -0.004864, -0.829747, -0.007232, -99.522423, -104.189438, 102.993027);
	--Center
	AddCameraShot(-0.180345, 0.002299, -0.983521, -0.012535, 38.772453, -105.314598, 24.777697);

end


