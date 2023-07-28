-- SPACE 3 Battle over Kashyyyk
--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveSpaceAssault")
ScriptCB_DoFile("LinkedShields")
ScriptCB_DoFile("LinkedDestroyables")
ScriptCB_DoFile("LinkedTurrets")

--  Republic Attacking (attacker is always #1)
IMP = 1
CIS = 2
--  These variables do not change
ATT = 1
DEF = 2
    
function ScriptPostLoad()
    
    SetupObjectives()
    DisableSmallMapMiniMap()
    SetupShields()
    SetupDestroyables()
    SetupTurrets()
    
    AddAIGoal(IMP, "Deathmatch", 100)
    AddAIGoal(CIS, "Deathmatch", 100)
    
	SetProperty("cap_box01", "IsVisible", 0)
	SetProperty("cap_box01", "IsCollidible ", 0)

    PauseAnimation("cis01")
    -- Show lights
    
    SetProperty( "rep_eng_lightr", "IsVisible", 0)
    SetProperty( "rep_shi_lightr", "IsVisible", 0)
    SetProperty( "rep_lif_lightr", "IsVisible", 0)
    
    SetProperty( "cis_eng_lightr", "IsVisible", 0)
    SetProperty( "cis_shi_lightr", "IsVisible", 0)
    SetProperty( "cis_lif_lightr", "IsVisible", 0)
end




function SetupObjectives()
    assault = ObjectiveSpaceAssault:New{
        teamATT = IMP, teamDEF = CIS, 
        multiplayerRules = true
    }
    
    local repTargets = {
        engines     = {"Engine1", "Engine2"},
        lifesupport = "life_ext_cis",
        bridge      = "bridge_cis",
        comm        = "comms_cis",
        sensors     = "sensors_cis",
        frigates    = "CIS_mini01",
        internalSys = { "life_int_cis", "engine_cis" },
    }
    
    local cisTargets = {
        engines     = "Engine3",
        lifesupport = "life_ext_rep",
        bridge      = "bridge_rep",
        comm        = "comms_rep",
        sensors     = "sensors_rep",
        frigates    = "REP_mini03",
        internalSys = { "life_int_rep", "engine_rep" },
    }
    
    assault:SetupAllCriticalSystems( "imp", repTargets, true )
    assault:SetupAllCriticalSystems( "cis", cisTargets, false )
    
    assault:Start()
    


    -- cis side is open
    --BlockPlanningGraphArcs("cis_blk01","cis_blk02")
    DisableBarriers("cis_blk01")
    DisableBarriers("cis_blk02")
    
    -- rep side is open
    --BlockPlanningGraphArcs("rep_blk01","rep_blk02")
    DisableBarriers("rep_blk01")
    DisableBarriers("rep_blk02")

	--rep LAAT open
	DisableBarriers("laatbar")
end




function SetupShields()
    -- CIS Shielded objects    
    linkedShieldObjectsCIS = { "Engine1", "Engine2", "life_ext_cis", "sensors_cis", "comms_cis", "bridge_cis", "cis_fly_fedcruiser0", 
                                "cis_fly_fedcruiser2", "cis_fly_fedcruiser3", "cis_fly_fedcruiser4"}
    shieldStuffCIS = LinkedShields:New{objs = linkedShieldObjectsCIS, maxShield = 200000, addShield = 1000, controllerObject = "shieldgenCIS"}
    shieldStuffCIS:Init()
    
    function shieldStuffCIS:OnAllShieldsDown() 
        ShowMessageText("level.spa.hangar.shields.atk.down", IMP)
        ShowMessageText("level.spa.hangar.shields.def.down", CIS)
		
		BroadcastVoiceOver( "ROSMP_obj_16", IMP )
		BroadcastVoiceOver( "COSMP_obj_17", CIS )
        EnableLockOn({"Engine1", "Engine2", "life_ext_cis", "bridge_cis", "comms_cis", "sensors_cis"}, true)
    end
    
    function shieldStuffCIS:OnAllShieldsUp()
        EnableLockOn({"Engine1", "Engine2", "life_ext_cis", "bridge_cis", "comms_cis", "sensors_cis"}, false)
        ShowMessageText("level.spa.hangar.shields.atk.up", IMP)
        ShowMessageText("level.spa.hangar.shields.def.up", CIS)
		
		BroadcastVoiceOver( "ROSMP_obj_18", IMP )
		BroadcastVoiceOver( "COSMP_obj_19", CIS )          
    end
    
    -- IMP Shielded objects    
    linkedShieldObjectsREP = { "sensors_rep", "life_ext_rep", "comms_rep", "rep_cap_assultship0", "rep_cap_assultship2", "rep_cap_assultship3",
    							"rep_cap_assultship4", "bridge_rep", "Engine3" }
    shieldStuffREP = LinkedShields:New{objs = linkedShieldObjectsREP, maxShield = 200000, addShield = 1000, controllerObject = "shieldgenREP"}    
    shieldStuffREP:Init()
    
    function shieldStuffREP:OnAllShieldsDown() 
        ShowMessageText("level.spa.hangar.shields.atk.down", CIS)
        ShowMessageText("level.spa.hangar.shields.def.down", IMP)
		
		BroadcastVoiceOver( "ROSMP_obj_17", IMP )
		BroadcastVoiceOver( "COSMP_obj_16", CIS )
        EnableLockOn({"sensors_rep", "life_ext_rep", "comms_rep", "bridge_rep", "Engine3"}, true)
    end 
    
    function shieldStuffREP:OnAllShieldsUp()
        EnableLockOn({"sensors_rep", "life_ext_rep", "comms_rep", "bridge_rep", "Engine3"}, false)
        ShowMessageText("level.spa.hangar.shields.atk.up", CIS)
        ShowMessageText("level.spa.hangar.shields.def.up", IMP)
		
		BroadcastVoiceOver( "ROSMP_obj_19", IMP )
		BroadcastVoiceOver( "COSMP_obj_18", CIS )
    end
end


function SetupDestroyables()
    --CIS destroyables
    lifeSupportLinkageCIS = LinkedDestroyables:New{ objectSets = {{"life_int_cis"}, {"life_ext_cis"}} }
    lifeSupportLinkageCIS:Init()
        
    engineLinkageCIS = LinkedDestroyables:New{ objectSets = {{"Engine1", "Engine2"}, {"engine_cis"}} }
    engineLinkageCIS:Init()
    
    --IMP destroyables
    lifeSupportLinkageREP = LinkedDestroyables:New{ objectSets = {{"life_int_rep"}, {"life_ext_rep"}} }
    lifeSupportLinkageREP:Init()    
    
    engineLinkageREP = LinkedDestroyables:New{ objectSets = {{"Engine3"}, {"engine_rep"}} }
    engineLinkageREP:Init()
    
end


function SetupTurrets() 
    --CIS turrets
    LinkedTurretsCIS = LinkedTurrets:New{ team = CIS, mainframe = "cis_main", 
                                          turrets = {"cis_obj01","cis_obj02", "cis_obj03", "cis_obj04", "cis_obj05"} }
    LinkedTurretsCIS:Init()
    function LinkedTurretsCIS:OnDisableMainframe()
        ShowMessageText("level.spa.hangar.mainframe.atk.down", IMP)
        ShowMessageText("level.spa.hangar.mainframe.def.down", CIS)
        
        BroadcastVoiceOver( "ROSMP_obj_20", IMP )
        BroadcastVoiceOver( "COSMP_obj_21", CIS )

    end
    function LinkedTurretsCIS:OnEnableMainframe()
        ShowMessageText("level.spa.hangar.mainframe.atk.up", IMP)
        ShowMessageText("level.spa.hangar.mainframe.def.up", CIS)
        
        BroadcastVoiceOver( "ROSMP_obj_22", IMP )
        BroadcastVoiceOver( "COSMP_obj_23", CIS )

    end
    
    --IMP turrets
    LinkedTurretsREP = LinkedTurrets:New{ team = IMP, mainframe = "rep_main",
                                          turrets = {"rep_at01","rep_at02", "rep_at03", "rep_at04", "rep_at05", "rep_at06"} }
    LinkedTurretsREP:Init()
    function LinkedTurretsREP:OnDisableMainframe()
        ShowMessageText("level.spa.hangar.mainframe.atk.down", CIS)
        ShowMessageText("level.spa.hangar.mainframe.def.down", IMP)
        
        BroadcastVoiceOver( "ROSMP_obj_21", IMP )
        BroadcastVoiceOver( "COSMP_obj_20", CIS )

    end
    function LinkedTurretsREP:OnEnableMainframe()
        ShowMessageText("level.spa.hangar.mainframe.atk.up", CIS)
        ShowMessageText("level.spa.hangar.mainframe.def.up", IMP)

        BroadcastVoiceOver( "ROSMP_obj_23", IMP )
        BroadcastVoiceOver( "COSMP_obj_22", CIS )

    end
    
end

function ScriptPreInit()
    SetWorldExtents(1900)
end

function ScriptInit()
    -- Designers, these two lines *MUST* be first!
    StealArtistHeap(300 * 1024)
    SetPS2ModelMemory(4900000)
    ReadDataFile("ingame.lvl")

     SetMinFlyHeight(-1900)
     SetMaxFlyHeight(2000)
     SetMinPlayerFlyHeight(-1900)
     SetMaxPlayerFlyHeight(2000)
     SetAIVehicleNotifyRadius(100)
    
    --ReadDataFile("sound\\spa.lvl;spa2cw")
	ReadDataFile("sound\\spa.lvl;spa4cross")
     ScriptCB_SetDopplerFactor(0.4)
     ScaleSoundParameter("tur_weapons",   "MinDistance",   3.0);
     ScaleSoundParameter("tur_weapons",   "MaxDistance",   3.0);
     ScaleSoundParameter("tur_weapons",   "MuteDistance",   3.0);
     ScaleSoundParameter("Ordnance_Large",   "MinDistance",   3.0);
     ScaleSoundParameter("Ordnance_Large",   "MaxDistance",   3.0);
     ScaleSoundParameter("Ordnance_Large",   "MuteDistance",   3.0);
     ScaleSoundParameter("explosion",   "MaxDistance",   5.0);
     ScaleSoundParameter("explosion",   "MuteDistance",  5.0);
                  
    ReadDataFile("SIDE\\rep_256.lvl",   
        --"rep_inf_ep3_pilot",
        --"rep_inf_ep3_marine",
        --"rep_fly_assault_dome",
        --"rep_fly_anakinstarfighter_sc",
        --"rep_fly_arc170fighter_sc",        
        "rep_veh_remote_terminal",
        --"rep_fly_gunship_sc",        
        "rep_fly_arc170fighter_dome")
	 ReadDataFile("SIDE\\imp_256.lvl",
		"imp_inf_marine",
		"imp_inf_pilot",
		"imp_fly_tiefighter_sc",
		"imp_fly_tiebomber_sc",
		"imp_fly_tieinterceptor",
		"rep_fly_assault_dome",
		"imp_fly_trooptrans",
		"imp_veh_remote_terminal")	
        
    ReadDataFile("SIDE\\cis_256.lvl",
        "cis_inf_pilot",
        "cis_inf_marine",
        "cis_fly_fedlander_dome",
        "cis_fly_droidfighter_sc",  
        "cis_fly_droidfighter_dome",
        "cis_fly_greviousfighter",
        "cis_fly_droidgunship",
        "cis_fly_tridroidfighter")

    ReadDataFile("SIDE\\tur.lvl",
        "tur_bldg_spa_rep_beam",
        "tur_bldg_spa_rep_chaingun",
        "tur_bldg_spa_cis_chaingun",
        "tur_bldg_spa_cis_recoilless",
        "tur_bldg_chaingun_roof")

    SetupTeams{
        imp = {
            team = IMP,
            units = 24,
            reinforcements = -1,
            pilot    = { "imp_inf_pilot",26},
            marine   = { "imp_inf_marine",6},
        },
        cis = {
            team = CIS,
            units = 24,
            reinforcements = -1,
            pilot    = { "cis_inf_pilot",26},
            marine   = { "cis_inf_marine",6},
        }
     }
     
    --  Level Stats
    ClearWalkers()
    local weaponCnt = 240
    local guyCnt = 60
    SetMemoryPoolSize ("Aimer", 186)
    SetMemoryPoolSize ("AmmoCounter", weaponCnt)
    SetMemoryPoolSize ("BaseHint", 35)
    SetMemoryPoolSize ("CommandFlyer", 2)
    SetMemoryPoolSize ("EnergyBar", weaponCnt)
    SetMemoryPoolSize ("EntityDroid", 0)
    SetMemoryPoolSize ("EntityFlyer", 32)
    SetMemoryPoolSize ("EntityLight", 120)
    SetMemoryPoolSize ("EntityRemoteTerminal", 12)
    SetMemoryPoolSize ("EntitySoundStream", 11)
    SetMemoryPoolSize ("EntitySoundStatic", 4)
    SetMemoryPoolSize ("FLEffectObject::OffsetMatrix", 165)
    SetMemoryPoolSize ("MountedTurret", 48)
    SetMemoryPoolSize ("Navigator", 32)
    SetMemoryPoolSize ("Obstacle", 120)
    SetMemoryPoolSize ("PathFollower", 32)
    SetMemoryPoolSize ("PathNode", 48)
    SetMemoryPoolSize ("TreeGridStack", 200)
    SetMemoryPoolSize ("UnitAgent", 64)
    SetMemoryPoolSize ("UnitController", 64)
    SetMemoryPoolSize ("Weapon", weaponCnt)

    -- load sky dome
    local world = "kas"
    if ScriptCB_IsMissionSetupSaved() then
        local missionSetup = ScriptCB_LoadMissionSetup()
        world = missionSetup.world or world
    end
    ReadDataFile("SPA\\spa_sky.lvl", world)

    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("spa\\spa3ror.lvl", "spa3_Obj")
    SetDenseEnvironment("false")
    AddDeathRegion("deathregionrep")
    AddDeathRegion("deathregioncis")

    SetParticleLODBias(15000)


        --  Sound   
    
		voiceSlow = OpenAudioStream("sound\\global.lvl", "spa1_objective_vo_slow")
		AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
		AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
		AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow) 
		
		voiceQuick = OpenAudioStream("sound\\global.lvl",  "cis_unit_vo_quick")
		AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)
		AudioStreamAppendSegments("sound\\global.lvl",  "global_vo_quick", voiceQuick)  
			
		  OpenAudioStream("sound\\global.lvl",  "cw_music")
		  -- OpenAudioStream("sound\\spa.lvl",  "spa1_objective_vo_slow")
		  -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
		  OpenAudioStream("sound\\spa.lvl",  "spa")
		  OpenAudioStream("sound\\spa.lvl",  "spa")
       -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
       -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
       -- OpenAudioStream("sound\\tat.lvl",  "tat1_emt")
   
       SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)
       SetBleedingVoiceOver(IMP, CIS, "imp_off_com_report_enemy_losing",   1)
       SetBleedingVoiceOver(CIS, IMP, "cis_off_com_report_enemy_losing",   1)
       SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)
       
      SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
      SetLowReinforcementsVoiceOver(CIS, IMP, "cis_off_victory_im", .1, 1)
      SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
      SetLowReinforcementsVoiceOver(IMP, CIS, "imp_off_victory_im", .1, 1)
   
      SetOutOfBoundsVoiceOver(IMP, "impleaving")
      SetOutOfBoundsVoiceOver(CIS, "cisleaving")
   
       SetAmbientMusic(CIS, 1.0, "cis_spa_amb_start",  0,1)
       SetAmbientMusic(CIS, 0.99, "cis_spa_amb_middle", 1,1)
       SetAmbientMusic(CIS, 0.1,"cis_spa_amb_end",    2,1)
       SetAmbientMusic(IMP, 1.0, "rep_spa_amb_start",  0,1)
       SetAmbientMusic(IMP, 0.99, "rep_spa_amb_middle", 1,1)
       SetAmbientMusic(IMP, 0.1,"rep_spa_amb_end",    2,1)
   
      SetVictoryMusic(CIS, "cis_spa_amb_victory")
      SetDefeatMusic (CIS, "cis_spa_amb_defeat")
      SetVictoryMusic(IMP, "cis_spa_amb_victory")
      SetDefeatMusic (IMP, "cis_spa_amb_defeat")
   
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
    --Space Combat: Battle Over Kashyyyk
	AddCameraShot(0.961253, -0.041344, -0.272296, -0.011712, 846.781738, 42.129261, 1632.990479);
	AddCameraShot(0.950207, 0.025974, 0.310420, -0.008485, 919.840332, 42.129261, 1735.540771);
	AddCameraShot(0.948213, -0.126931, -0.288596, -0.038632, -753.106201, 743.622070, 2686.222900);
	AddCameraShot(-0.325839, 0.049463, -0.933437, -0.141696, 2249.083496, 743.622070, -1105.532593);
     AddLandingRegion("CP1Control")
     AddLandingRegion("CP2Control")


    if (gPlatformStr == "PS2") then
        ScriptCB_DisableFlyerShadows()
    end     

end



    
