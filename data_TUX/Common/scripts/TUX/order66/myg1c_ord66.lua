--fel1c_ord66.lua
-- Decompiled with SWBF2CodeHelper
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("setup_teams")
REP = 1
JED = 2
ATT = 1
DEF = 2

function ScriptPostLoad()
    DisableBarriers("dropship")
    DisableBarriers("shield_03")
    DisableBarriers("shield_02")
    DisableBarriers("shield_01")
    DisableBarriers("ctf")
    DisableBarriers("ctf1")
    DisableBarriers("ctf2")
    DisableBarriers("ctf3")
    DisableBarriers("coresh1")

    SetProperty("CP1_CON","CaptureRegion","")
    SetProperty("CP2_CON","CaptureRegion","")
    SetProperty("CP4_CON","CaptureRegion","")
    SetProperty("CP5_CON","CaptureRegion","")
    SetProperty("CP7_CON","CaptureRegion","")
    SetProperty("CP1_CON","Team","1")
    SetProperty("CP2_CON","Team","2")
    SetProperty("CP4_CON","Team","2")
    SetProperty("CP5_CON","Team","1")
    SetProperty("CP7_CON","Team","3")	
	AddAIGoal(3, "Deathmatch", 1000, 0)
	
	--fix the jedi classes
	SetClassProperty("jed_knight_01", "FleeLikeAHero", 0)
	SetClassProperty("jed_knight_02", "FleeLikeAHero", 0)	
	SetClassProperty("jed_knight_03", "FleeLikeAHero", 0)
	SetClassProperty("jed_knight_04", "FleeLikeAHero", 0)
	SetClassProperty("jed_master_01", "FleeLikeAHero", 0)
	SetClassProperty("jed_master_02", "FleeLikeAHero", 0)	
	SetClassProperty("jed_master_03", "FleeLikeAHero", 0)
	SetClassProperty("jed_runner", "FleeLikeAHero", 0)
	
	SetClassProperty("jed_knight_01", "NoEnterVehicles", 0)
	SetClassProperty("jed_knight_02", "NoEnterVehicles", 0)	
	SetClassProperty("jed_knight_03", "NoEnterVehicles", 0)
	SetClassProperty("jed_knight_04", "NoEnterVehicles", 0)
	SetClassProperty("jed_master_01", "NoEnterVehicles", 0)
	SetClassProperty("jed_master_02", "NoEnterVehicles", 0)	
	SetClassProperty("jed_master_03", "NoEnterVehicles", 0)
	SetClassProperty("jed_runner", "NoEnterVehicles", 0)

	SetClassProperty("jed_knight_01", "AddHealth", 0.0)
	SetClassProperty("jed_knight_02", "AddHealth", 0.0)	
	SetClassProperty("jed_knight_03", "AddHealth", 0.0)
	SetClassProperty("jed_knight_04", "AddHealth", 0.0)
	SetClassProperty("jed_runner", "AddHealth", 0.0)
	
	--make the unlocks more fair
	SetClassProperty("jed_master_01", "PointsToUnlock", 12)
	SetClassProperty("jed_master_02", "PointsToUnlock", 12)	
	SetClassProperty("jed_master_03", "PointsToUnlock", 12)
	SetClassProperty("rep_inf_ep3_commando", "PointsToUnlock", 0)	
	SetClassProperty("rep_inf_ep3_commando", "MaxHealth", 2200.0)
	SetClassProperty("rep_inf_ep3_commando", "FleeLikeAHero", 1)

	-- Timer for skins--

	--interval is the number of seconds between model changes
	--maxskin is the number of versions to use

	interval = 10 --i had been testing this at 10 second waves, but it could be changed
	--in MP, it will probably cause each 15 second spawn-wave to be the same model
	skintimer = CreateTimer("timeout") -- i don't know what significance "timeout" has, copied from hoth campaign this way
	SetTimerValue(skintimer , interval )
	--ShowTimer(skintimer ) --uncomment this line to see the timer onscreen
	skin = 1
	maxskin = 2

	OnTimerElapse(
	function(timer)


	if (skin == 2) then
		SetClassProperty("rep_inf_ep3_rifleman", "GeometryName", "rep_inf_clonecommander")
		SetClassProperty("rep_inf_ep3_sniper", "GeometryName", "rep_inf_clonecommander")
		SetClassProperty("rep_inf_ep3_rifleman", "ClothODF", "rep_inf_clonecommander_cape")
		SetClassProperty("rep_inf_ep3_rifleman", "GeometryLowRes", "rep_inf_clonecommander_low1")
		SetClassProperty("rep_inf_ep3_sniper", "GeometryLowRes", "rep_inf_clonecommander_low1") 
		--officer appearance to Bacara
		SetClassProperty("rep_inf_ep3_officer", "GeometryName", "rep_inf_ep3heavytrooper")
		SetClassProperty("rep_inf_ep3_officer", "GeometryLowRes", "rep_inf_ep3heavytrooper_low1") 
		SetClassProperty("rep_inf_ep3_officer", "ClothODF", "rep_inf_ep3heavytrooper_cape") 
	end
	if (skin == 1) then
		SetClassProperty("rep_inf_ep3_rifleman", "GeometryName", "rep_inf_ep3trooper")
		SetClassProperty("rep_inf_ep3_sniper", "GeometryName", "rep_inf_ep3sniper")
		SetClassProperty("rep_inf_ep3_rifleman", "ClothODF", "rep_inf_ep3sniper_cape")
		SetClassProperty("rep_inf_ep3_rifleman", "GeometryLowRes", "rep_inf_ep3trooper_low1")
		SetClassProperty("rep_inf_ep3_sniper", "GeometryLowRes", "rep_inf_ep3sniper_low1") 
		--officer appearance to Bacara
		SetClassProperty("rep_inf_ep3_officer", "GeometryName", "rep_inf_clonecommander")
		SetClassProperty("rep_inf_ep3_officer", "GeometryLowRes", "rep_inf_clonecommander_low1") 
		SetClassProperty("rep_inf_ep3_officer", "ClothODF", "rep_inf_clonecommander_cape") 
	end



	skin = skin + 1

	if (skin > maxskin) then
	skin = 1
	end

	--ShowTimer(nil)
	--DestroyTimer(timer)



	SetTimerValue(skintimer , interval )
	StartTimer(skintimer)


	end,
	skintimer
	)	
	
    TDM = ObjectiveTDM:New({ teamATT = 1, teamDEF = 2, multiplayerScoreLimit = 75, textATT = "game.modes.tdm", textDEF = "game.modes.tdm2", multiplayerRules = true, isCelebrityDeathmatch = true })
    TDM:Start()
	
	EnableSPHeroRules()	

	--skin stuff
	if( ScriptCB_IsFileExist("nogmehoth.txt") ~= 1 ) then 
		--start our skin timer
		StartTimer(skintimer) --starts the timer the first time, after it starts, it will restart itself one ending.
	end --allow option to switch Galactic Marines off, mainly if there is a future TC that breaks this. 
	--just place a file named nogmehoth.txt (doesn't have to actually contain anything, just named that) to disable Galactic Marines
		
end

function ScriptInit()
    SetPS2ModelMemory(4056000)
    ReadDataFile("ingame.lvl")
    SetMaxFlyHeight(53)
    SetMaxPlayerFlyHeight(53)
    --[[SetMemoryPoolSize("ClothData",20)
    SetMemoryPoolSize("Combo",15)
    SetMemoryPoolSize("Combo::State",250)
    SetMemoryPoolSize("Combo::Transition",300)
    SetMemoryPoolSize("Combo::Condition",300)
    SetMemoryPoolSize("Combo::Attack",250)
    SetMemoryPoolSize("Combo::DamageSample",10000)
    SetMemoryPoolSize("Combo::Deflect",150)]]--
    SetMemoryPoolSize ("ClothData",20)
    SetMemoryPoolSize ("Combo",40)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",450)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",450) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",450)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",450)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",8000)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",96)     -- should be ~1x #combo
	SetMemoryPoolSize ("SoldierAnimation",350)	
	
   ReadDataFile("sound\\myg.lvl;myg1cw")
    ReadDataFile("SIDE\\rep_256.lvl","rep_inf_ep3_rifleman","rep_inf_ep3_rocketeer","rep_inf_ep3_engineer","rep_inf_ep3_sniper","rep_inf_ep3_officer","rep_inf_ep3_jettrooper")
	
    --ReadDataFile("SIDE\\jed.lvl","jed_knight_01","jed_knight_02","jed_knight_03","jed_knight_04")
   -- ReadDataFile("SIDE\\infantry.lvl","jed_knight_10","jed_knight_13","jed_knight_14")
    ReadDataFile("SIDE\\rep_128.lvl", "rep_fly_gunship_dome") --dependency for some jedi
    ReadDataFile("SIDE\\rep_256.lvl", "rep_hover_fightertank","rep_hero_kiyadimundi")            
    ReadDataFile("SIDE\\jed.lvl",
        "jed_knight_01",
        "jed_knight_02",
        "jed_knight_03",
        "jed_knight_04",
        --"jed_master_01",
        "jed_master_02",
        --"jed_master_03",
        "jed_runner")	
	
	ReadDataFile("SIDE\\commando.lvl", "rep_inf_ep3_commando")

    ReadDataFile("SIDE\\tur.lvl",
    						"tur_bldg_recoilless_lg")
							
	ReadDataFile("SIDE\\cis_128.lvl", "cis_inf_marine")						
							
    SetupTeams({ 
        REP =         { team = REP, units = 24, reinforcements = -1, 
          soldier =           { "rep_inf_ep3_rifleman", 13, 16 }, 
          assault =           { "rep_inf_ep3_rocketeer", 5, 4 }, 
          engineer =           { "rep_inf_ep3_engineer", 3, 4 }, 
          sniper =           { "rep_inf_ep3_sniper", 2, 4 }, 
          officer =           { "rep_inf_ep3_officer", 2, 4 }, 
          special =           { "rep_inf_ep3_jettrooper", 2, 4 }
         }, 
        JED =         { team = JED, units = 14, reinforcements = -1, 
          soldier =           { "jed_knight_01", 4, 6 }, 
          assault =           { "jed_knight_02", 4, 6 }, 
          engineer =           { "jed_knight_03", 3, 6 }, 
          sniper =           { "jed_knight_04", 2, 6 }, 
          officer =           { "jed_runner", 1, 1 }, 
          special =           { "jed_master_02", 1, 1 }
         }
       })
	SetHeroClass(JED, "rep_hero_kiyadimundi")
	SetHeroClass(REP, "rep_inf_ep3_commando")
	SetTeamName(JED, "Jedi")
    ClearWalkers()
    SetMemoryPoolSize("Aimer",20)
    SetMemoryPoolSize("AmmoCounter",260)
    SetMemoryPoolSize("BaseHint",200)
    SetMemoryPoolSize("EnergyBar",260)
    SetMemoryPoolSize("EntityHover", 7)
    SetMemoryPoolSize("EntityFlyer",4)
    SetMemoryPoolSize("EntitySoundStream",1)
    SetMemoryPoolSize("EntitySoundStatic",0)
    --SetMemoryPoolSize("EntityWalker",1)
    SetMemoryPoolSize("MountedTurret", 16)
    SetMemoryPoolSize("Navigator", 50)
    SetMemoryPoolSize("Obstacle", 500)
    SetMemoryPoolSize("PathNode", 256)
    SetMemoryPoolSize("TreeGridStack", 275)
    SetMemoryPoolSize("UnitAgent", 50)
    SetMemoryPoolSize("UnitController", 50)
    SetMemoryPoolSize("Weapon",260)
    SetMemoryPoolSize("Music",39)

    SetSpawnDelay(10.0, 0.25)
    ReadDataFile("myg\\myg1.lvl", "myg1_conquest")
    SetDenseEnvironment("false")
    AddDeathRegion("deathregion")
    SetMaxFlyHeight(20)
    SetMaxPlayerFlyHeight(20)

    --  Local Stats
    SetTeamName(3, "CIS")
    SetTeamIcon(3, "cis_icon")
    AddUnitClass(3, "cis_inf_marine", 6)
    SetUnitCount(3, 6)
    SetTeamAsEnemy(3,DEF)
    SetTeamAsEnemy(3,ATT)
	SetTeamAsEnemy(ATT,3)
    SetTeamAsEnemy(DEF,3)
	
    --  Sound Stats
    
    voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
    AudioStreamAppendSegments("sound\\global.lvl", "all_unit_vo_slow", voiceSlow)
    AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
    
    voiceQuick = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_quick")
    AudioStreamAppendSegments("sound\\global.lvl", "all_unit_vo_quick", voiceQuick)    
    
    OpenAudioStream("sound\\global.lvl",  "cw_music")
    OpenAudioStream("sound\\myg.lvl",  "myg1")
    OpenAudioStream("sound\\myg.lvl",  "myg1")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_quick")
    -- OpenAudioStream("sound\\global.lvl",  "global_vo_slow")
    -- OpenAudioStream("sound\\myg.lvl",  "myg1_emt")

    SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
    SetBleedingVoiceOver(REP, JED, "rep_off_com_report_enemy_losing",   1)
    --SetBleedingVoiceOver(JED, REP, "cis_off_com_report_enemy_losing",   1)
    --SetBleedingVoiceOver(JED, JED, "cis_off_com_report_us_overwhelmed", 1)
    
    SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
    SetLowReinforcementsVoiceOver(REP, JED, "rep_off_victory_im", .1, 1)
    --SetLowReinforcementsVoiceOver(JED, JED, "cis_off_defeat_im", .1, 1)
    --SetLowReinforcementsVoiceOver(JED, REP, "cis_off_victory_im", .1, 1)    

    SetOutOfBoundsVoiceOver(REP, "Repleaving")
    SetOutOfBoundsVoiceOver(JED, "Repleaving")

    SetAmbientMusic(REP, 1.0, "rep_myg_amb_start",  0,1)
    SetAmbientMusic(REP, 0.8, "rep_myg_amb_middle", 1,1)
    SetAmbientMusic(REP, 0.2,"rep_myg_amb_end",    2,1)
    SetAmbientMusic(JED, 1.0, "cis_myg_amb_start",  0,1)
    SetAmbientMusic(JED, 0.8, "cis_myg_amb_middle", 1,1)
    SetAmbientMusic(JED, 0.2,"cis_myg_amb_end",    2,1)

    SetVictoryMusic(REP, "rep_myg_amb_victory")
    SetDefeatMusic (REP, "rep_myg_amb_defeat")
    SetVictoryMusic(JED, "cis_myg_amb_victory")
    SetDefeatMusic (JED, "cis_myg_amb_defeat")

    SetSoundEffect("ScopeDisplayZoomIn",  "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    --SetSoundEffect("WeaponUnableSelect",  "com_weap_inf_weaponchange_null")
    --SetSoundEffect("WeaponModeUnableSelect",  "com_weap_inf_modechange_null")
    SetSoundEffect("SpawnDisplayUnitChange",       "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept",       "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack",             "shell_menu_exit")


        --Camera Shizzle--
        
        -- Collector Shot
    AddCameraShot(0.008315, 0.000001, -0.999965, 0.000074, -64.894348, 5.541570, 201.711090);
	AddCameraShot(0.633584, -0.048454, -0.769907, -0.058879, -171.257629, 7.728924, 28.249359);
	AddCameraShot(-0.001735, -0.000089, -0.998692, 0.051092, -146.093109, 4.418306, -167.739212);
	AddCameraShot(0.984182, -0.048488, 0.170190, 0.008385, 1.725611, 8.877428, 88.413887);
	AddCameraShot(0.141407, -0.012274, -0.986168, -0.085598, -77.743042, 8.067328, 42.336128);
	AddCameraShot(0.797017, 0.029661, 0.602810, -0.022434, -45.726467, 7.754435, -47.544712);
	AddCameraShot(0.998764, 0.044818, -0.021459, 0.000963, -71.276566, 4.417432, 221.054550);
end

