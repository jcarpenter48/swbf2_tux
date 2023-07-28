-- nab2g_dcm.lua
-- PSP 'Imperial Enforcer' Naboo mission
Conquest = ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("MultiObjectiveContainer")
IMP = 1
ALL = 2
ATT = 1
DEF = 2

function ScriptPostLoad()
--hide posts
	MapHideCommandPosts(true)
	SetProperty("eli_cp1", "MapTexture", " ")
	SetProperty("eli_cp1", "MapScale", 0.0)
	SetProperty("eli_cp2", "MapTexture", " ")
	SetProperty("eli_cp2", "MapScale", 0.0)
	SetProperty("eli_cp3", "MapTexture", " ")
	SetProperty("eli_cp3", "MapScale", 0.0)
	SetProperty("eli_cp4", "MapTexture", " ")
	SetProperty("eli_cp4", "MapScale", 0.0)	
	SetProperty("eli_cp5", "MapTexture", " ")
	SetProperty("eli_cp5", "MapScale", 0.0)	
	SetProperty("eli_cp6", "MapTexture", " ")
	SetProperty("eli_cp6", "MapScale", 0.0)	
	
	EnableSPHeroRules()
	ShowAllUnitsOnMinimap(true)
	missiontimer = CreateTimer("missiontimer")
	SetTimerValue(missiontimer, 330)
	fiveminremains = CreateTimer("fiveminremains")
	SetTimerValue(fiveminremains, 30)
	fourminremains = CreateTimer("fourminremains")
	SetTimerValue(fourminremains, 90)
	threeminremains = CreateTimer("threeminremains")
	SetTimerValue(threeminremains, 150)
	twominremains = CreateTimer("twominremains")
	SetTimerValue(twominremains, 210)
	oneminremains = CreateTimer("oneminremains")
	SetTimerValue(oneminremains, 270)
	thirtysecremains = CreateTimer("thirtysecremains")
	SetTimerValue(thirtysecremains, 300)
	tensecremains = CreateTimer("tensecremains")
	SetTimerValue(tensecremains, 320)
	StartTimer(missiontimer)
	StartTimer(fiveminremains)
	StartTimer(fourminremains)
	StartTimer(threeminremains)
	StartTimer(twominremains)
	StartTimer(oneminremains)
	StartTimer(thirtysecremains)
	StartTimer(tensecremains)
	ShowTimer(missiontimer)
	Objective1 =
		Objective:New {
		teamATT = 1,
		teamDEF = 2,
		popupText = "level.nab2g_d.objectives.detail",
		text = "level.nab2g_d.objectives.1"
	}

	Objective1.OnStart =
		function(self)
		Objective1GunganKill =
			OnObjectKill(
			function(object)
				if GetObjectTeam(object) == DEF then
					gungan_count = GetReinforcementCount(DEF) - 1
					if gungan_count == 20 then
						ShowMessageText("level.nab2g_d.objectives.2")
					end
					if gungan_count == 15 then
						ShowMessageText("level.nab2g_d.objectives.3")
					end
					if gungan_count == 10 then
						ShowMessageText("level.nab2g_d.objectives.4")
					end
					if gungan_count == 5 then
						ShowMessageText("level.nab2g_d.objectives.5")
					end
					if gungan_count == 3 then
						ShowMessageText("level.nab2g_d.objectives.6")
					end
					if gungan_count == 2 then
						ShowMessageText("level.nab2g_d.objectives.7")
					end
					if gungan_count == 1 then
						ShowMessageText("level.nab2g_d.objectives.8")
					end
					if gungan_count == 0 then
						Objective1:Complete(ATT)
						ShowMessageText("level.nab2g_d.objectives.9")
						ReleaseObjectKill(Objective1GunganKill)
					end
				end
			end
		)
	end

	OnTimerElapse(
		function()
			--ScriptCB_RestartMission()
			MissionVictory(DEF)
		end,
		"missiontimer"
	)

	OnTimerElapse(
		function()
			ShowMessageText("level.common.time.5min")
		end,
		"fiveminremains"
	)

	OnTimerElapse(
		function()
			ShowMessageText("level.common.time.4min")
		end,
		"fourminremains"
	)

	OnTimerElapse(
		function()
			ShowMessageText("level.common.time.3min")
		end,
		"threeminremains"
	)

	OnTimerElapse(
		function()
			ShowMessageText("level.common.time.2min")
		end,
		"twominremains"
	)

	OnTimerElapse(
		function()
			ShowMessageText("level.common.time.1min")
		end,
		"oneminremains"
	)

	OnTimerElapse(
		function()
			ShowMessageText("level.common.time.30sec")
		end,
		"thirtysecremains"
	)

	OnTimerElapse(
		function()
			ShowMessageText("level.common.time.10sec")
		end,
		"tensecremains"
	)

    --------- 'aggressive' code from anthony 
    AllowAISpawn(1, false)
    AllowAISpawn(2, false)
    
    OnCharacterSpawn(
        function(character, team)
            if IsCharacterHuman(character) and GetCharacterTeam(character) == 1 then
                AllowAISpawn(2, true)
                AddAIGoal(2, "Destroy", 1000, 0)
            elseif GetCharacterTeam(character) == 2 then
                AllowAISpawn(1, true)
                AddAIGoal(1, "Destroy", 1000, 0)
            end
        end
    )
    
    OnCharacterDeath(
        function(character)
            if IsCharacterHuman(character) then
                ClearAIGoals(2)
                ClearAIGoals(1)
            end
        end
    )
    ------------------
	objectiveSequence = MultiObjectiveContainer:New({})
	objectiveSequence:AddObjectiveSet(Objective1)
	objectiveSequence:Start()

	
	--SetClassProperty("imp_hero_bobafett", "WeaponName1", "imp_weap_inf_arccaster")
	--SetClassProperty("imp_hero_bobafett", "WeaponAmmo1", 5)
	--SetClassProperty("imp_hero_bobafett", "WeaponName1", "imp_weap_inf_rifle")
	--SetClassProperty("imp_hero_bobafett", "WeaponName1", "imp_weap_award_rifle")
	--SetClassProperty("imp_hero_bobafett", "WeaponAmmo1", 5)
	--SetClassProperty("imp_hero_bobafett", "WeaponName5", "imp_weap_award_rifle")
	--SetClassProperty("imp_hero_bobafett", "WeaponAmmo5", 5)
	--SetClassProperty("imp_hero_bobafett", "WeaponName2", "imp_weap_inf_arccaster")
	--SetClassProperty("imp_hero_bobafett", "WeaponAmmo2", 6)	
