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
	SetTeamAsFriend(2, 2)
	SetTeamAsEnemy(1, 2)
	SetTeamAsEnemy(2, 1)  
	
	SetClassProperty("all_inf_wookiee", "PointsToUnlock", "8")
	SetClassProperty("all_inf_wookiee", "WeaponName2", "cis_weap_inf_mortar_launcher")
	SetClassProperty("all_inf_wookiee", "WeaponName4", "cis_weap_inf_remotedroid")
	SetClassProperty("cis_inf_engineer", "WeaponName1", "cis_weap_inf_pistol")
	SetClassProperty("cis_inf_engineer", "WeaponName5", "cis_weap_award_pistol")
	--fix wookiee rocketeer
	SetClassProperty("wok_inf_rocketeer", "WeaponName1", "cis_weap_inf_rocket_launcher")
	SetClassProperty("wok_inf_rocketeer", "WeaponName3", "cis_weap_award_rocket_launcher")
	SetClassProperty("wok_inf_rocketeer", "WeaponAmmo3", "cis_weap_award_rocket_launcher")
	
    hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2, pointsPerKillATT = 1, pointsPerKillDEF = 1, textATT = "level.kas2.hunt.ATT", textDEF = "level.kas2.hunt.DEF", multiplayerRules = true}
    
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
 
    SetMaxFlyHeight(55)
    SetMaxPlayerFlyHeight (55)
    
    
    ReadDataFile("sound\\kas.lvl;kas2cw")
    	ReadDataFile("SIDE\\wok.lvl",
                             "wok_inf_basic")
	ReadDataFile("SIDE\\all.lvl",
							"all_inf_wookiee")          
    ReadDataFile("SIDE\\cis.lvl",
                             "cis_fly_gunship_dome",
							 "cis_inf_rocketeer",
							 "cis_inf_engineer",
                             "cis_inf_officer_hunt")
                

    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser")          
                
     
    
    SetupTeams{
             
        rep = {
            team = REP,
            units = 32,
            reinforcements = -1,
            soldier  = { "wok_inf_warrior",1, 25},
			assault  = { "wok_inf_rocketeer",1, 8},
			engineer  = { "wok_inf_mechanic",1, 8},
			officer = {"all_inf_wookiee",1, 4},
            
        },
        cis = {
            team = CIS,
            units = 32,
            reinforcements = -1,
            soldier  = { "cis_inf_officer_hunt",9, 25},
			assault  = { "cis_inf_rocketeer",1, 4},
			engineer = { "cis_inf_engineer",1, 4},
        }
     }
	 SetTeamName(REP, "locals")
		SetTeamIcon(REP, "rep_icon")
	SetTeamAsEnemy(2, 1)
	SetTeamAsNeutral(1, 2)
	SetTeamAsNeutral(2, 2)
   

    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 3) -- 3 droidekas (special case: 0 leg pairs)
        --   AddWalkerType(1, 3) 
        AddWalkerType(2, 2) -- 2 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
        --local weaponCnt = 200
        --SetMemoryPoolSize ("Aimer", 60)
        --SetMemoryPoolSize ("AmmoCounter", weaponCnt)
        --SetMemoryPoolSize ("BaseHint", 245)
        --SetMemoryPoolSize ("EnergyBar", weaponCnt)
        --SetMemoryPoolSize ("EntityCloth", 17)
		SetMemoryPoolSize ("EntityWalker",2)
        SetMemoryPoolSize ("EntityHover",5)

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("kas\\ks2.lvl","ks2_eli")

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "wok_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)   
    AudioStreamAppendSegments("sound\\global.lvl", "wok_unit_vo_quick", voiceQuick) 
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\kas.lvl",  "kas")
    OpenAudioStream("sound\\kas.lvl",  "kas")
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

    SetAmbientMusic(REP, 1.0, "rep_kas_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_kas_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_kas_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_kas_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_kas_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2,"cis_kas_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_kas_amb_victory")
    SetDefeatMusic (REP, "rep_kas_amb_defeat")
    SetVictoryMusic(CIS, "cis_kas_amb_victory")
    SetDefeatMusic (CIS, "cis_kas_amb_defeat")

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
	--Kas2 Docks
	--Wide beach shot
	AddCameraShot(0.999802, -0.015964, 0.011840, 0.000189, 113.108002, 1.022731, 269.666748);
	--Dock
	AddCameraShot(0.953681, -0.012084, -0.300552, -0.003808, 19.168949, 2.542728, 119.974800);
	--Platform
	AddCameraShot(0.523602, -0.007785, 0.851833, 0.012665, 262.619171, 16.203047, -53.650951);


end


