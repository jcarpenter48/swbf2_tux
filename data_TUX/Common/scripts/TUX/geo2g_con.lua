-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams") 

ALL = 2
IMP = 1

ATT = 1
DEF = 2

function ScriptPostLoad()	   
    
    EnableFlyerPath("flyers",1)
    EnableFlyerPath("landing1",0)
    EnableFlyerPath("landing2",0)
    DeactivateRegion("landing2")
    DeactivateRegion("landing2")
    
    LandingCheck1 = false
    LandingCheck2 = false
    
    --Setup Timers
    timePop = CreateTimer("timePop")
	SetTimerValue(timePop, 180)
    
    timePopTwo = CreateTimer("timePopTwo")
	SetTimerValue(timePopTwo, 600)
    
    timePopThree = CreateTimer("timePopThree")
	SetTimerValue(timePopThree, 600)
    
    StartTimer(timePop)
    timePopElapse = OnTimerElapse(
        function(timer)
            ActivateRegion("landing1")
            ActivateRegion("landing2")
            EnableFlyerPath("landing1",1)
            EnableFlyerPath("landing2",1)
            print("GS1: LAAT landing paths activated!")
            DestroyTimer(timer)
            ReleaseTimerElapse(timePopElapse)
            timePopElapse = nil
        end,
    timePop
    )
    
    timePopTwoElapse = OnTimerElapse(
        function(timer)
            EnableFlyerPath("landing1",1)
            ActivateRegion("landing1")
            DestroyTimer(timer)
            ReleaseTimerElapse(timePopTwoElapse)
            timePopTwoElapse = nil
        end,
    timePopTwo
    )
    
    timePopThreeElapse = OnTimerElapse(
        function(timer)
            EnableFlyerPath("landing2",1)
            ActivateRegion("landing2")
            DestroyTimer(timer)
            ReleaseTimerElapse(timePopThreeElapse)
            timePopThreeElapse = nil
        end,
    timePopThree
    )
    
	LandingOne = OnEnterRegion(
	function(region, character)
		local ship = GetCharacterVehicle(character)
		local shipclass = GetEntityClass(ship) 
		if shipclass == FindEntityClass("rep_fly_gunship_sc") then
			EntityFlyerLand(ship)
			print("GS1:LandingOne: Ship landed!")
            EnableFlyerPath("landing1",0)
            DeactivateRegion("landing1")
            if LandingCheck1 == false then
                StartTimer(timePopTwo)
                LandingCheck1 = true
            else
                ReleaseEnterRegion(LandingOne)
                LandingOne = nil
            end
		end
	end,
	"landing1"
	)
    
	LandingTwo = OnEnterRegion(
	function(region, character)
		local ship = GetCharacterVehicle(character)
		local shipclass = GetEntityClass(ship) 
		if shipclass == FindEntityClass("rep_fly_gunship_sc") then
			EntityFlyerLand(ship)
			print("GS1:LandingTwo: Ship landed!")
            EnableFlyerPath("landing2",0)
            DeactivateRegion("landing2")
            if LandingCheck2 == false then
                StartTimer(timePopThree)
                LandingCheck2 = true
            else
                ReleaseEnterRegion(LandingTwo)
                LandingTwo = nil
            end
		end
	end,
	"landing2"
	)
    
	FCCKill = OnObjectKillName(
	function(object,killer)
        KillObject("CP2")
	end, "FCC")
	
	FCCRepair = OnObjectRepairName(
	function(object,killer)
        RespawnObject("CP2")
	end, "FCC")
    
    cp1 = CommandPost:New{name = "CP13"}
    cp2 = CommandPost:New{name = "CP14"}
    cp3 = CommandPost:New{name = "CP10"}
    cp4 = CommandPost:New{name = "CP6"}
    cp5 = CommandPost:New{name = "CP2"}
    cp6 = CommandPost:New{name = "CP7"}
    cp7 = CommandPost:New{name = "CP3"}
    cp8 = CommandPost:New{name = "CP5"}
    
    conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, 
        textATT = "game.modes.con", 
        textDEF = "game.modes.con2",
        multiplayerRules = true}
    
    conquest:AddCommandPost(cp1)
    conquest:AddCommandPost(cp2)
    conquest:AddCommandPost(cp3)
    conquest:AddCommandPost(cp4)
    conquest:AddCommandPost(cp5)
    conquest:AddCommandPost(cp6)
    conquest:AddCommandPost(cp7)
    conquest:AddCommandPost(cp8)
    
    conquest:Start()
    EnableSPHeroRules()
 end
 
