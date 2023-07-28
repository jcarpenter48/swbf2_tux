--
-- SPACE 5 Battle over Kamino
--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
-- Largely decompiled with SWBF2CodeHelper
--
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveAssault")
ScriptCB_DoFile("MultiObjectiveContainer")
ScriptCB_DoFile("LinkedDestroyables")
ScriptCB_DoFile("LinkedShields")
ScriptCB_DoFile("PlayMovieWithTransition")
ScriptCB_DoFile("LinkedTurrets")
local REP = 2
local IMP = 1

function ScriptPostLoad()
    -- Transport health decreased due to feedback
    --[[SetProperty("mini01", "MaxHealth", "60000")
    SetProperty("mini02", "MaxHealth", "60000")
    SetProperty("mini03", "MaxHealth", "60000")
    SetProperty("mini04", "MaxHealth", "60000")
    SetProperty("mini05", "MaxHealth", "60000")--]]

    SetProperty("mini01", "MaxHealth", 45000)
    SetProperty("mini02", "MaxHealth", 45000)
    SetProperty("mini03", "MaxHealth", 45000)
    SetProperty("mini04", "MaxHealth", 45000)
    SetProperty("mini05", "MaxHealth", 45000)
    
    SetProperty("mini01", "CurHealth", 45000)
    SetProperty("mini02", "CurHealth", 45000)
    SetProperty("mini03", "CurHealth", 45000)
    SetProperty("mini04", "CurHealth", 45000)
    SetProperty("mini05", "CurHealth", 45000)

    -- ScriptCB_PlayInGameMovie("ingame.mvs","sb5mon01") --we are using the transition movie instead
	
    ScriptCB_SetGameRules("campaign")
    AddLandingRegion("CAM_CP1Control") 
    AddLandingRegion("CAM_CP2Control") 
    AddDeathRegion("death1")
    AddDeathRegion("death2")
    timeoutTimer = CreateTimer("timeout")
    SetTimerValue(timeoutTimer,210)
    -- StartTimer(timeoutTimer)
    -- ShowTimer(timeoutTimer)
    timerdefeat = OnTimerElapse(
    function(timer)
          BroadcastVoiceOver("SPA5_obj_09", IMP)
          -- MissionVictory(REP)
          ShowTimer(nil)
          DestroyTimer(timeoutTimer)
	  DefeatTimer()
end,timeoutTimer)

    PlayAnimationFromTo("friga",0,399)
    PlayAnimationFromTo("frigb",0,359)

	-- Unlocking Imperial Doors!
	
	-- SetProperty("impdoor01", "IsLocked", 1)
	-- SetProperty("impdoor02", "IsLocked", 1)

	SetProperty( "spa_prop_doorwaysignR", "IsVisible", 0)
	SetProperty( "spa_prop_doorwaysignR", "IsCollidable ", 0)
	SetProperty( "spa_prop_doorwaysignR", "PhysicsActive", 0)
	SetProperty( "spa_prop_doorwaysignR", "Team", 0)
	SetProperty( "spa_prop_doorwaysignR1", "IsVisible", 0)
	SetProperty( "spa_prop_doorwaysignR1", "IsCollidable ", 0)
	SetProperty( "spa_prop_doorwaysignR1", "PhysicsActive", 0)
	SetProperty( "spa_prop_doorwaysignR1", "Team", 0)

	-- Unlocking Republic Doors!

	-- SetProperty("lockedoor04", "IsLocked", 1)
	-- SetProperty("lockedoor05", "IsLocked", 1)

onfirstspawn = OnCharacterSpawn(
        function(character)
            if IsCharacterHuman(character) then
                ReleaseCharacterSpawn(onfirstspawn)
                onfirstspawn = nil
                --BeginObjectives()
		BeginObjectivesTimer()
                --ScriptCB_EnableCommandPostVO(0)
                ScriptCB_PlayInGameMusic("rep_spa5_amb_obj1_2_explore")
            end
        end)

