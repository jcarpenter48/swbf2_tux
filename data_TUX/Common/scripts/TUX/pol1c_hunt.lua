--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
Conquest = ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams")  

--  Empire Attacking (attacker is always #1)
REP = 1
ALL = 2
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

    SetClassProperty("rep_inf_ep3_officer", "GeometryName", "rep_inf_ep3trooper")
    SetClassProperty("rep_inf_ep3_officer", "GeometryLowRes", "rep_inf_ep3trooper_low1")
    SetClassProperty("rep_inf_ep3_officer", "ClothODF", " ")
    
    --This defines the CPs.  These need to happen first
    cp1 = CommandPost:New{name = "CP1Con"}
    cp2 = CommandPost:New{name = "CP2Con"}
    cp3 = CommandPost:New{name = "CP3Con"}
    cp4 = CommandPost:New{name = "CP4Con"}
    cp5 = CommandPost:New{name = "CP5Con"}
    cp6 = CommandPost:New{name = "CP6Con"}
    
    --This sets up the actual objective.  This needs to happen after cp's are defined
	hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2,
						pointsPerKillATT = 1, pointsPerKillDEF = 1,
						textATT = "game.modes.hunt",
						textDEF = "game.modes.hunt2", hideCPs = true, multiplayerRules = true}	
	hunt:Start()
	
	AddAIGoal(ATT, "Deathmatch", 1000)
	AddAIGoal(DEF, "Deathmatch", 1000)
 
     --PlayAnimLock01Open();

    SetProperty("cp1", "CaptureRegion", "0")
    SetProperty("cp1", "Team", "1")    
    SetProperty("cp2", "CaptureRegion", "0")
    SetProperty("cp2", "Team", "2")	
    SetProperty("cp3", "CaptureRegion", "0")
    SetProperty("cp3", "Team", "1")
    SetProperty("cp4", "CaptureRegion", "0")
    SetProperty("cp4", "Team", "2")	
    SetProperty("cp5", "CaptureRegion", "0")
    SetProperty("cp5", "Team", "1")
    SetProperty("cp6", "CaptureRegion", "0")
    SetProperty("cp6", "Team", "2")   
	
	SetProperty("CP1Con", "CaptureRegion", "0")
    SetProperty("CP1Con", "Team", "1")    
    SetProperty("CP2Con", "CaptureRegion", "0")
    SetProperty("CP2Con", "Team", "2")	
    SetProperty("CP3Con", "CaptureRegion", "0")
    SetProperty("CP3Con", "Team", "1")
    SetProperty("CP4Con", "CaptureRegion", "0")
    SetProperty("CP4Con", "Team", "2")	
    SetProperty("CP5Con", "CaptureRegion", "0")
    SetProperty("CP5Con", "Team", "1")
    SetProperty("CP6Con", "CaptureRegion", "0")
    SetProperty("CP6Con", "Team", "2")   
    
    OnObjectRespawnName(PlayAnimLock01Open, "LockCon01");
    OnObjectKillName(PlayAnimLock01Close, "LockCon01");
 
    EnableSPHeroRules()
    
    
 end
 
 --START DOOR WORK!

-- OPEN
function PlayAnimLock01Open()
      PauseAnimation("Airlockclose");    
      RewindAnimation("Airlockopen");
      PlayAnimation("Airlockopen");
        
    -- allow the AI to run across it
    --UnblockPlanningGraphArcs("Connection122");
    --DisableBarriers("BridgeBarrier");
    
end
-- CLOSE
function PlayAnimLock01Close()
      PauseAnimation("Airlockopen");
      RewindAnimation("Airlockclose");
      PlayAnimation("Airlockclose");
            
    -- prevent the AI from running across it
    --BlockPlanningGraphArcs("Connection122");
    --EnableBarriers("BridgeBarrier");
      
end
function ScriptInit()
    -- Designers, these two lines *MUST* be first.
    StealArtistHeap( 2048 * 1024) 
    if (ScriptCB_GetPlatform() == "PSP") then 
        SetPSPModelMemory(4900000)
        SetPSPClipper(1)
    end 
    local assetLocation = "addon\\004\\"
    if (ScriptCB_GetPlatform() == "PC") then 
        assetLocation = "DC:"
    end 
    SetPS2ModelMemory(4200000)
    ReadDataFile("ingame.lvl")

    

--  Republic Attacking (attacker is always #1)
    REP = ATT
    ALL = DEF
 
    SetMapNorthAngle(0)
    SetMaxFlyHeight(55)
    SetMaxPlayerFlyHeight (55)
    AISnipeSuitabilityDist(30)
    
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",30)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",500)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",500) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",500)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",400)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",4000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",88)     -- should be ~1x #combo
    
    ReadDataFile("sound\\pol.lvl;pol1cw")
    ReadDataFile("SIDE\\rep.lvl",
                "rep_inf_ep3_rifleman",
                "rep_inf_ep3_engineer", 
                "rep_inf_ep3_officer",
                "rep_hero_yoda",
                "rep_hero_obiwan")
                
                
    ReadDataFile("SIDE\\imp.lvl",
                "imp_hero_darthvader")
                

    ReadDataFile("SIDE\\polm.lvl",
                             "polm_inf_polismassan")         
                
     
    
    SetupTeams{
             
        rep = {
            team = REP,
            units = 18,
            reinforcements = -1,
            engineer = { "rep_inf_ep3_engineer",9, 23},
            officer = {"rep_inf_ep3_officer",1, 4},
            special = { "imp_hero_darthvader",1, 2},
            
        },
        all = {
            team = ALL,
            units = 18,
            reinforcements = -1,
            soldier  = { "polm_inf_polismassan",30, 31},
            assault  = { "rep_hero_obiwan",1, 2},
            engineer = { "rep_hero_yoda",1, 2},
        }
     }

   

    --  Level Stats
        ClearWalkers()
        AddWalkerType(0, 3) -- 3 droidekas (special case: 0 leg pairs)
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

        SetMemoryPoolSize ("Asteroid", 100)

    SetSpawnDelay(10.0, 0.25)
     ReadDataFile("pol\\pol1.lvl","pol1_Conquest")
     SetDenseEnvironment("True")   
     AddDeathRegion("deathregion1")
     --SetStayInTurrets(1)