function ScriptInit()
    --SetMemoryPoolSize("ParticleTransformer::PositionTr", 2000)
    --SetMemoryPoolSize("ParticleTransformer::ColorTrans", 3000)
    --SetMemoryPoolSize("ParticleTransformer::SizeTransf", 1600)
    
    --SetMemoryPoolSize("RedShadingState", 32)
    ReadDataFile("ingame.lvl")
	
    SetMaxFlyHeight(150)
    SetMaxPlayerFlyHeight (150)
    SetGroundFlyerMap(1)
    SetWorldExtents(1163.5)
    
	--[[SetMemoryPoolSize ("Combo",2)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",26)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",26) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",26)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",80)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",3)     -- should be ~1x #combo
	SetMemoryPoolSize("SoldierAnimation", 220)
    
    ScriptCB_SetDopplerFactor(0.3)
    ScaleSoundParameter("tur_weapons",   "MinDistance",   3.0);
    ScaleSoundParameter("tur_weapons",   "MaxDistance",   3.0);
    ScaleSoundParameter("tur_weapons",   "MuteDistance",   3.0);
    ScaleSoundParameter("Ordnance_Large",   "MinDistance",   3.0);
    ScaleSoundParameter("Ordnance_Large",   "MaxDistance",   3.0);
    ScaleSoundParameter("Ordnance_Large",   "MuteDistance",   3.0);
    ScaleSoundParameter("explosion",   "MaxDistance",   5.0);
    ScaleSoundParameter("explosion",   "MuteDistance",  5.0);]]--
     
    --SetMemoryPoolSize("Music", 40)
    --ReadDataFile("dc:SOUND\\GS1.lvl")
    ReadDataFile("sound\\hot.lvl;hot1gcw")
     ReadDataFile("SIDE\\all_256.lvl",
                    "all_inf_rifleman_fleet",
                    "all_inf_rocketeer_jungle",
                    "all_inf_sniper_fleet",
                    "all_inf_engineer_fleet",
                    "all_inf_officer",
                    "all_hero_luke_pilot",
					"all_fly_snowspeeder",
                    "all_inf_wookiee")
                    
     ReadDataFile("SIDE\\imp_256.lvl",
                    "imp_inf_rifleman",
                    "imp_inf_rocketeer",
                    "imp_inf_officer",
                    "imp_inf_sniper",
                    "imp_inf_engineer",
                    "imp_inf_dark_trooper",
					"imp_walk_atat",
                    "imp_hero_darthvader")

	--ReadDataFile("SIDE\\geo.lvl",
	--					 "gen_inf_geonosian")
	
    ReadDataFile("SIDE\\rep_256.lvl",
        "rep_fly_gunship_sc")
		
	ReadDataFile("SIDE\\tur.lvl",
        "tur_bldg_geoturret")
                    
    SetupTeams{

        all={
            team = ALL,
            units = 20,
            reinforcements = 150,
            soldier  = {"all_inf_rifleman_fleet",7, 15},
            assault  = {"all_inf_rocketeer_jungle",1, 4},
            engineer = {"all_inf_engineer_fleet",1, 4},
            sniper   = {"all_inf_sniper_fleet",1, 4},
            officer  = {"all_inf_officer",1, 4},
            special  = {"all_inf_wookiee",1, 4},
            
            
        },
        
        imp={
            team = IMP,
            units = 20,
            reinforcements = 150,
            soldier  = {"imp_inf_rifleman",7, 15},
            assault  = {"imp_inf_rocketeer",1, 4},
            engineer = {"imp_inf_engineer",1, 4},
            sniper   = {"imp_inf_sniper",1, 4},
            officer  = {"imp_inf_officer",1, 4},
            special  = {"imp_inf_dark_trooper",1, 4},
        }
    }
    
    SetHeroClass(IMP, "imp_hero_darthvader")
    SetHeroClass(ALL, "all_hero_luke_pilot")

    --[[  Local Stats
    SetTeamName(3, "locals")
    SetUnitCount(3, 5)
    AddUnitClass(3, "geo_inf_geonosian", 5)    
    SetTeamAsFriend(3, 2)
	SetTeamAsEnemy(1,3)
    SetTeamAsEnemy(3,1)
    SetTeamAsFriend(2,3)
    --SetTeamName(4, "locals")
    --AddUnitClass(4, "rep_inf_jedimale",1)
    --AddUnitClass(4, "rep_inf_jedimaleb",1)
    --AddUnitClass(4, "rep_inf_jedimaley",1)
    --SetUnitCount(4, 3)
    --SetTeamAsFriend(4, ATT)
	AddAIGoal(3, "Deathmatch", 100)
	]]--
	
    ClearWalkers()
    SetMemoryPoolSize("EntityWalker", -1)
    AddWalkerType(0, 0) -- special -> droidekas
    AddWalkerType(1, 0) -- 1x2 (1 pair of legs)
    AddWalkerType(2, 2) -- 2x2 (2 pairs of legs)
    AddWalkerType(3, 2) -- 3x2 (3 pairs of legs)
    
    --local weaponCnt = 1024
    --SetMemoryPoolSize("Aimer", 128)
    --SetMemoryPoolSize("AmmoCounter", weaponCnt)
    --SetMemoryPoolSize("BaseHint", 1024)
    --SetMemoryPoolSize("EnergyBar", weaponCnt)
	--SetMemoryPoolSize("EntityCloth", 128)
	SetMemoryPoolSize("EntityFlyer", 2)
    SetMemoryPoolSize("CommandWalker", 2)
	
	SetMemoryPoolSize("EntityCloth", 41)
    SetMemoryPoolSize("EntityFlyer", 10)
	SetMemoryPoolSize("FLEffectObject::OffsetMatrix", 54)
    SetMemoryPoolSize("Navigator", 63)
    SetMemoryPoolSize("Obstacle", 400)
  SetMemoryPoolSize("OrdnanceTowCable", 40) -- !!!! need +4 extra for wrapped/fallen cables !!!!
    SetMemoryPoolSize("PathFollower", 63)
	SetMemoryPoolSize("PathNode", 128)
	SetMemoryPoolSize("ShieldEffect", 0)
    SetMemoryPoolSize("TreeGridStack", 300)
    SetMemoryPoolSize("UnitController", 63)
    SetMemoryPoolSize("UnitAgent", 63)
    --SetMemoryPoolSize("CommandFlyer", 2)
    SetMemoryPoolSize("EntityHover", 2)
    --SetMemoryPoolSize("EntityLight", 200)
    --SetMemoryPoolSize("EntitySoundStream", 16)
    --SetMemoryPoolSize("EntitySoundStatic", 150)
    SetMemoryPoolSize("MountedTurret", 6)
    --SetMemoryPoolSize("Navigator", 128)
    --SetMemoryPoolSize("Obstacle", 1400)
	--SetMemoryPoolSize("PathNode", 1024)
    --SetMemoryPoolSize("SoundSpaceRegion", 24)
    --SetMemoryPoolSize("TreeGridStack", 512)
	--SetMemoryPoolSize("UnitAgent", 128)
	--SetMemoryPoolSize("UnitController", 128)
	--SetMemoryPoolSize("SoldierAnimation", 300)
	--SetMemoryPoolSize("Weapon", weaponCnt)
    
    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("GEO\\hot1.lvl", "GS1_conquest")
    SetDenseEnvironment("false")
    
    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "all_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "imp_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl",  "all_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl",  "imp_unit_vo_quick", voiceQuick)   
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\hot.lvl", "hot1gcw")
    OpenAudioStream("sound\\hot.lvl", "hot1gcw")

    SetBleedingVoiceOver(ALL, ALL, "all_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(ALL, IMP, "all_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, ALL, "imp_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(IMP, IMP, "imp_off_com_report_us_overwhelmed", 1)

    -- SetLowReinforcementsVoiceOver(ALL, IMP, "all_hot_transport_away", .75, 1)
    -- SetLowReinforcementsVoiceOver(ALL, IMP, "all_hot_transport_away", .5, 1)
    -- SetLowReinforcementsVoiceOver(ALL, IMP, "all_hot_transport_away", .25, 1)

    SetLowReinforcementsVoiceOver(ALL, ALL, "all_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(ALL, IMP, "all_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, IMP, "imp_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(IMP, ALL, "imp_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(ALL, "Allleaving")
    SetOutOfBoundsVoiceOver(IMP, "Impleaving")

    SetAmbientMusic(ALL, 1.0, "all_hot_amb_start",  0,1)
    SetAmbientMusic(ALL, 0.8, "all_hot_amb_middle", 1,1)
    SetAmbientMusic(ALL, 0.2, "all_hot_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "imp_hot_amb_start",  0,1)
    SetAmbientMusic(IMP, 0.8, "imp_hot_amb_middle", 1,1)
    SetAmbientMusic(IMP, 0.2, "imp_hot_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_hot_amb_victory")
    SetDefeatMusic (ALL, "all_hot_amb_defeat")
    SetVictoryMusic(IMP, "imp_hot_amb_victory")
    SetDefeatMusic (IMP, "imp_hot_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")


    --OpeningSateliteShot
    AddCameraShot(0.991971, -0.061071, 0.110533, 0.006805, 98.194824, -44.637959, -60.939774);
	--Mountain
	AddCameraShot(0.996091, 0.085528, -0.022005, 0.001889, -6.942698, -59.197201, 26.136919);
	--Wrecked Ship
	AddCameraShot(0.906778, 0.081875, -0.411906, 0.037192, 26.373968, -59.937874, 122.553581);
	--War Room	
	AddCameraShot(0.994219, 0.074374, 0.077228, -0.005777, 90.939568, -49.293945, -69.571136);
end