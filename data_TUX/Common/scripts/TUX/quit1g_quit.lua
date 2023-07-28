--this is a 'hack' script to use postload on a mission script in order
--to quit the playlist of the mini campaign missions
ScriptCB_DoFile("setup_teams")
REP = 1
IMP = 2
ATT = 1
DEF = 2

function ScriptPostLoad()
	--quit to shell
	ScriptCB_ClearMetagameState()
	ScriptCB_ClearCampaignState()
	ScriptCB_ClearMissionSetup()
	ScriptCB_QuitToShell()
	-- reset everything (like quit)
end
--these functions contain pretty much the bare minimum to not crash the mission state 
--before escaping to shell state in ScriptPostLoad()
function ScriptInit()
    if ScriptCB_GetPlatform() == "PSP" then
        SetPSPModelMemory(1616077)
        SetPSPClipper(0)
    else
        SetPS2ModelMemory(2497152 + 65536 * 0)
    end
    ReadDataFile("ingame.lvl")
    ReadDataFile("SIDE\\imp.lvl", "imp_inf_rifleman")
    ClearWalkers()
    SetMemoryPoolSize("EntityDroid", 10)
    SetMemoryPoolSize("Obstacle", 118)
    SetMemoryPoolSize("Weapon", 260)
    SetTeamName(REP, "Republic")
    AddUnitClass(REP, "imp_inf_rifleman", 1)
    SetTeamName(IMP, "IMP")
    AddUnitClass(IMP, "imp_inf_rifleman", 1)
    SetUnitCount(ATT, 1)
    SetReinforcementCount(ATT, -1)
    SetUnitCount(DEF, 1)
    SetReinforcementCount(DEF, -1)
    SetSpawnDelay(10, 0.25)
end