-- Objective 1

    Objective1 = ObjectiveAssault:New({ teamATT = IMP, teamDEF = REP, text = "level.spa5.objectives.campaign.1", popupText = "level.spa5.objectives.campaign.1_popup" })

    trans01 = Target:New({ name = "mini01" })
    trans02 = Target:New({ name = "mini02" })
    trans03 = Target:New({ name = "mini03" })
    trans04 = Target:New({ name = "mini04" })
    trans05 = Target:New({ name = "mini05" })

    Objective1:AddTarget(trans01)
    Objective1:AddTarget(trans02)
    Objective1:AddTarget(trans03)
    Objective1:AddTarget(trans04)
    Objective1:AddTarget(trans05)

    Objective1.OnStart = function(self)
	StartTimer(timeoutTimer)
	ShowTimer(timeoutTimer)
        ScriptCB_EnableCommandPostVO(0)
        BroadcastVoiceOver("SPA5_obj_01", IMP)
        mini01Death = OnObjectKillName(Translist01,"mini01")
        mini02Death = OnObjectKillName(Translist02,"mini02")
        mini03Death = OnObjectKillName(Translist03,"mini03")
        mini04Death = OnObjectKillName(Translist04,"mini04")
        mini05Death = OnObjectKillName(Translist05,"mini05")
    end

    Objective1.OnComplete = function(self)
	AddReinforcements(IMP, 10)
        BroadcastVoiceOver("SPA5_obj_03", IMP)
        ReleaseObjectKill(mini01Death)
        ReleaseObjectKill(mini02Death)
        ReleaseObjectKill(mini03Death)
        ReleaseObjectKill(mini04Death)
        ReleaseObjectKill(mini05Death)
        DestroyTimer(timeoutTimer)
        ShowTimer(nil)
        ReleaseTimerElapse(timerdefeat)
	ScriptCB_PlayInGameMusic("rep_spa5_objComplete_01")

		 -- Music Timer -- 
		 music01Timer = CreateTimer("music01")
		SetTimerValue(music01Timer, 21.0)
				              
			StartTimer(music01Timer)
			OnTimerElapse(
				function(timer)
				ScriptCB_StopInGameMusic("rep_spa5_objComplete_01")
				ScriptCB_PlayInGameMusic("rep_spa5_amb_obj3_4_explore")
				DestroyTimer(timer)
			end,
			music01Timer
                        ) 

    end

    Objective1.OnSingleTargetDestroyed = function(self, target)
        local numTargets = self:GetNumSingleTargets()
        if numTargets > 0 then
            ShowMessageText("level.spa5.objectives.campaign.1-" .. numTargets, 1)
        end
    end

-- Objective 2

    Objective2 = ObjectiveAssault:New({ teamATT = IMP, teamDEF = REP, text = "level.spa5.objectives.campaign.2", popupText = "level.spa5.objectives.campaign.2_popup" })

    Frig01 = Target:New({ name = "rep_m01" })
    Frig02 = Target:New({ name = "rep_m02" })

    Objective2:AddTarget(Frig01)
    Objective2:AddTarget(Frig02)

    Objective2.OnStart = function(self) 
        BroadcastVoiceOver("SPA5_obj_02", IMP)
        FrigDeath01 = OnObjectKillName(Friglist01,"rep_m01")
        FrigDeath02 = OnObjectKillName(Friglist02,"rep_m02")
    end

    Objective2.OnComplete = function(self)
	AddReinforcements(IMP, 15)
        BroadcastVoiceOver("SPA5_obj_04", IMP)
        ReleaseObjectKill(FrigDeath01)
        ReleaseObjectKill(FrigDeath02)
    end

    Objective2.OnSingleTargetDestroyed = function(self, target)
        local numTargets = self:GetNumSingleTargets()
        if numTargets > 0 then
            ShowMessageText("level.spa5.objectives.campaign.2-" .. numTargets, 1)
        end
    end

-- Objective 3 (Old, replaced by new version based off the voice overs)
--[[
    Objective3 = ObjectiveAssault:New({ teamATT = IMP, teamDEF = REP, text = "level.spa5.objectives.campaign.3", popupText = "level.spa5.objectives.campaign.3_popup" })
    Rep_crit = Target:New({ name = "critsys" })
    Objective3:AddTarget(Rep_crit)

    Objective3.OnStart = function(self)
        BroadcastVoiceOver("SPA5_obj_05", IMP)
    end

    Objective3.OnComplete = function(self)
        BroadcastVoiceOver("SPA5_obj_08", IMP)
        ShowMessageText("level.spa5.objectives.campaign.3c",IMP)
    end
--]]

-- Objective 4

    Objective4 = ObjectiveAssault:New({ teamATT = IMP, teamDEF = REP, text = "level.spa5.objectives.campaign.4", popupText = "level.spa5.objectives.campaign.4_popup" })
    Shields = Target:New({ name = "shieldgenREP" })
    Objective4:AddTarget(Shields)

    Objective4.OnStart = function(self)
        BroadcastVoiceOver("SPA5_obj_05", IMP)
    end

    Objective4.OnComplete = function(self)
	AddReinforcements(IMP, 20)
    end

