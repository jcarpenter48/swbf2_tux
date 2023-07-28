--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
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
	
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP4"}
    cp2 = CommandPost:New{name = "CP11"}
    cp3 = CommandPost:New{name = "CP2"}
    cp4 = CommandPost:New{name = "CP1"}
    cp5 = CommandPost:New{name = "CP3"}
    
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
    
    conquest:Start()
 
    EnableSPHeroRules()
    
    
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
    
    
    
    ReadDataFile("sound\\yav.lvl;yav1cw")
    ReadDataFile("SIDE\\rep.lvl",
                "rep_inf_ep3_rifleman",
                "rep_inf_ep3_rocketeer",
                "rep_inf_ep3_engineer",
                "rep_inf_ep3_sniper", 
                "rep_inf_ep3_officer",
                "rep_inf_ep3_jettrooper",
				--"rep_hero_yoda",
				"rep_hover_barcspeeder",
                "rep_hover_fightertank")

    ReadDataFile("SIDE\\rep_256.lvl",
                "rep_hero_quigon")                
                
    ReadDataFile("SIDE\\cis.lvl",
                "cis_inf_rifleman",
                "cis_inf_rocketeer",
                "cis_inf_engineer",
                "cis_inf_sniper",
                "cis_inf_officer",
                "cis_inf_droideka",
                "cis_hero_darthmaul",
				"cis_hover_stap",
                "cis_hover_aat")
                

    ReadDataFile("SIDE\\tur.lvl", 
                "tur_bldg_laser")          
                
    ReadDataFile("SIDE\\gun.lvl", 
                --"gun_walk_kaadu",
				"gun_inf_soldier")    
    
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
    SetHeroClass(CIS, "cis_hero_darthmaul")
    SetHeroClass(REP, "rep_hero_quigon")

	
   	SetTeamName(3, "locals")
    SetTeamIcon(3, "all_icon")
    AddUnitClass(3, "gun_inf_soldier",6)
    

    SetUnitCount(3, 6)
	AddAIGoal(3, "Deathmatch", 100)
	--[[
	SetTeamAsNeutral(ATT,3)
    SetTeamAsNeutral(3,ATT)
    SetTeamAsNeutral(DEF,3)
    SetTeamAsNeutral(3,DEF)  
	]]--
	SetTeamAsFriend(DEF,3)
    SetTeamAsFriend(3,DEF)
    SetTeamAsEnemy(ATT,3)
    SetTeamAsEnemy(3,ATT)
	
    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 3) -- 3 droidekas (special case: 0 leg pairs)
        --   AddWalkerType(1, 3) 
        --    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
        --    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
        local weaponCnt = 80
        --SetMemoryPoolSize ("Aimer", 60)
        SetMemoryPoolSize ("AmmoCounter", weaponCnt)
        --SetMemoryPoolSize ("BaseHint", 245)
        SetMemoryPoolSize ("EnergyBar", weaponCnt)
        --SetMemoryPoolSize ("EntityCloth", 17)
        SetMemoryPoolSize ("EntityHover",8)
        --SetMemoryPoolSize ("EntitySoundStatic", 9)
        --SetMemoryPoolSize ("MountedTurret", 5) --this works but is kinda low
		SetMemoryPoolSize ("MountedTurret", 20)
        --SetMemoryPoolSize ("Navigator", 45)
        --SetMemoryPoolSize ("Obstacle", 390)
        --SetMemoryPoolSize ("PathFollower", 45)
        --SetMemoryPoolSize ("PathNode", 128)
        --SetMemoryPoolSize ("SoundSpaceRegion", 34)
        SetMemoryPoolSize ("TentacleSimulator", 0)
        --SetMemoryPoolSize ("TreeGridStack", 180)
        --SetMemoryPoolSize ("UnitAgent", 45)
        --SetMemoryPoolSize ("UnitController", 45)
        SetMemoryPoolSize ("Weapon", weaponCnt)
		SetMemoryPoolSize("EntityFlyer", 3)   

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("nab\\na1.lvl","na1_Conquest")

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
	AudioStreamAppendSegments("sound\\global.lvl", "gun_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\yav.lvl",  "yav1")
    OpenAudioStream("sound\\yav.lvl",  "yav1")
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

    SetOutOfBoundsVoiceOver(CIS, "cisleaving")
    SetOutOfBoundsVoiceOver(REP, "repleaving")

    SetAmbientMusic(REP, 1.0, "rep_yav_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_yav_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_yav_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_yav_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_yav_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2,"cis_yav_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_yav_amb_victory")
    SetDefeatMusic (REP, "rep_yav_amb_defeat")
    SetVictoryMusic(CIS, "cis_yav_amb_victory")
    SetDefeatMusic (CIS, "cis_yav_amb_defeat")

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