--asteroids start!
SetParticleLODBias(3000)
SetMaxCollisionDistance(1500)     
    FillAsteroidPath("pathas01", 10, "pol1_prop_asteroid_01", 20, 1.0,0.0,0.0, -1.0,0.0,0.0);
    FillAsteroidPath("pathas01", 20, "pol1_prop_asteroid_02", 40, 1.0,0.0,0.0, -1.0,0.0,0.0);
    FillAsteroidPath("pathas02", 10, "pol1_prop_asteroid_01", 10, 1.0,0.0,0.0, -1.0,0.0,0.0);
    FillAsteroidPath("pathas03", 10, "pol1_prop_asteroid_02", 20, 1.0,0.0,0.0, -1.0,0.0,0.0);
    FillAsteroidPath("pathas04", 5, "pol1_prop_asteroid_02", 2, 1.0,0.0,0.0, -1.0,0.0,0.0);      

-- asteroids end!

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\pol.lvl",  "pol1")
    OpenAudioStream("sound\\pol.lvl",  "pol1")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    -- OpenAudioStream("sound\\pol.lvl",  "pol1_emt")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, ALL, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(ALL, REP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(ALL, ALL, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, ALL, "rep_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, ALL, "cis_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, REP, "cis_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(1, "repleaving")
    SetOutOfBoundsVoiceOver(2, "repleaving")

    SetAmbientMusic(REP, 1.0, "rep_pol_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_pol_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_pol_amb_end",    2,1)
    SetAmbientMusic(ALL, 1.0, "cis_pol_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "cis_pol_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2,"cis_pol_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_pol_amb_victory")
    SetDefeatMusic (REP, "rep_pol_amb_defeat")
    SetVictoryMusic(ALL, "cis_pol_amb_victory")
    SetDefeatMusic (ALL, "cis_pol_amb_defeat")

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
    --Tat 1 - Dune Sea
    --Crawler
    AddCameraShot(0.461189, -0.077838, -0.871555, -0.147098, 85.974007, 30.694353, -66.900795);
    AddCameraShot(0.994946, -0.100380, -0.002298, -0.000232, 109.076401, 27.636383, -10.235785);
    AddCameraShot(0.760383, 0.046402, 0.646612, -0.039459, 111.261696, 27.636383, 46.468048);
    AddCameraShot(-0.254949, 0.066384, -0.933546, -0.243078, 73.647552, 32.764030, 50.283028);
    AddCameraShot(-0.331901, 0.016248, -0.942046, -0.046116, 111.003563, 28.975283, 7.051458);
    AddCameraShot(0.295452, -0.038140, -0.946740, -0.122217, 19.856682, 36.399086, -9.890361);
    AddCameraShot(0.958050, -0.115837, -0.260254, -0.031467, -35.103737, 37.551651, 109.466576);
    AddCameraShot(-0.372488, 0.036892, -0.922789, -0.091394, -77.487892, 37.551651, 40.861832);
    AddCameraShot(0.717144, -0.084845, -0.686950, -0.081273, -106.047691, 36.238495, 60.770439);
    AddCameraShot(0.452958, -0.104748, -0.862592, -0.199478, -110.553474, 40.972584, 37.320778);
    AddCameraShot(-0.009244, 0.001619, -0.984956, -0.172550, -57.010258, 30.395561, 5.638251);
    AddCameraShot(0.426958, -0.040550, -0.899315, -0.085412, -87.005966, 30.395561, 19.625088);
    AddCameraShot(0.153632, -0.041448, -0.953179, -0.257156, -111.955055, 36.058708, -23.915501);
    AddCameraShot(0.272751, -0.002055, -0.962055, -0.007247, -117.452736, 17.298250, -58.572723);
    AddCameraShot(0.537097, -0.057966, -0.836668, -0.090297, -126.746666, 30.472836, -148.353333);
    AddCameraShot(-0.442188, 0.081142, -0.878575, -0.161220, -85.660973, 29.013374, -144.102219);
    AddCameraShot(-0.065409, 0.011040, -0.983883, -0.166056, -84.789032, 29.013374, -139.568787);
    AddCameraShot(0.430906, -0.034723, -0.898815, -0.072428, -98.038002, 47.662624, -128.643265);
    AddCameraShot(-0.401462, 0.047050, -0.908449, -0.106466, 77.586563, 47.662624, -147.517365);
    AddCameraShot(-0.269503, 0.031284, -0.956071, -0.110983, 111.260330, 16.927542, -114.045715);
    AddCameraShot(-0.338119, 0.041636, -0.933134, -0.114906, 134.970169, 26.441256, -82.282082);


end