-- Objective 5

    Objective5 = ObjectiveAssault:New({ teamATT = IMP, teamDEF = REP, text = "level.spa5.objectives.campaign.5", popupText = "level.spa5.objectives.campaign.5_popup" })
    Sensors = Target:New({ name = "sensors_rep" })
    Objective5:AddTarget(Sensors)

    Objective5.OnStart = function(self)
        BroadcastVoiceOver("SPA5_obj_06", IMP)
    end

    Objective5.OnComplete = function(self)
	AddReinforcements(IMP, 15)
    end

-- Objective 6

    Objective6 = ObjectiveAssault:New({ teamATT = IMP, teamDEF = REP, text = "level.spa5.objectives.campaign.6", popupText = "level.spa5.objectives.campaign.6_popup" })
    Engines = Target:New({ name = "Engine3" })
    Objective6:AddTarget(Engines)

    Objective6.OnStart = function(self)
        BroadcastVoiceOver("SPA5_obj_07", IMP)
    end

    Objective6.OnComplete = function(self)
        BroadcastVoiceOver("SPA5_obj_08", IMP)
        ShowMessageText("level.spa5.objectives.campaign.3c",IMP)
    end

    function BeginObjectivesTimer()
    beginobjectivestimer = CreateTimer("beginobjectivestimer")
    OnTimerElapse(BeginObjectives, beginobjectivestimer)
    SetTimerValue(beginobjectivestimer, 5)
    StartTimer(beginobjectivestimer)
    end    

    function DefeatTimer()
    defeattimer = CreateTimer("defeattimer")
    OnTimerElapse(MissionVictory(REP), defeattimer)
    SetTimerValue(defeattimer, 5)
    StartTimer(defeattimer)
    end    

function BeginObjectives()
        objectiveSequence = MultiObjectiveContainer:New({ delayVictoryTime = 6 })
        objectiveSequence:AddObjectiveSet(Objective1)
        objectiveSequence:AddObjectiveSet(Objective2)
        objectiveSequence:AddObjectiveSet(Objective4)
        objectiveSequence:AddObjectiveSet(Objective5)
        objectiveSequence:AddObjectiveSet(Objective6)
        objectiveSequence:Start()
end

function Translist01()
        PauseAnimation("trans01")
        RewindAnimation("list1")
        SetAnimationStartPoint("list1")
        PlayAnimation("list1")
end

function Translist02()
        PauseAnimation("trans02")
        RewindAnimation("list2")
        SetAnimationStartPoint("list2")
        PlayAnimation("list2")
end

function Translist03()
        PauseAnimation("trans03")
        RewindAnimation("list3")
        SetAnimationStartPoint("list3")
        PlayAnimation("list3")
end

function Translist04()
        PauseAnimation("trans04")
        RewindAnimation("list4")
        SetAnimationStartPoint("list4")
        PlayAnimation("list4")
end

function Translist05()
        PauseAnimation("trans05")
        RewindAnimation("list5")
        SetAnimationStartPoint("list5")
        PlayAnimation("list5")
end

function Friglist01()
        PauseAnimation("friga")
        --[[RewindAnimation("frilist01")
        SetAnimationStartPoint("frilist01")
        PlayAnimation("frilist01")--]]

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

function Friglist02()
        PauseAnimation("frigb")
        --[[RewindAnimation("frilist02")
        SetAnimationStartPoint("frilist02")
        PlayAnimation("frilist02")--]]

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

SetupShields()
SetupTurrets()
SetupDestroyables()

end
local IMP = 1
local REP = 2

