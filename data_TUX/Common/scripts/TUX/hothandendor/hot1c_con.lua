--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
-- Copyright (c) 2022 bk2modder. All rights reserved.
--
--[[ -------- Modder's Note -----------------
    Pandemic's Battlefront II Mission Scripting Guide:
        https://sites.google.com/site/swbf2modtoolsdocumentation/battlefront-ii-mission-lua-guide 
]]


--[[ -------- Modder's Note -----------------
    Alternate Addon assetLocation logic.
    See YouTube Video chapter: 
        https://www.youtube.com/watch?v=LVhKMDW22AY&t=3758s 
    https://github.com/Gametoast/AltAddonSystem
]]

-- load the gametype script
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveConquest")

    --  Republic Attacking (attacker is always #1)
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
--skin stuff
if( ScriptCB_IsFileExist("nogmehoth.txt") ~= 1 ) then 
    SetClassProperty("rep_inf_ep3_rifleman", "GeometryName", "rep_inf_clonecommander")
    SetClassProperty("rep_inf_ep3_sniper", "GeometryName", "rep_inf_clonecommander")
    SetClassProperty("rep_inf_ep3_rifleman", "ClothODF", "rep_inf_clonecommander_cape")
    SetClassProperty("rep_inf_ep3_rifleman", "GeometryLowRes", "rep_inf_clonecommander_low1")
    SetClassProperty("rep_inf_ep3_sniper", "GeometryLowRes", "rep_inf_clonecommander_low1") 
    --officer appearance to Bacara
    SetClassProperty("rep_inf_ep3_officer", "GeometryName", "rep_inf_ep3heavytrooper")
    SetClassProperty("rep_inf_ep3_officer", "GeometryLowRes", "rep_inf_ep3heavytrooper_low1") 
    SetClassProperty("rep_inf_ep3_officer", "ClothODF", "rep_inf_ep3heavytrooper_cape") 
end --allow option to switch Galactic Marines off, mainly if there is a future TC that breaks this. 
--just place a file named nogmehoth.txt (doesn't have to actually contain anything, just named that) to disable Galactic Marines
    
	AddDeathRegion("fall")
	DisableBarriers("atat")
	DisableBarriers("bombbar")

    --CP SETUP for CONQUEST
--    SetProperty("shield", "MaxHealth", 222600.0)
--  	SetProperty("shield", "CurHealth", 222600.0)
    SetObjectTeam("CP3", 1)
    SetObjectTeam("CP6", 1)
    KillObject("CP7")
 
    EnableSPHeroRules()
    
    cp1 = CommandPost:New{name = "CP3"}
    cp2 = CommandPost:New{name = "CP4"}
    cp3 = CommandPost:New{name = "CP5"}
    cp4 = CommandPost:New{name = "CP6"}
--    cp5 = CommandPost:New{name = "CP7"}
    
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, textATT = "game.modes.con", textDEF = "game.modes.con2", multiplayerRules = true}
    
    conquest:AddCommandPost(cp1)
    conquest:AddCommandPost(cp2)
    conquest:AddCommandPost(cp3)
    conquest:AddCommandPost(cp4)
--    conquest:AddCommandPost(cp5)
    
    conquest:Start()
    
--    KillObject("shield");
    
 end

function ScriptInit()
	if(ScriptCB_GetPlatform() == "PS2") then
        StealArtistHeap(1024*1024)	-- steal 1MB from art heap
    end
    
    -- Designers, these two lines *MUST* be first.
    SetPS2ModelMemory(3300000) --these values haven't been tested to work for CW on PS2
    ReadDataFile("ingame.lvl")

    SetMaxFlyHeight(70)
    SetMaxPlayerFlyHeight(70)
    SetGroundFlyerMap(1);

    --ReadDataFile("sound\\geo.lvl;geo1cw") --debug purposes
        ReadDataFile("sound\\hotcw.lvl;hot1cw") 
    ReadDataFile("SIDE\\rep.lvl",
                             "rep_inf_ep3_rifleman",
                             "rep_inf_ep3_rocketeer",
                             "rep_inf_ep3_engineer",
                             "rep_inf_ep3_sniper",
                             "rep_inf_ep3_officer",
                             "rep_inf_ep3_jettrooper",
                             "rep_walk_atte",
                             "rep_walk_oneman_atst")
    ReadDataFile("SIDE\\cis.lvl",
                             "cis_inf_rifleman",
                             "cis_inf_rocketeer",
                             "cis_inf_engineer",
                             "cis_inf_sniper",
                             "cis_inf_officer",
                             --"cis_hover_stap",
                             --"cis_hero_grievous",
                             "cis_inf_droideka")    
    ReadDataFile("SIDE\\all.lvl",
                             --"all_fly_snowspeeder", --using other hotcwveh level allows you to load this if you want
                             "all_walk_tauntaun")
                             
    ReadDataFile("SIDE\\tur.lvl",
						     "tur_bldg_hoth_dishturret",
						     "tur_bldg_hoth_lasermortar")

    --CIS snowpeeder replacement
    ReadDataFile("side\\hotc.lvl",
                --"all_fly_snowspeeder", --Cutlass replacement that is reference as Snowspeeder, might be useful later
                "cis_fly_cutlass") 
    if( ScriptCB_IsFileExist("nogmehoth.txt") ~= 1 ) then   
        ReadDataFile("side\\hotc.lvl",
                    "gme")  
    end
    --custom heroes
    ReadDataFile("side\\imagundi.lvl",
                "rep_hero_imagundi")        
    ReadDataFile("side\\sorabulq.lvl",
                "cis_hero_sorabulq")  
                
    SetupTeams{

        rep={
            team = REP,
            units = 32,
            reinforcements = 150,
            soldier = {"rep_inf_ep3_rifleman",9, 25},
            assault = {"rep_inf_ep3_rocketeer",1, 4},
            engineer   = {"rep_inf_ep3_engineer",1, 4},
            sniper  = {"rep_inf_ep3_sniper",1, 4},
            officer = {"rep_inf_ep3_officer",1, 4},
            special = {"rep_inf_ep3_jettrooper",1, 4},
            
        },
        
        cis={
            team = CIS,
            units = 32,
            reinforcements = 150,
            soldier = {"cis_inf_rifleman",9, 25},
            assault = {"cis_inf_rocketeer",1, 4},
            engineer   = {"cis_inf_engineer",1, 4},
            sniper  = {"cis_inf_sniper",1, 4},
            officer = {"cis_inf_officer",1, 4},
            special = {"cis_inf_droideka",1, 4},
        }
    }


--Setting up Heros--

    SetHeroClass(REP, "rep_hero_imagundi")
    SetHeroClass(CIS, "cis_hero_sorabulq")
    
   
       --  Level Stats
    ClearWalkers()
    AddWalkerType(0, 4) -- special -> droidekas
    AddWalkerType(1, 5) -- 6 atsts with 1 leg pairs each
    AddWalkerType(2, 2) -- 2 atats with 2 leg pairs each

	local weaponCnt = 221
    SetMemoryPoolSize("Aimer", 80)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 175)
    SetMemoryPoolSize("CommandWalker", 2)
    SetMemoryPoolSize("ConnectivityGraphFollower", 56)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
	SetMemoryPoolSize("EntityCloth", 41)
    SetMemoryPoolSize("EntityFlyer", 10)
    SetMemoryPoolSize("EntityLight", 110)
    SetMemoryPoolSize("EntitySoundStatic", 16)
    SetMemoryPoolSize("EntitySoundStream", 5)
	SetMemoryPoolSize("FLEffectObject::OffsetMatrix", 54)
    SetMemoryPoolSize("MountedTurret", 30)
    SetMemoryPoolSize("Navigator", 63)
    SetMemoryPoolSize("Obstacle", 400)
  SetMemoryPoolSize("OrdnanceTowCable", 40) -- !!!! need +4 extra for wrapped/fallen cables !!!!
    SetMemoryPoolSize("PathFollower", 63)
	SetMemoryPoolSize("PathNode", 128)
	SetMemoryPoolSize("ShieldEffect", 0)
    SetMemoryPoolSize("TreeGridStack", 300)
    SetMemoryPoolSize("UnitController", 63)
    SetMemoryPoolSize("UnitAgent", 63)
    SetMemoryPoolSize("Weapon", weaponCnt)
    SetMemoryPoolSize("SoldierAnimation", 250)

    ReadDataFile("HOT\\hot1.lvl", "hoth_conquest")
    ReadDataFile("hot\\hot1cw.lvl", "hoth_cwvehicles") 
    --ReadDataFile("tan\\tan1.lvl", "tan1_obj")
    SetSpawnDelay(10.0, 0.25)
    SetDenseEnvironment("false")
    SetDefenderSnipeRange(170)
    AddDeathRegion("Death")


    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "cis_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "rep_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "cis_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "rep_unit_vo_quick", voiceQuick)   
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\hotcw.lvl", "hot1cw")
    OpenAudioStream("sound\\hotcw.lvl", "hot1cw")

    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)

    -- SetLowReinforcementsVoiceOver(CIS, REP, "cis_hot_transport_away", .75, 1)
    -- SetLowReinforcementsVoiceOver(CIS, REP, "cis_hot_transport_away", .5, 1)
    -- SetLowReinforcementsVoiceOver(CIS, REP, "cis_hot_transport_away", .25, 1)

    SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, REP, "cis_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(CIS, "cisleaving")
    SetOutOfBoundsVoiceOver(REP, "repleaving")

    SetAmbientMusic(CIS, 1.0, "cis_hot_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_hot_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2, "cis_hot_amb_end",    2,1)
    SetAmbientMusic(REP, 1.0, "rep_hot_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_hot_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2, "rep_hot_amb_end",    2,1)

    SetVictoryMusic(CIS, "cis_hot_amb_victory")
    SetDefeatMusic (CIS, "cis_hot_amb_defeat")
    SetVictoryMusic(REP, "rep_hot_amb_victory")
    SetDefeatMusic (REP, "rep_hot_amb_defeat")

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
    --Hoth
    --Hangar
    AddCameraShot(0.944210, 0.065541, 0.321983, -0.022350, -500.489838, 0.797472, -68.773849)
    --Shield Generator
    AddCameraShot(0.371197, 0.008190, -0.928292, 0.020482, -473.384155, -17.880533, 132.126801)
    --Battlefield
    AddCameraShot(0.927083, 0.020456, -0.374206, 0.008257, -333.221558, 0.676043, -14.027348)


end
