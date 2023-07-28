--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

-- load the gametype script
Conquest = ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams") 

--  These variables do not change
ATT = 1
DEF = 2

--  Empire Attacking (attacker is always #1)
CIS = ATT
REP = DEF

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
	EnableSPHeroRules()
    --This sets up the actual objective.  This needs to happen after cp's are defined
	hunt = ObjectiveTDM:New{teamATT = 1, teamDEF = 2,
						pointsPerKillATT = 1, pointsPerKillDEF = 1,
						textATT = "game.modes.hunt",
						textDEF = "game.modes.hunt2", hideCPs = true, multiplayerRules = true}	
	hunt:Start()
	
	AddAIGoal(ATT, "Deathmatch", 1000)
	AddAIGoal(DEF, "Deathmatch", 1000)
 end

function ScriptInit()
    -- Designers, these two lines *MUST* be first.
    StealArtistHeap( 2048 * 1024) 
    if (ScriptCB_GetPlatform() == "PSP") then 
        SetPSPModelMemory(6000000)
        SetPSPClipper(1)
    end 
    SetPS2ModelMemory(4200000)
    ReadDataFile("ingame.lvl")

    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",30)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",500)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",500) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",500)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",400)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",4000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",88)     -- should be ~1x #combo
    
    SetMapNorthAngle(180, 1)
    SetMaxFlyHeight(70)
    SetMaxPlayerFlyHeight (70)
          
    ReadDataFile("sound\\cor.lvl;cor1cw")

	ReadDataFile("SIDE\\rep.lvl",
	"rep_hero_cloakedanakin")
                
    ReadDataFile("SIDE\\jed.lvl",
                "jed_knight_01",
                "jed_knight_02",
                --"jed_knight_03",
                "jed_master_01",
                "jed_sith_01")
                --"jed_runner")
    
	ReadDataFile("SIDE\\tur.lvl",
	"tur_weap_built_gunturret")
		
    ReadDataFile("SIDE\\tur.lvl", 
    			"tur_bldg_laser")          
    
    ReadDataFile("SIDE\\jed.lvl",
				"jed_knight_03",
				"jed_knight_04",
				"jed_master_02",
				"jed_master_03",
				"jed_runner")	
    
    SetupTeams{
             
        rep = {
            team = REP,
            units = 18,
            reinforcements = -1,
            soldier  = { "jed_knight_01",7, 8},
            assault  = { "jed_knight_02",1, 4},
            engineer = { "jed_knight_03",1, 4},
            sniper   = { "jed_runner",1, 4},
            officer = {"jed_master_01",1, 4},
            
        },
        cis = {
            team = CIS,
            units = 18,
            reinforcements = -1,
            soldier  = { "jed_sith_01",7, 32},
        }
     }
	 AddUnitClass(2, "jed_knight_04",1,4)
	 AddUnitClass(2, "jed_master_02",1,4)
	 AddUnitClass(2, "jed_master_03",1,4)
	SetTeamName(CIS, "sith")
    SetTeamName(REP, "jedi")
     
    
--  Level Stats
    ClearWalkers()
    AddWalkerType(0, 3) -- 8 droidekas (special case: 0 leg pairs)
    AddWalkerType(1, 0) -- 
    AddWalkerType(2, 0) -- 2 spider walkers with 2 leg pairs each
    AddWalkerType(3, 0) -- 2 attes with 3 leg pairs each
    local weaponCnt = 210
    SetMemoryPoolSize("Aimer", 22)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 250)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCloth", 18)
    SetMemoryPoolSize("EntitySoundStream", 10)
    SetMemoryPoolSize("EntitySoundStatic", 0)
    SetMemoryPoolSize("MountedTurret",12)
    SetMemoryPoolSize("PathFollower", 50)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 375)
    SetMemoryPoolSize("SoundSpaceRegion", 38)
    SetMemoryPoolSize("TentacleSimulator", 0)
    SetMemoryPoolSize("TreeGridStack", 140)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon", weaponCnt)
	SetMemoryPoolSize("EntityFlyer", 4)   

    SetSpawnDelay(10.0, 0.25)
   ReadDataFile("KOR\\kor1.lvl", "PSK_eli")
    SetDenseEnvironment("false")
         -- SetMaxFlyHeight(25)
     --SetMaxPlayerFlyHeight (25)
	--AddDeathRegion("DeathRegion1")

    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_quick", voiceQuick)
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    OpenAudioStream("sound\\cor.lvl",  "cor1")
    OpenAudioStream("sound\\cor.lvl",  "cor1")
    -- OpenAudioStream("sound\\cor.lvl",  "cor1_emt")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",   1)
    SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(CIS, REP, "cis_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(2, "Repleaving")
    SetOutOfBoundsVoiceOver(1, "Cisleaving")

    SetAmbientMusic(REP, 1.0, "rep_cor_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_cor_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2, "rep_cor_amb_end",    2,1)
    SetAmbientMusic(CIS, 1.0, "cis_cor_amb_start",  0,1)
    SetAmbientMusic(CIS, 0.8, "cis_cor_amb_middle", 1,1)
    SetAmbientMusic(CIS, 0.2, "cis_cor_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_cor_amb_victory")
    SetDefeatMusic (REP, "rep_cor_amb_defeat")
    SetVictoryMusic(CIS, "cis_cor_amb_victory")
    SetDefeatMusic (CIS, "cis_cor_amb_defeat")

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
	AddCameraShot(0.755959, 0.056311, -0.650391, 0.048447, -20.530973, 11.287577, -204.418076);
	AddCameraShot(0.231732, -0.020220, -0.968888, -0.084542, 28.562346, 11.287577, -170.938446);
	AddCameraShot(0.706486, -0.061646, 0.702368, 0.061287, -1.079526, 11.287577, -105.581268);

end