function ScriptInit()
    --ReadDataFile("dc:load\\sp5load.lvl")
    SetPS2ModelMemory(3800000)
    ReadDataFile("ingame.lvl")
    SetMinFlyHeight(-1900)
    SetMaxFlyHeight(2000)
    SetMinPlayerFlyHeight(-1900)
    SetMaxPlayerFlyHeight(2000)
    SetAIVehicleNotifyRadius(100)
    ReadDataFile("sound\\spa.lvl;spa4cross")
    ReadDataFile("sound\\spa5.lvl;spa5cross")
    ScriptCB_SetDopplerFactor(0.40000000596046)
    ScaleSoundParameter("weapons","MaxDistance",5)
    ScaleSoundParameter("weapons","MuteDistance",5)
    ScaleSoundParameter("ordnance","MinDistance",5)
    ScaleSoundParameter("ordnance","MaxDistance",5)
    ScaleSoundParameter("ordnance","MuteDistance",5)
    ScaleSoundParameter("veh_weapon","MaxDistance",10)
    ScaleSoundParameter("veh_weapon","MuteDistance",10)
    ScaleSoundParameter("explosion","MaxDistance",15)
    ScaleSoundParameter("explosion","MuteDistance",15)
    ReadDataFile("SIDE\\imp.lvl","imp_inf_pilot","imp_inf_marine","imp_fly_tiefighter_sc","imp_fly_tiebomber_sc","imp_fly_tieinterceptor","imp_fly_trooptrans","imp_veh_remote_terminal")
    ReadDataFile("SIDE\\rep.lvl","rep_inf_ep2_pilot","rep_inf_ep2_marine","rep_fly_assault_dome","rep_fly_anakinstarfighter_sc","rep_fly_arc170fighter_sc","rep_veh_remote_terminal","rep_fly_arc170fighter_dome","rep_fly_gunship_sc","rep_fly_vwing")
    ReadDataFile("SIDE\\tur.lvl",
		"tur_bldg_spa_imp_recoilless",
		"tur_bldg_spa_imp_guided_rocket",
		"tur_bldg_spa_rep_chaingun",
		"tur_bldg_spa_rep_beam",
		"tur_bldg_spa_imp_chaingun",
        	"tur_bldg_chaingun_roof")
    SetupTeams({ 
        imp =         { team = IMP, units = 10, reinforcements = 25, 
          pilot =           { "imp_inf_pilot", 8 }, 
          marine =           { "imp_inf_marine", 2 }
         }, 
        rep =         { team = REP, units = 22, reinforcements = -1, 
          pilot =           { "rep_inf_ep2_pilot", 12 }, 
          marine =           { "rep_inf_ep2_marine", 10 }
         }
       })
    ClearWalkers()
    SetMemoryPoolSize("PowerupItem",60)
    SetMemoryPoolSize("EntityMine",40)
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
    SetSpawnDelay(10,0.25)
    ReadDataFile("SPA\\spa5.lvl")
--  ReadDataFile("spa\\spa5.lvl")
    SetDenseEnvironment("false")

    voiceSlow = OpenAudioStream("sound\\global.lvl", "spa1_objective_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "rep_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow) 
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)
    AudioStreamAppendSegments("sound\\global.lvl",  "global_vo_quick", voiceQuick)  
        
      OpenAudioStream("sound\\global.lvl",  "cw_music")
      --OpenAudioStream("sound\\spa5.lvl",  "spa5_objective_vo")
      -- OpenAudioStream("sound\\spa.lvl",  "spa1_objective_vo_slow")
      -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
      OpenAudioStream("sound\\spa.lvl",  "spa")
      OpenAudioStream("sound\\spa.lvl",  "spa")
      OpenAudioStream("sound\\spa5.lvl",  "spa5")

      SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
      SetLowReinforcementsVoiceOver(REP, IMP, "rep_off_victory_im", .1, 1)
      SetLowReinforcementsVoiceOver(IMP, IMP, "SPA5_obj_12", .1, 1)
      SetLowReinforcementsVoiceOver(IMP, REP, "imp_off_victory_im", .1, 1)

      SetVictoryMusic(REP, "cis_spa_amb_victory")
      SetDefeatMusic (REP, "cis_spa_amb_defeat")
      SetVictoryMusic(IMP, "cis_spa_amb_victory")
      SetDefeatMusic (IMP, "cis_spa_amb_defeat")

    SetOutOfBoundsVoiceOver(1,"impleaving")
    SetOutOfBoundsVoiceOver(2,"repleaving")
    SetSoundEffect("ScopeDisplayZoomIn","binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut","binocularzoomout")
    SetSoundEffect("SpawnDisplayUnitChange","shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept","shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange","shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept","shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack","shell_menu_exit")
    AddCameraShot(-0.40489500761032,0.0009919999865815,-0.91435998678207,-0.0022400000598282,-85.539894104004,20.536296844482,141.6994934082)
if gPlatformStr == "PS2" then
end
    ScriptCB_DisableFlyerShadows()
end
