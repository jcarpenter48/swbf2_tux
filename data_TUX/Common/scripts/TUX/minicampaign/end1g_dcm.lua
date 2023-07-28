-- end1g_dcm.lua
-- PSP 'Imperial Enforcer' Endor mission
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("MultiObjectiveContainer")
ATT = 1
DEF = 2

function ScriptPostLoad()
    ShowAllUnitsOnMinimap(true)
    EnableSPHeroRules()
    missiontimer = CreateTimer("missiontimer")
    SetTimerValue(missiontimer, 390)
    sixminremains = CreateTimer("sixminremains")
    SetTimerValue(sixminremains, 30)
    fiveminremains = CreateTimer("fiveminremains")
    SetTimerValue(fiveminremains, 90)
    fourminremains = CreateTimer("fourminremains")
    SetTimerValue(fourminremains, 150)
    threeminremains = CreateTimer("threeminremains")
    SetTimerValue(threeminremains, 210)
    twominremains = CreateTimer("twominremains")
    SetTimerValue(twominremains, 270)
    oneminremains = CreateTimer("oneminremains")
    SetTimerValue(oneminremains, 330)
    thirtysecremains = CreateTimer("thirtysecremains")
    SetTimerValue(thirtysecremains, 360)
    tensecremains = CreateTimer("tensecremains")
    SetTimerValue(tensecremains, 380)
    StartTimer(missiontimer)
    StartTimer(sixminremains)
    StartTimer(fiveminremains)
    StartTimer(fourminremains)
    StartTimer(threeminremains)
    StartTimer(twominremains)
    StartTimer(oneminremains)
    StartTimer(thirtysecremains)
    StartTimer(tensecremains)
    ShowTimer(missiontimer)
    Objective1 =
        Objective:New(
        {
            teamATT = ATT,
            teamDEF = DEF,
            popupText = "level.end1g_d.objectives.detail",
            text = "level.end1g_d.objectives.1"
        }
    )

    Objective1.OnStart =
        function(self)
        Objective1EwokKill =
            OnObjectKill(
            function(object)
                if GetObjectTeam(object) == DEF then
                    ewok_count = GetReinforcementCount(DEF) - 1
                    if ewok_count == 40 then
                        ShowMessageText("level.end1g_d.objectives.2")
                    end
                    if ewok_count == 30 then
                        ShowMessageText("level.end1g_d.objectives.3")
                    end
                    if ewok_count == 20 then
                        ShowMessageText("level.end1g_d.objectives.4")
                    end
                    if ewok_count == 15 then
                        ShowMessageText("level.end1g_d.objectives.5")
                    end
                    if ewok_count == 10 then
                        ShowMessageText("level.end1g_d.objectives.6")
                    end
                    if ewok_count == 5 then
                        ShowMessageText("level.end1g_d.objectives.7")
                    end
                    if ewok_count == 3 then
                        ShowMessageText("level.end1g_d.objectives.8")
                    end
                    if ewok_count == 2 then
                        ShowMessageText("level.end1g_d.objectives.9")
                    end
                    if ewok_count == 1 then
                        ShowMessageText("level.end1g_d.objectives.10")
                    end
                    if ewok_count == 0 then
                        Objective1:Complete(ATT)
                        --ShowMessageText("level.end1g_d.objectives.11")
						ShowMessageText("level.spa5.objectives.campaign.3c")
                        ReleaseObjectKill(Objective1EwokKill)
                    end
                end
            end
        )
    end

    OnTimerElapse(
        function()
            MissionVictory(DEF)
        end,
        "missiontimer"
    )

    OnTimerElapse(
        function()
            ShowMessageText("level.common.time.6min")
        end,
        "sixminremains"
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

    SetProperty("CP1", "CaptureRegion", " ")
    SetProperty("CP1", "Team", "2")  
    SetProperty("CP2", "CaptureRegion", " ")
    SetProperty("CP2", "Team", "1")
    SetProperty("CP4", "CaptureRegion", " ")
    SetProperty("CP4", "Team", "2") 
    SetProperty("CP5", "CaptureRegion", " ")
    SetProperty("CP5", "Team", "1")
    SetProperty("CP6", "CaptureRegion", " ")
    SetProperty("CP6", "Team", "1")
    SetProperty("CP10", "CaptureRegion", " ")
    SetProperty("CP10", "Team", "2")
	
--hide posts
	MapHideCommandPosts(true)
	SetProperty("CP1", "MapTexture", " ")
	SetProperty("CP1", "MapScale", 0.0)
	SetProperty("CP2", "MapTexture", " ")
	SetProperty("CP2", "MapScale", 0.0)
	SetProperty("CP4", "MapTexture", " ")
	SetProperty("CP4", "MapScale", 0.0)
	SetProperty("CP5", "MapTexture", " ")
	SetProperty("CP5", "MapScale", 0.0)	
	SetProperty("CP6", "MapTexture", " ")
	SetProperty("CP6", "MapScale", 0.0)	
	SetProperty("CP10", "MapTexture", " ")
	SetProperty("CP10", "MapScale", 0.0)	
end

function ScriptInit()
    StealArtistHeap(768 * 1024)
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(1783549)
        SetPSPClipper(0)
    else
        SetPS2ModelMemory(2460000)
    end
    ReadDataFile("ingame.lvl")

    local badDudes = 1
    local ewoks = 2
    local attackers = 1
    local local4 = 2

    ReadDataFile("sound\\end.lvl;end1gcw")
    SetTeamAggressiveness(ewoks, 1)
    SetTeamAggressiveness(badDudes, 0.69999998807907)
    SetMaxFlyHeight(43)
    SetMaxPlayerFlyHeight(43)
    ReadDataFile(
        "SIDE\\imp.lvl",
        "imp_inf_sniper",
        "imp_inf_rifleman",
        "imp_inf_rocketeer",
        "imp_inf_officer",
		
        --"imp_hero_bobafett",
        "imp_hover_speederbike",
        "imp_walk_atst_jungle"
    )
	ReadDataFile("SIDE\\imp_256.lvl", "imp_inf_dark_trooper")
	ReadDataFile("SIDE\\imp_128.lvl", "imp_hero_bobafett")
	ReadDataFile("SIDE\\imp.lvl", "imp_hero_bobafett") --for higher res textures
    ReadDataFile("SIDE\\ewk.lvl", "ewk_inf_basic")
	ReadDataFile("SIDE\\mcm_fixes.lvl", "mcm_fixes")
    if ScriptCB_GetPlatform() == "PSP" then
        SetupTeams(
            {
                all = {
                    team = ewoks,
                    units = 25,
                    reinforcements = 45,
                    soldier = {"ewk_inf_trooper", 9},
                    assault = {"ewk_inf_scout", 8},
                    engineer = {"ewk_inf_repair", 8}
                },
                imp = {
                    team = badDudes,
                    units = 4,
                    reinforcements = -1,
                    soldier = {"imp_inf_rifleman", 1},
                    assault = {"imp_inf_rocketeer", 1},
                    sniper = {"imp_inf_sniper", 1},
                    officer = {"imp_inf_officer", 1}
                }
            }
        )
    else
        SetupTeams(
            {
                all = {
                    team = ewoks,
                    units = 25,
                    reinforcements = 45,
                    soldier = {"ewk_inf_trooper", 9},
                    assault = {"ewk_inf_scout", 8},
                    engineer = {"ewk_inf_repair", 8}
                },
                imp = {
                    team = badDudes,
                    units = 4,
                    reinforcements = -1,
                    soldier = {"imp_inf_rifleman", 1},
                    assault = {"imp_inf_rocketeer", 1},
                    sniper = {"imp_inf_sniper", 1},
                    officer = {"imp_inf_officer", 1}
                }
            }
        )
    end
    SetTeamName(1, "Empire")
    SetTeamName(2, "Ewoks")
    ForceHumansOntoTeam1()
    SetAIDifficulty(2, 1)
    SetHeroClass(badDudes, "imp_hero_bobafett")
    AddAIGoal(1, "Deathmatch", 1000)
    AddAIGoal(2, "Deathmatch", 1000)
    ClearWalkers()
    AddWalkerType(0, 0)
    AddWalkerType(1, 3)
    AddWalkerType(2, 0)
    AddWalkerType(3, 0)

    local weaponCnt = 165
    SetMemoryPoolSize("ActiveRegion", 4)
    SetMemoryPoolSize("Aimer", 27)
    SetMemoryPoolSize("AmmoCounter", weaponCnt)
    SetMemoryPoolSize("BaseHint", 100)
    SetMemoryPoolSize("Combo::DamageSample", 64)
    SetMemoryPoolSize("EnergyBar", weaponCnt)
    SetMemoryPoolSize("EntityCarrier", 0)
    SetMemoryPoolSize("EntityDefenseGridTurret", 4)
    SetMemoryPoolSize("EntityDroid", 2)
    SetMemoryPoolSize("EntityFlyer", 0)
    SetMemoryPoolSize("EntityHover", 9)
    SetMemoryPoolSize("EntityLight", 20)
    SetMemoryPoolSize("EntityMine", 8)
    SetMemoryPoolSize("EntityPortableTurret", 4)
    SetMemoryPoolSize("EntitySoundStatic", 95)
    SetMemoryPoolSize("EntitySoundStream", 4)
    SetMemoryPoolSize("LightFlash", 6)
    SetMemoryPoolSize("LightningBoltEffectObject", 3)
    SetMemoryPoolSize("MountedTurret", 6)
    SetMemoryPoolSize("Navigator", 39)
    SetMemoryPoolSize("Obstacle", 745)
    SetMemoryPoolSize("Ordnance", 35)
    SetMemoryPoolSize("ParticleEmitter", 350)
    SetMemoryPoolSize("ParticleEmitterObject", 144)
    SetMemoryPoolSize("ParticleEmitterInfoData", 256)
    SetMemoryPoolSize("PassengerSlot", 0)
    SetMemoryPoolSize("PathFollower", 39)
    SetMemoryPoolSize("PathNode", 100)
    SetMemoryPoolSize("PowerupItem", 14)
    SetMemoryPoolSize("RayRequest", 40)
    SetMemoryPoolSize("RedOmniLight", 9)
    SetMemoryPoolSize("ShieldEffect", 0)
    SetMemoryPoolSize("SoundSpaceRegion", 6)
    SetMemoryPoolSize("StickInfo", 20)
    SetMemoryPoolSize("TreeGridStack", 500)
    SetMemoryPoolSize("UnitAgent", 39)
    SetMemoryPoolSize("UnitController", 39)
    SetMemoryPoolSize("Weapon", weaponCnt)
    SetSpawnDelay(3, 0.25)
	
    --ReadDataFile("end\\end1.lvl", "end1_Sniper")
	ReadDataFile("end\\end1.lvl", "end1_conquest")
	
    SetDenseEnvironment("true")
    AddDeathRegion("deathregion")
    SetStayInTurrets(1)
    OpenAudioStream("sound\\global.lvl", "gcw_music")
    SetAmbientMusic(ewoks, 1, "all_end_amb_start", 0, 1)
    SetAmbientMusic(badDudes, 1, "imp_end_amb_start", 0, 1)
    SetVictoryMusic(ewoks, "all_end_amb_victory")
    SetDefeatMusic(ewoks, "all_end_amb_defeat")
    SetVictoryMusic(badDudes, "imp_end_amb_victory")
    SetDefeatMusic(badDudes, "imp_end_amb_defeat")
    SetSoundEffect("ScopeDisplayZoomIn", "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    SetSoundEffect("SpawnDisplayUnitChange", "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack", "shell_menu_exit")
    SetAttackingTeam(attackers)
	--Endor
	--Shield Bunker
	AddCameraShot(0.997654, 0.066982, 0.014139, -0.000949, 155.137131, 0.911505, -138.077072)
	--Village
	AddCameraShot(0.729761, 0.019262, 0.683194, -0.018033, -98.584869, 0.295284, 263.239288)
	--Village
	AddCameraShot(0.694277, 0.005100, 0.719671, -0.005287, -11.105947, -2.753207, 67.982201)
end