end

function ScriptInit()
	if ScriptCB_GetPlatform() == "PSP" then
		SetPSPModelMemory(1395277)
		SetPSPClipper(1)
	else
		SetPS2ModelMemory(2097152 + 65536 * 10)
	end
	ReadDataFile("ingame.lvl")
	ReadDataFile("sound\\nab.lvl;nab2gcw")
	ReadDataFile("SIDE\\mcm_fixes.lvl", "mcm_fixes")
	ReadDataFile("SIDE\\imp.lvl", "imp_inf_rifleman", "imp_inf_dark_trooper", "imp_inf_sniper")
	ReadDataFile("SIDE\\gun.lvl", "gun_inf_defender", "gun_inf_soldier")
	ReadDataFile("SIDE\\imp_128.lvl", "imp_hero_bobafett")
	ReadDataFile("SIDE\\imp.lvl", "imp_hero_bobafett") --for higher res textures
	if ScriptCB_GetPlatform() == "PSP" then
		SetupTeams(
			{
				imp = {
					team = IMP,
					units = 4,
					reinforcements = -1,
					sniper = {"imp_inf_sniper", 4}
				},
				all = {
					team = ALL,
					units = 25,
					reinforcements = 25,
					soldier = {"gun_inf_defender", 12},
					assault = {"gun_inf_soldier", 13}
				}
			}
		)
	else
		SetupTeams(
			{
				imp = {
					team = IMP,
					units = 4,
					reinforcements = -1,
					sniper = {"imp_inf_sniper", 4}
				},
				all = {
					team = ALL,
					units = 25,
					reinforcements = 25,
					soldier = {"gun_inf_defender", 12},
					assault = {"gun_inf_soldier", 13}
				}
			}
		)
	end
	ForceHumansOntoTeam1()
	SetTeamName(1, "Empire")
	SetTeamName(2, "Gungan")
	SetAIDifficulty(2, -5, "medium")
	AddAIGoal(1, "Deathmatch", 1000)
	AddAIGoal(2, "Deathmatch", 1000)
	SetHeroClass(ALL, "all_hero_leia")
	SetHeroClass(IMP, "imp_hero_bobafett")
	ClearWalkers()
	AddWalkerType(1, 0)
	SetMemoryPoolSize("EntityHover", 4)
	SetMemoryPoolSize("MountedTurret", 16)
	SetMemoryPoolSize("PathNode", 300)
	SetMemoryPoolSize("PassengerSlot", 0)
	SetMemoryPoolSize("TreeGridStack", 400)
	SetMemoryPoolSize("Ordnance", 50)
	SetMemoryPoolSize("ParticleEmitter", 300)
	SetMemoryPoolSize("ParticleEmitterObject", 128)
	SetMemoryPoolSize("ParticleEmitterInfoData", 512)
	SetMemoryPoolSize("Obstacle", 450)
	SetSpawnDelay(3, 0.25)
	
	--ReadDataFile("NAB\\nab2.lvl", "naboo2_Sniper")
	ReadDataFile("NAB\\nab2dlc.lvl", "naboo2_eli")
	
	SetDenseEnvironment("true")
	AddDeathRegion("Water")
	AddDeathRegion("Waterfall")
	SetNumBirdTypes(1)
	SetBirdType(0, 1, "bird")
	SetBirdFlockMinHeight(-28)
	OpenAudioStream("sound\\global.lvl", "gcw_music")
	SetAmbientMusic(ALL, 1, "all_nab_amb_start", 0, 1)
	SetAmbientMusic(IMP, 1, "imp_nab_amb_start", 0, 1)
	SetVictoryMusic(ALL, "all_nab_amb_victory")
	SetDefeatMusic(ALL, "all_nab_amb_defeat")
	SetVictoryMusic(IMP, "imp_nab_amb_victory")
	SetDefeatMusic(IMP, "imp_nab_amb_defeat")
	SetSoundEffect("ScopeDisplayZoomIn", "binocularzoomin")
	SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
	SetSoundEffect("SpawnDisplayUnitChange", "shell_select_unit")
	SetSoundEffect("SpawnDisplayUnitAccept", "shell_menu_enter")
	SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
	SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
	SetSoundEffect("SpawnDisplayBack", "shell_menu_exit")
    --  Camera Stats
    --Nab2 Theed
    --Palace
    AddCameraShot(0.038177, -0.005598, -0.988683, -0.144973, -0.985535, 18.617458, -123.316505);
    AddCameraShot(0.993106, -0.109389, 0.041873, 0.004612, 6.576932, 24.040697, -25.576218);
    AddCameraShot(0.851509, -0.170480, 0.486202, 0.097342, 158.767715, 22.913860, -0.438658);
    AddCameraShot(0.957371, -0.129655, -0.255793, -0.034641, 136.933548, 20.207420, 99.608246);
    AddCameraShot(0.930364, -0.206197, 0.295979, 0.065598, 102.191856, 22.665434, 92.389435);
    AddCameraShot(0.997665, -0.068271, 0.002086, 0.000143, 88.042351, 13.869274, 93.643898);
    AddCameraShot(0.968900, -0.100622, 0.224862, 0.023352, 4.245263, 13.869274, 97.208542);
    AddCameraShot(0.007091, -0.000363, -0.998669, -0.051089, -1.309990, 16.247049, 15.925866);
    AddCameraShot(-0.274816, 0.042768, -0.949121, -0.147705, -55.505108, 25.990822, 86.987534);
    AddCameraShot(0.859651, -0.229225, 0.441156, 0.117634, -62.493008, 31.040747, 117.995369);
    AddCameraShot(0.703838, -0.055939, 0.705928, 0.056106, -120.401054, 23.573559, -15.484946);
    AddCameraShot(0.835474, -0.181318, -0.506954, -0.110021, -166.314774, 27.687098, -6.715797);
    AddCameraShot(0.327573, -0.024828, -0.941798, -0.071382, -109.700180, 15.415476, -84.413605);
    AddCameraShot(-0.400505, 0.030208, -0.913203, -0.068878, 82.372711, 15.415476, -42.439548);
end
