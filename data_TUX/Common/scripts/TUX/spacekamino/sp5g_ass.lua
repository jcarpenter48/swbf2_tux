-- SPACE 5 Battle over Kamino
--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveSpaceAssault")
ScriptCB_DoFile("LinkedShields")
ScriptCB_DoFile("LinkedDestroyables")
ScriptCB_DoFile("LinkedTurrets")

--  Empire Attacking (attacker is always #1)
IMP = 1
REP = 2
--  These variables do not change
ATT = 1
DEF = 2
    
function ScriptPostLoad()
    AddLandingRegion("CAM_CP1Control") 
    AddLandingRegion("CAM_CP2Control") 
    AddDeathRegion("death1")
    AddDeathRegion("death2")
    SetupObjectives()
    DisableSmallMapMiniMap()
    DisableBarriers("repblock");
    DisableBarriers("impblock");
    SetupShields()
    SetupDestroyables()
    SetupTurrets()  
    
    AddAIGoal(REP, "Deathmatch", 100)
    AddAIGoal(IMP, "Deathmatch", 100)

    -- With fully operational and accessible interiors, who needs these?

	SetProperty( "spa_prop_doorwaysignR", "IsVisible", 0)
	SetProperty( "spa_prop_doorwaysignR", "IsCollidable ", 0)
	SetProperty( "spa_prop_doorwaysignR", "PhysicsActive", 0)
	SetProperty( "spa_prop_doorwaysignR", "Team", 0)
	SetProperty( "spa_prop_doorwaysignR1", "IsVisible", 0)
	SetProperty( "spa_prop_doorwaysignR1", "IsCollidable ", 0)
	SetProperty( "spa_prop_doorwaysignR1", "PhysicsActive", 0)
	SetProperty( "spa_prop_doorwaysignR1", "Team", 0)
    
        -- Show lights
    
--[[    SetProperty( "imp_eng_lightr", "IsVisible", 0)
    SetProperty( "imp_shi_lightr", "IsVisible", 0)
    SetProperty( "imp_lif_lightr", "IsVisible", 0)
    
    SetProperty( "rep_eng_lightr", "IsVisible", 0)
    SetProperty( "rep_shi_lightr", "IsVisible", 0)
    SetProperty( "rep_lif_lightr", "IsVisible", 0)  --]]

	-- Frigate work
	OnObjectKillName(IMPM1_turr, "IMP_mini01");
	OnObjectKillName(IMPM2_turr, "IMP_mini02");
	OnObjectKillName(REPM1_turr, "rep_m01");
	OnObjectKillName(REPM2_turr, "rep_m02");
	OnObjectKillName(REPM4_turr, "rep_m03");
	OnObjectKillName(REPM3_turr, "rep_m04");
	KillObject("mini01")
	KillObject("mini02")
	KillObject("mini03")
	KillObject("mini04")
	KillObject("mini05")
	KillObject("rep_m01")
	KillObject("rep_m02")
end

function SetupObjectives()
    assault = ObjectiveSpaceAssault:New{
        teamATT = IMP, teamDEF = REP, 
        multiplayerRules = true
    }
    
    local impTargets = {
        engines     = "Engine3",
        lifesupport = "life_ext_rep",
        bridge      = "bridge_rep",
        comm        = "critsys",
        sensors     = "sensors_rep",
        frigates    = { "rep_m03", "rep_m04" },
        internalSys = { "life_int_rep", "engines_rep" },
    }
    
    local repTargets = {
        engines     = { "engine_l", "engine_c", "engine_r" },
        lifesupport = "life_ext_imp",
        bridge      = "bridge_imp",
        comm        = "comms_imp",
        sensors     = "sensors_imp",
        frigates    = { "imp_mini01", "imp_mini02" },
        internalSys = { "life_int_imp", "engines_imp" },
    }
    
    assault:SetupAllCriticalSystems( "imp", impTargets, true )
    assault:SetupAllCriticalSystems( "rep", repTargets, false )
    
    assault:Start()
end

function SetupShields()
    -- IMP Shielded objects    
    linkedShieldObjectsIMP = { "engine_l", "engine_c", "engine_r", "life_ext_imp", "sensors_imp", "comms_imp", "bridge_imp", "imp_cap_stardestroyer1", 
                                "imp_cap_stardestroyer2", "imp_cap_stardestroyer3", "imp_cap_stardestroyer4"}
    shieldStuffIMP = LinkedShields:New{objs = linkedShieldObjectsIMP, maxShield = 200000, addShield = 1000, controllerObject = "shieldgenIMP"}
    shieldStuffIMP:Init()
    
    function shieldStuffIMP:OnAllShieldsDown() 
        ShowMessageText("level.spa.hangar.shields.atk.down", REP)
        ShowMessageText("level.spa.hangar.shields.def.down", IMP)
		
		BroadcastVoiceOver( "ROSMP_obj_16", REP )
		BroadcastVoiceOver( "IOSMP_obj_17", IMP )
        EnableLockOn({"engine_l", "engine_c", "engine_r", "life_ext_imp", "bridge_imp", "comms_imp", "sensors_imp"}, true)
    end
    
    function shieldStuffIMP:OnAllShieldsUp()
        EnableLockOn({"engine_l", "engine_c", "engine_r", "life_ext_imp", "bridge_imp", "comms_imp", "sensors_imp"}, false)
        ShowMessageText("level.spa.hangar.shields.atk.up", REP)
        ShowMessageText("level.spa.hangar.shields.def.up", IMP)
		
		BroadcastVoiceOver( "ROSMP_obj_18", REP )
		BroadcastVoiceOver( "IOSMP_obj_19", IMP )          
    end
    
    -- REP Shielded objects    
    linkedShieldObjectsREP = { "sensors_rep", "life_ext_rep", "critsys", "rep_cap_assultship0", "rep_cap_assultship2", "rep_cap_assultship3",
    							"rep_cap_assultship4", "bridge_rep", "Engine3" }
    shieldStuffREP = LinkedShields:New{objs = linkedShieldObjectsREP, maxShield = 200000, addShield = 1000, controllerObject = "shieldgenREP"}    
    shieldStuffREP:Init()
    
    function shieldStuffREP:OnAllShieldsDown() 
        ShowMessageText("level.spa.hangar.shields.atk.down", IMP)
        ShowMessageText("level.spa.hangar.shields.def.down", REP)
		
		BroadcastVoiceOver( "ROSMP_obj_17", REP )
		BroadcastVoiceOver( "IOSMP_obj_16", IMP )
        EnableLockOn({"sensors_rep", "life_ext_rep", "critsys", "bridge_rep", "Engine3"}, true)
    end 
    
    function shieldStuffREP:OnAllShieldsUp()
        EnableLockOn({"sensors_rep", "life_ext_rep", "critsys", "bridge_rep", "Engine3"}, false)
        ShowMessageText("level.spa.hangar.shields.atk.up", IMP)
        ShowMessageText("level.spa.hangar.shields.def.up", REP)
		
		BroadcastVoiceOver( "ROSMP_obj_19", REP )
		BroadcastVoiceOver( "IOSMP_obj_18", IMP )
    end
end

function SetupTurrets() 
    --IMP turrets
    turretLinkageIMP = LinkedTurrets:New{ team = IMP, mainframe = "autodefense_imp",
                                          turrets = {"mpit1","mpit3", "mpit4",
                                                     "mpit5", "mpit7", "mpit9"} }
    turretLinkageIMP:Init()
  function turretLinkageIMP:OnDisableMainframe()
        ShowMessageText("level.spa.hangar.mainframe.atk.down", REP)
        ShowMessageText("level.spa.hangar.mainframe.def.down", IMP)
		
		BroadcastVoiceOver( "IOSMP_obj_21", IMP )
		BroadcastVoiceOver( "ROSMP_obj_20", REP )

    end
    function turretLinkageIMP:OnEnableMainframe()
        ShowMessageText("level.spa.hangar.mainframe.atk.up", REP)
        ShowMessageText("level.spa.hangar.mainframe.def.up", IMP)
        
        BroadcastVoiceOver( "IOSMP_obj_23", IMP )
        BroadcastVoiceOver( "ROSMP_obj_22", REP )
    end

    --REP turrets
    LinkedTurretsREP = LinkedTurrets:New{ team = REP, mainframe = "rep_main",
                                          turrets = {"REP_TURR1","REP_TURR2", "REP_TURR3", "REP_TURR4", "REP_TURR5", "REP_TURR6", "REP_TURR7", "REP_TURR8", "REP_TURR9", "REP_TURR10"} }
    LinkedTurretsREP:Init()
    function LinkedTurretsREP:OnDisableMainframe()
        ShowMessageText("level.spa.hangar.mainframe.atk.down", IMP)
        ShowMessageText("level.spa.hangar.mainframe.def.down", REP)
        
        BroadcastVoiceOver( "ROSMP_obj_21", REP )
        BroadcastVoiceOver( "IOSMP_obj_20", IMP )

    end
    function LinkedTurretsREP:OnEnableMainframe()
        ShowMessageText("level.spa.hangar.mainframe.atk.up", IMP)
        ShowMessageText("level.spa.hangar.mainframe.def.up", REP)

        BroadcastVoiceOver( "ROSMP_obj_23", REP )
        BroadcastVoiceOver( "IOSMP_obj_22", IMP )

    end

end

function SetupDestroyables()
    --IMP destroyables
    lifeSupportLinkageIMP = LinkedDestroyables:New{ objectSets = {{"life_int_imp"}, {"life_ext_imp"}} }
    lifeSupportLinkageIMP:Init()    
    
    engineLinkageIMP = LinkedDestroyables:New{ objectSets = {{"engine_l", "engine_c", "engine_r"}, {"engines_imp"}} }
    engineLinkageIMP:Init()
    
    --REP destroyables
    lifeSupportLinkageREP = LinkedDestroyables:New{ objectSets = {{"life_int_rep"}, {"life_ext_rep"}} }
    lifeSupportLinkageREP:Init()    
    
    engineLinkageREP = LinkedDestroyables:New{ objectSets = {{"Engine3"}, {"engine_rep"}} }
    engineLinkageREP:Init()
    
end

-- Frigates Listing

function IMPM1_turr()
	KillObject("impfrigtur1");
	KillObject("impfrigtur2");
	KillObject("impfrigtur3");
	
	SetProperty( "impfrigtur1", "IsVisible", 0)
	SetProperty( "impfrigtur1", "IsCollidable ", 0)
	SetProperty( "impfrigtur1", "PhysicsActive", 0)
	SetProperty( "impfrigtur1", "Team", 0)
	
	SetProperty( "impfrigtur2", "IsVisible", 0)
	SetProperty( "impfrigtur2", "IsCollidable ", 0)
	SetProperty( "impfrigtur2", "PhysicsActive", 0)
	SetProperty( "impfrigtur2", "Team", 0)
	
	SetProperty( "impfrigtur3", "IsVisible", 0)
	SetProperty( "impfrigtur3", "IsCollidable ", 0)
	SetProperty( "impfrigtur3", "PhysicsActive", 0)
	SetProperty( "impfrigtur3", "Team", 0)

end

function IMPM2_turr()
	KillObject("impfrigtur4");
	KillObject("impfrigtur5");
	KillObject("impfrigtur6");
	
	SetProperty( "impfrigtur4", "IsVisible", 0)
	SetProperty( "impfrigtur4", "IsCollidable ", 0)
	SetProperty( "impfrigtur4", "PhysicsActive", 0)
	SetProperty( "impfrigtur4", "Team", 0)
	
	SetProperty( "impfrigtur5", "IsVisible", 0)
	SetProperty( "impfrigtur5", "IsCollidable ", 0)
	SetProperty( "impfrigtur5", "PhysicsActive", 0)
	SetProperty( "impfrigtur5", "Team", 0)
	
	SetProperty( "impfrigtur6", "IsVisible", 0)
	SetProperty( "impfrigtur6", "IsCollidable ", 0)
	SetProperty( "impfrigtur6", "PhysicsActive", 0)
	SetProperty( "impfrigtur6", "Team", 0)

end

function REPM1_turr()
	KillObject("rep_mt01");
	KillObject("rep_mt02");
	KillObject("rep_mt03");
	KillObject("rep_mt04");
	
	SetProperty( "rep_mt01", "IsVisible", 0)
	SetProperty( "rep_mt01", "IsCollidable ", 0)
	SetProperty( "rep_mt01", "PhysicsActive", 0)
	SetProperty( "rep_mt01", "Team", 0)
	SetProperty( "rep_mt02", "IsVisible", 0)
	SetProperty( "rep_mt02", "IsCollidable ", 0)
	SetProperty( "rep_mt02", "PhysicsActive", 0)
	SetProperty( "rep_mt02", "Team", 0)
	SetProperty( "rep_mt03", "IsVisible", 0)
	SetProperty( "rep_mt03", "IsCollidable ", 0)
	SetProperty( "rep_mt03", "PhysicsActive", 0)
	SetProperty( "rep_mt03", "Team", 0)
	SetProperty( "rep_mt04", "IsVisible", 0)
	SetProperty( "rep_mt04", "IsCollidable ", 0)
	SetProperty( "rep_mt04", "PhysicsActive", 0)
	SetProperty( "rep_mt04", "Team", 0)
end

function REPM2_turr()
	KillObject("rep_mt05");
	KillObject("rep_mt06");
	KillObject("rep_mt07");
	KillObject("rep_mt08");
	
	SetProperty( "rep_mt05", "IsVisible", 0)
	SetProperty( "rep_mt05", "IsCollidable ", 0)
	SetProperty( "rep_mt05", "PhysicsActive", 0)
	SetProperty( "rep_mt05", "Team", 0)
	SetProperty( "rep_mt06", "IsVisible", 0)
	SetProperty( "rep_mt06", "IsCollidable ", 0)
	SetProperty( "rep_mt06", "PhysicsActive", 0)
	SetProperty( "rep_mt06", "Team", 0)
	SetProperty( "rep_mt07", "IsVisible", 0)
	SetProperty( "rep_mt07", "IsCollidable ", 0)
	SetProperty( "rep_mt07", "PhysicsActive", 0)
	SetProperty( "rep_mt07", "Team", 0)
	SetProperty( "rep_mt08", "IsVisible", 0)
	SetProperty( "rep_mt08", "IsCollidable ", 0)
	SetProperty( "rep_mt08", "PhysicsActive", 0)
	SetProperty( "rep_mt08", "Team", 0)
end

function REPM3_turr()
	KillObject("repfrigtur1");
	KillObject("repfrigtur2");
	KillObject("repfrigtur3");
	KillObject("repfrigtur4");
	
	SetProperty( "repfrigtur1", "IsVisible", 0)
	SetProperty( "repfrigtur1", "IsCollidable ", 0)
	SetProperty( "repfrigtur1", "PhysicsActive", 0)
	SetProperty( "repfrigtur1", "Team", 0)
	SetProperty( "repfrigtur2", "IsVisible", 0)
	SetProperty( "repfrigtur2", "IsCollidable ", 0)
	SetProperty( "repfrigtur2", "PhysicsActive", 0)
	SetProperty( "repfrigtur2", "Team", 0)
	SetProperty( "repfrigtur3", "IsVisible", 0)
	SetProperty( "repfrigtur3", "IsCollidable ", 0)
	SetProperty( "repfrigtur3", "PhysicsActive", 0)
	SetProperty( "repfrigtur3", "Team", 0)
	SetProperty( "repfrigtur4", "IsVisible", 0)
	SetProperty( "repfrigtur4", "IsCollidable ", 0)
	SetProperty( "repfrigtur4", "PhysicsActive", 0)
	SetProperty( "repfrigtur4", "Team", 0)
end

function REPM4_turr()
	KillObject("repfrigtur5");
	KillObject("repfrigtur6");
	KillObject("repfrigtur7");
	KillObject("repfrigtur8");
	
	SetProperty( "repfrigtur5", "IsVisible", 0)
	SetProperty( "repfrigtur5", "IsCollidable ", 0)
	SetProperty( "repfrigtur5", "PhysicsActive", 0)
	SetProperty( "repfrigtur5", "Team", 0)
	SetProperty( "repfrigtur6", "IsVisible", 0)
	SetProperty( "repfrigtur6", "IsCollidable ", 0)
	SetProperty( "repfrigtur6", "PhysicsActive", 0)
	SetProperty( "repfrigtur6", "Team", 0)
	SetProperty( "repfrigtur7", "IsVisible", 0)
	SetProperty( "repfrigtur7", "IsCollidable ", 0)
	SetProperty( "repfrigtur7", "PhysicsActive", 0)
	SetProperty( "repfrigtur7", "Team", 0)
	SetProperty( "repfrigtur8", "IsVisible", 0)
	SetProperty( "repfrigtur8", "IsCollidable ", 0)
	SetProperty( "repfrigtur8", "PhysicsActive", 0)
	SetProperty( "repfrigtur8", "Team", 0)
end

function ScriptPreInit()
   SetWorldExtents(2060)
end

 function ScriptInit()
     -- Designers, these two lines *MUST* be first!
     StealArtistHeap(1084*1024)
     SetPS2ModelMemory(4730000)
     ReadDataFile("ingame.lvl")
     
     -- ReadDataFile("sound\\spa.lvl;spa1gcw")
     ReadDataFile("sound\\spa.lvl;spa4cross")
     ReadDataFile("sound\\spa5.lvl;spa5cross")
     ScriptCB_SetDopplerFactor(0.4)
     ScaleSoundParameter("tur_weapons",   "MinDistance",   3.0);
     ScaleSoundParameter("tur_weapons",   "MaxDistance",   3.0);
     ScaleSoundParameter("tur_weapons",   "MuteDistance",   3.0);
     ScaleSoundParameter("Ordnance_Large",   "MinDistance",   3.0);
     ScaleSoundParameter("Ordnance_Large",   "MaxDistance",   3.0);
     ScaleSoundParameter("Ordnance_Large",   "MuteDistance",   3.0);
     ScaleSoundParameter("explosion",   "MaxDistance",   5.0);
     ScaleSoundParameter("explosion",   "MuteDistance",  5.0);

     SetMinFlyHeight(-1900)
     SetMaxFlyHeight(2000)
     SetMinPlayerFlyHeight(-1900)
     SetMaxPlayerFlyHeight(2000)
     SetAIVehicleNotifyRadius(100)

    ReadDataFile("SIDE\\rep.lvl",   
        "rep_inf_ep2_pilot",
        "rep_inf_ep2_marine",
        "rep_fly_assault_dome",
        "rep_fly_anakinstarfighter_sc",
        "rep_fly_arc170fighter_sc",        
        "rep_veh_remote_terminal",
        "rep_fly_gunship_sc",        
        "rep_fly_arc170fighter_dome",
        "rep_fly_vwing")
        
     ReadDataFile("SIDE\\imp.lvl",
        "imp_inf_pilot",
        "imp_inf_marine",
        "imp_fly_tiefighter_sc",
        "imp_fly_tiebomber_sc",
        "imp_fly_tieinterceptor",
        "imp_fly_trooptrans")

     ReadDataFile("SIDE\\tur.lvl",
        "tur_bldg_spa_rep_recoilless",
        "tur_bldg_spa_rep_beam",
        "tur_bldg_spa_imp_recoilless",
        "tur_bldg_spa_imp_chaingun",
        "tur_bldg_chaingun_roof")


    --  Level Stats
    ClearWalkers()
    SetMemoryPoolSize ("Aimer", 200)
    SetMemoryPoolSize ("BaseHint",60)
    SetMemoryPoolSize ("Combo::DamageSample", 64)
    SetMemoryPoolSize ("CommandFlyer",2)
    SetMemoryPoolSize ("EntityFlyer",32)
    SetMemoryPoolSize ("EntityDroid",0)
    SetMemoryPoolSize ("EntityLight",120)
    SetMemoryPoolSize ("EntityRemoteTerminal",12)
    SetMemoryPoolSize ("EntitySoundStream", 12)
    SetMemoryPoolSize ("EntitySoundStatic", 3)
    SetMemoryPoolSize ("FLEffectObject::OffsetMatrix", 100)
    SetMemoryPoolSize ("MountedTurret",70)
    SetMemoryPoolSize ("Navigator", 32)
    SetMemoryPoolSize ("Obstacle", 100)
    SetMemoryPoolSize ("PassengerSlot", 0)
    SetMemoryPoolSize ("PathFollower", 32)
    SetMemoryPoolSize ("PathNode", 72)
    SetMemoryPoolSize ("TentacleSimulator", 0)
    SetMemoryPoolSize ("TreeGridStack", 230)
    SetMemoryPoolSize ("UnitAgent",74)
    SetMemoryPoolSize ("UnitController",74)
    SetMemoryPoolSize ("Weapon", 260)
     
    --if(gPlatformStr == "XBox") then 
    --    SetMemoryPoolSize ("Asteroid", 400)
    --elseif( gPlatformStr == "PS2") then
        SetMemoryPoolSize ("Asteroid", 50)
    --else -- PC
    --    SetMemoryPoolSize ("Asteroid", 600)
    --end

SetupTeams{

         rep = {
            team = REP,
            units = 32,
            reinforcements = -1,
            pilot    = { "rep_inf_ep2_pilot",25},
            marine   = { "rep_inf_ep2_marine",8},
        },

        imp = {
            team = IMP,
            units = 32,
            reinforcements = -1,
            pilot    = { "imp_inf_pilot",25},
            marine   = { "imp_inf_marine",8},

        }
     }

     SetSpawnDelay(10.0, 0.25)
     
     --[[ load sky dome
     local world = "yav"
     if ScriptCB_IsMissionSetupSaved() then
         local missionSetup = ScriptCB_LoadMissionSetup()
         world = missionSetup.world or world
     end
     ReadDataFile("SPA\\spa_sky.lvl", world)

     ReadDataFile("spa\\spa1.lvl", "spa1_Assault")
     SetDenseEnvironment("false")
     AddDeathRegion("deathregionimp")
     AddDeathRegion("deathregionrep")
     --SetStayInTurrets(1)

	--]]

-- Yeah, let's not do that...

    ReadDataFile("SPA\\spa5.lvl", "spa5_Assault")
	--ReadDataFile("spa\\spa3.lvl", "spa3_Obj") --this works, so spa5 seems to have a problem
    SetDenseEnvironment("false")
     
     
    SetParticleLODBias(3000)
     
    --if(gPlatformStr == "XBox") then 
         --SetMaxCollisionDistance(1500)
        --FillAsteroidRegion("asteroid_region1", "spa_prop_jagged_asteroid_medium_stop", 50, 2.0,1.0,1.0, 0.0,-1.0,-1.0);
        --FillAsteroidRegion("asteroid_region1", "spa_prop_jagged_asteroid_large_stop", 100, 3.0,1.0,1.0, 0.0,-1.0,-1.0);
        --FillAsteroidPath("asteroid_path1", 120, "spa_prop_jagged_asteroid_large", 50, 3.0,1.0,1.0, 0.0,-1.0,-1.0); 
        --FillAsteroidPath("asteroid_path1", 60, "spa_prop_jagged_asteroid_medium", 50, 1.0,1.0,1.0, 0.0,-1.0,-1.0); 
        --FillAsteroidPath("asteroid_path2", 120, "spa_prop_jagged_asteroid_large_stop", 50, 3.0,1.0,1.0, 0.0,-1.0,-1.0); 
        --FillAsteroidPath("asteroid_path2", 60, "spa_prop_jagged_asteroid_medium_stop", 100, 2.0,1.0,1.0, 0.0,-1.0,-1.0); 

    --elseif( gPlatformStr == "PS2") then
         SetMaxCollisionDistance(1000)
        FillAsteroidRegion("asteroid_region1", "spa_prop_jagged_asteroid_medium_stop", 25, 2.0,1.0,1.0, 0.0,-1.0,-1.0);
        FillAsteroidRegion("asteroid_region1", "spa_prop_jagged_asteroid_large_stop", 50, 3.0,1.0,1.0, 0.0,-1.0,-1.0);
        FillAsteroidPath("asteroid_path1", 120, "spa_prop_jagged_asteroid_large", 25, 3.0,1.0,1.0, 0.0,-1.0,-1.0); 
        FillAsteroidPath("asteroid_path1", 60, "spa_prop_jagged_asteroid_medium", 25, 1.0,1.0,1.0, 0.0,-1.0,-1.0); 
        FillAsteroidPath("asteroid_path2", 120, "spa_prop_jagged_asteroid_large_stop", 25, 3.0,1.0,1.0, 0.0,-1.0,-1.0); 
        FillAsteroidPath("asteroid_path2", 60, "spa_prop_jagged_asteroid_medium_stop", 50, 2.0,1.0,1.0, 0.0,-1.0,-1.0); 
    --else -- PC
         --SetMaxCollisionDistance(2000)
        --FillAsteroidRegion("asteroid_region1", "spa_prop_jagged_asteroid_medium_stop", 50, 2.0,1.0,1.0, 0.0,-1.0,-1.0);
        --FillAsteroidRegion("asteroid_region1", "spa_prop_jagged_asteroid_large_stop", 200, 3.0,1.0,1.0, 0.0,-1.0,-1.0);
        --FillAsteroidPath("asteroid_path1", 120, "spa_prop_jagged_asteroid_large", 50, 3.0,1.0,1.0, 0.0,-1.0,-1.0); 
        --FillAsteroidPath("asteroid_path1", 60, "spa_prop_jagged_asteroid_medium", 50, 1.0,1.0,1.0, 0.0,-1.0,-1.0); 
        --FillAsteroidPath("asteroid_path2", 120, "spa_prop_jagged_asteroid_large_stop", 50, 3.0,1.0,1.0, 0.0,-1.0,-1.0); 
        --FillAsteroidPath("asteroid_path2", 60, "spa_prop_jagged_asteroid_medium_stop", 200, 2.0,1.0,1.0, 0.0,-1.0,-1.0); 
    
    --end
     
    

     --  Sound
     
     voiceStream = OpenAudioStream("sound\\global.lvl", "spa1_objective_vo_slow")
     AudioStreamAppendSegments("sound\\global.lvl", "rep_unit_vo_slow", voiceStream)
     AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceStream)
     AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceStream)     

     -- NVM musicStream = OpenAudioStream("sound\\global.lvl",  "gcw_music")
     
     OpenAudioStream("sound\\global.lvl",  "cw_music")
     OpenAudioStream("sound\\spa.lvl",  "spa")
     OpenAudioStream("sound\\spa.lvl",  "spa")

     SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
     SetBleedingVoiceOver(REP, IMP, "rep_off_com_report_enemy_losing",   1)
     SetBleedingVoiceOver(IMP, REP, "imp_off_com_report_enemy_losing",   1)
     SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

     SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
     SetLowReinforcementsVoiceOver(REP, IMP, "rep_off_victory_im", .1, 1)
     SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
     SetLowReinforcementsVoiceOver(IMP, REP, "imp_off_victory_im", .1, 1)

     SetOutOfBoundsVoiceOver(1, "impleaving")
     SetOutOfBoundsVoiceOver(2, "repleaving")

     SetAmbientMusic(REP, 1.0, "rep_spa_amb_start",  0,1)
     SetAmbientMusic(REP, 0.9, "rep_spa_amb_middle", 1,1)
     SetAmbientMusic(REP, 0.1,"rep_spa_amb_end",    2,1)
     SetAmbientMusic(IMP, 1.0, "imp_spa_amb_start",  0,1)
     SetAmbientMusic(IMP, 0.9, "imp_spa_amb_middle", 1,1)
     SetAmbientMusic(IMP, 0.1,"imp_spa_amb_end",    2,1)

     SetVictoryMusic(REP, "rep_spa_amb_victory")
     SetDefeatMusic (REP, "rep_spa_amb_defeat")
     SetVictoryMusic(IMP, "rep_spa_amb_victory")
     SetDefeatMusic (IMP, "rep_spa_amb_defeat")

   SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
   SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
     --  SetSoundEffect("BirdScatter",         "birdsFlySeq1")
   SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
   SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
   SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
   SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
   SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")

    --Star Dest far
	AddCameraShot(0.792356, 0.005380, -0.610022, 0.004142, -1083.259766, 205.730942, 524.492249);
	--rep Cru far
	AddCameraShot(-0.362954, -0.002066, -0.931790, 0.005304, -149.122910, -97.288933, -1759.549927);
	--rep Cru Angle
	AddCameraShot(0.599707, -0.046312, 0.796507, 0.061510, 544.123230, 93.926430, -522.673523);
	--Star Dest Angle
    AddCameraShot(0.181770, -0.005491, -0.982877, -0.029689, -16.614826, 307.607605, -2127.639648);
     
 end
