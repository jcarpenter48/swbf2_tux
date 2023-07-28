--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
-- Mos Eisley Hero Deathmatch (uses Space Assault rules)
-- First team to reach 100 kills wins
--

ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveTDM")

---------------------------------------------------------------------------
-- ScriptPostLoad
---------------------------------------------------------------------------
function ScriptPostLoad()
	EnableSPHeroRules()
 	-- This is the actual objective setup
	TDM = ObjectiveTDM:New{teamATT = 1, teamDEF = 2, 
						multiplayerScoreLimit = 100,
						textATT = "game.modes.tdm",
						textDEF = "game.modes.tdm2", multiplayerRules = true, isCelebrityDeathmatch = true}
	TDM:Start()

    AddAIGoal(1, "Deathmatch", 100)
    AddAIGoal(2, "Deathmatch", 100)
end

---------------------------------------------------------------------------
-- ScriptInit
---------------------------------------------------------------------------
function ScriptInit()
    StealArtistHeap(1024*1024)
     -- Designers, these two lines *MUST* be first!
    if (ScriptCB_GetPlatform() == "PSP") then 
        SetPSPModelMemory(6000000)
        SetPSPClipper(1)
    end 
    local assetLocation = "addon\\005\\"
    if (ScriptCB_GetPlatform() == "PC") then 
        assetLocation = "DC:"
    end          
    SetPS2ModelMemory(6000000)
    ReadDataFile(assetLocation .. "kotoricons.lvl") 
    ReadDataFile("ingame.lvl")
    ReadDataFile(assetLocation .. "core.lvl")  
    
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",30)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",500)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",500) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",500)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",400)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",4000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",88)     -- should be ~1x #combo

	ALL = 1
	IMP = 2
	--  These variables do not change
	ATT = 1
	DEF = 2

    SetMaxFlyHeight(40)
	SetMaxPlayerFlyHeight(40)

    ReadDataFile("sound\\tat.lvl;tat2gcw")
    ReadDataFile(assetLocation .. "SIDE\\ose.lvl",
                             "ose_hero_calo",
                             "ose_hero_karath",
                             "ose_hero_nihilus",
                             "imp_hero_revan",
                             --"ose_hero_phobos",
                             "ose_hero_malak")
                             
    ReadDataFile(assetLocation .. "SIDE\\orp.lvl",
                             "all_hero_bastila",
                             "orp_hero_jolee",
                             "orp_hero_vandar",
                             --"orp_hero_baodur",
                             --"orp_hero_mira",
                             "orp_hero_canderous",
                             "orp_hero_carth")
        
    SetupTeams{
        hero = {
            team = ALL,
            units = 32,
                reinforcements = -1,
                soldier = { "orp_hero_carth",1,2},
                assault = { "all_hero_bastila",   1,2},
                engineer= { "orp_hero_jolee",   1,2},
                sniper  = { "orp_hero_vandar",  1,2},
                officer = { "orp_hero_canderous",        1,2},
                --special = { "orp_hero_mira",   1,2},           
        },
    }   

    SetupTeams{
        villain = {
            team = IMP,
            units = 32,
            reinforcements = -1,
                soldier = { "ose_hero_malak",    1,2},
                assault = { "ose_hero_nihilus",1,2},
                engineer= { "ose_hero_karath", 1,2},
                sniper  = { "ose_hero_calo", 1,2},
                officer = { "imp_hero_revan",    1,2},
                --special = { "ose_hero_phobos", 1,2},

        },
    }   
    --AddUnitClass(ALL, "orp_hero_baodur",1,2)
    --AddUnitClass(IMP, "cis_hero_countdooku",1,2)

    --  Level Stats
    ClearWalkers()
    AddWalkerType(0, 0) -- special -> droidekas
    AddWalkerType(1, 0) -- 1x2 (1 pair of legs)
    AddWalkerType(2, 0) -- 2x2 (2 pairs of legs)
    AddWalkerType(3, 0) -- 3x2 (3 pairs of legs)
    
    local weaponCnt = 96
    SetMemoryPoolSize("Aimer", 1)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 320)
    SetMemoryPoolSize("ConnectivityGraphFollower", 23)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth",41)
    SetMemoryPoolSize("EntityDefenseGridTurret", 0)
    SetMemoryPoolSize("EntityDroid", 0)
	SetMemoryPoolSize("EntityFlyer", 5) -- to account for 5 chewbaccas
    SetMemoryPoolSize("EntityLight", 80, 80) -- stupid trickery to actually set lights to 80
    SetMemoryPoolSize("EntityPortableTurret", 4) -- nobody has autoturrets AFAIK - MZ
    SetMemoryPoolSize("EntitySoundStream", 4)
    SetMemoryPoolSize("EntitySoundStatic", 4)
    SetMemoryPoolSize("FLEffectObject::OffsetMatrix", 120)
    SetMemoryPoolSize("MountedTurret", 0)
    SetMemoryPoolSize("Navigator", 23)
    SetMemoryPoolSize("Obstacle", 667)
    SetMemoryPoolSize("Ordnance", 80)	-- not much ordnance going on in the level
    SetMemoryPoolSize("ParticleEmitter", 512)
    SetMemoryPoolSize("ParticleEmitterInfoData", 512)
    SetMemoryPoolSize("PathFollower", 23)
    SetMemoryPoolSize("PathNode", 128)
    SetMemoryPoolSize("ShieldEffect", 0)
    SetMemoryPoolSize("TentacleSimulator", 24)
    SetMemoryPoolSize("TreeGridStack", 290)
    SetMemoryPoolSize("UnitAgent", 23)
    SetMemoryPoolSize("UnitController", 23)
    SetMemoryPoolSize("Weapon", weaponCnt)

    SetSpawnDelay(10.0, 0.25)
    ReadDataFile(assetLocation .. "PSK\\PSK.lvl", "PSK_eli")
    SetDenseEnvironment("false")

    --  Sound Stats
    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")
    
    ScriptCB_EnableHeroMusic(0)
    ScriptCB_EnableHeroVO(0)
    
    OpenAudioStream("sound\\global.lvl",  "gcw_music")
    --OpenAudioStream("sound\\tat.lvl",  "tat2")
    --OpenAudioStream("sound\\tat.lvl",  "tat2")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")

    SetAmbientMusic(ALL, 1.0, "gen_amb_celebDeathmatch",  0,1)
    -- SetAmbientMusic(ALL, 0.9, "all_tat_amb_middle", 1,1)
    -- SetAmbientMusic(ALL, 0.1, "all_tat_amb_end",    2,1)
    SetAmbientMusic(IMP, 1.0, "gen_amb_celebDeathmatch",  0,1)
    -- SetAmbientMusic(IMP, 0.9, "imp_tat_amb_middle", 1,1)
    -- SetAmbientMusic(IMP, 0.1, "imp_tat_amb_end",    2,1)

    SetVictoryMusic(ALL, "all_tat_amb_victory")
    SetDefeatMusic (ALL, "all_tat_amb_defeat")
    SetVictoryMusic(IMP, "imp_tat_amb_victory")
    SetDefeatMusic (IMP, "imp_tat_amb_defeat")



    SetAttackingTeam(ATT)

    --  Camera Stats
	AddCameraShot(0.755959, 0.056311, -0.650391, 0.048447, -20.530973, 11.287577, -204.418076);
	AddCameraShot(0.231732, -0.020220, -0.968888, -0.084542, 28.562346, 11.287577, -170.938446);
	AddCameraShot(0.706486, -0.061646, 0.702368, 0.061287, -1.079526, 11.287577, -105.581268);

end