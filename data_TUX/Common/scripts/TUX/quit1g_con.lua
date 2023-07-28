--this is a 'hack' script to use postload on a mission script in order
--to quit the playlist of the mini campaign missions
ScriptCB_DoFile("setup_teams")
ScriptCB_DoFile("ObjectiveTDM")
ScriptCB_DoFile("Ambush")
REP = 1
IMP = 2
locals = 3
ATT = 1
DEF = 2

function ScriptPostLoad()
	--quit to shell
	ScriptCB_ClearMetagameState()
	ScriptCB_ClearCampaignState()
	ScriptCB_ClearMissionSetup()
	ScriptCB_QuitToShell()
	-- reset everything (like quit)
		--ScriptCB_ClearMetagameState()
		--ScriptCB_ClearCampaignState()
		--ScriptCB_ClearMissionSetup();
		--SetState("shell")	
end

function ScriptInit()
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(1616077)
        SetPSPClipper(0)
    else
        SetPS2ModelMemory(2497152 + 65536 * 0)
    end
    ReadDataFile("ingame.lvl")
    ReadDataFile("sound\\dag.lvl;dag1gcw")
    SetMaxFlyHeight(20)
    SetMaxPlayerFlyHeight(20)
    ReadDataFile("SIDE\\rep.lvl", "rep_inf_ep2_jettrooper_rifleman")
    ReadDataFile("SIDE\\imp.lvl", "imp_inf_rifleman")
    ClearWalkers()
    AddWalkerType(0, 4)
    SetMemoryPoolSize("EntityHover", 0)
    SetMemoryPoolSize("EntityFlyer", 0)
    SetMemoryPoolSize("EntityDroid", 10)
    SetMemoryPoolSize("EntityCarrier", 0)
    SetMemoryPoolSize("Obstacle", 118)
    SetMemoryPoolSize("Weapon", 260)
    SetTeamName(REP, "Republic")
    SetTeamIcon(REP, "rep_icon")
    AddUnitClass(REP, "rep_inf_ep2_jettrooper_rifleman", 1)
    SetTeamName(IMP, "IMP")
    SetTeamIcon(IMP, "IMP_icon")
    AddUnitClass(IMP, "imp_inf_rifleman", 6)
    SetUnitCount(ATT, 4)
    SetReinforcementCount(ATT, -1)
    SetUnitCount(DEF, 12)
    SetReinforcementCount(DEF, -1)
    --ForceHumansOntoTeam1()
    SetTeamName(locals, "IMP")
    AddUnitClass(locals, "imp_inf_rifleman", 3)
    SetUnitCount(locals, 10)
    SetTeamAsFriend(locals, IMP)
    SetTeamAsFriend(IMP, locals)
    SetTeamAsEnemy(locals, REP)
    SetTeamAsEnemy(REP, locals)
    SetReinforcementCount(locals, 3)
    SetSpawnDelay(10, 0.25)
	
	--ReadDataFile("dag\\dag1.lvl")
    ReadDataFile("dag\\dag1mcm.lvl", "dag1_merc")
	--ReadDataFile("dag\\dag1.lvl", "dag1_1flag")
	
    SetDenseEnvironment("false")
    SetAIViewMultiplier(0.34999999403954)
    OpenAudioStream("sound\\global.lvl", "gcw_music")
    SetAmbientMusic(1, 1, "all_dag_amb_start", 0, 1)
    SetAmbientMusic(1, 0.80000001192093, "all_dag_amb_middle", 1, 1)
    SetAmbientMusic(1, 0.20000000298023, "all_dag_amb_end", 2, 1)
    SetAmbientMusic(2, 1, "imp_dag_amb_start", 0, 1)
    SetAmbientMusic(2, 0.80000001192093, "imp_dag_amb_middle", 1, 1)
    SetAmbientMusic(2, 0.20000000298023, "imp_dag_amb_end", 2, 1)
    SetVictoryMusic(1, "all_dag_amb_victory")
    SetDefeatMusic(1, "all_dag_amb_defeat")
    SetVictoryMusic(2, "imp_dag_amb_victory")
    SetDefeatMusic(2, "imp_dag_amb_defeat")
    SetSoundEffect("ScopeDisplayZoomIn", "binocularzoomin")
    SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
    SetSoundEffect("SpawnDisplayUnitChange", "shell_select_unit")
    SetSoundEffect("SpawnDisplayUnitAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
    SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
    SetSoundEffect("SpawnDisplayBack", "shell_menu_exit")
    AddCameraShot(
        -0.40489500761032,
        0.0009919999865815,
        -0.91435998678207,
        -0.0022400000598282,
        -85.539894104004,
        20.536296844482,
        141.6994934082
    )
end