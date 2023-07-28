--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--
-- Copyright (c) 2022 bk2modder. All rights reserved.
--
--[[ -------- Modder's Note -----------------
    Pandemic's Battlefront II Mission Scripting Guide:
        https://sites.google.com/site/swbf2modtoolsdocumentation/battlefront-ii-mission-lua-guide 
]]


--[[ -------- Modder's Note -----------------
    Alternate Addon assetLocation logic.
    See YouTube Video chapter: 
        https://www.youtube.com/watch?v=LVhKMDW22AY&t=3758s 
    https://github.com/Gametoast/AltAddonSystem
]]

-- load the gametype script
ScriptCB_DoFile("ObjectiveConquest")
ScriptCB_DoFile("setup_teams")

---------------------------------------------------------------------------
-- ScriptPostLoad
---------------------------------------------------------------------------
function ScriptPostLoad()
--skin stuff
if( ScriptCB_IsFileExist("no327endor.txt") ~= 1 ) then
    SetClassProperty("rep_inf_ep3_rifleman", "GeometryName", "rep_inf_ep3trooper327")
    SetClassProperty("rep_inf_ep3_rifleman", "ClothODF", "rep_inf_ep3sniper_cape")
    SetClassProperty("rep_inf_ep3_rifleman", "AnimatedAddon", "pauldron")
    SetClassProperty("rep_inf_ep3_rifleman", "GeometryAddon", "rep_inf_pauldron_addon") 
    SetClassProperty("rep_inf_ep3_rifleman", "AddonAttachJoint", "bone_ribcage") 
    --Change the Clone Commander's appearance for the 327th
    SetClassProperty("rep_inf_ep3_officer", "GeometryName", "rep_inf_ep3trooper327")
    SetClassProperty("rep_inf_ep3_officer", "OverrideTexture", "rep_inf_ep3jettrooper") --salient bit
    SetClassProperty("rep_inf_ep3_officer", "ClothODF", "rep_inf_ep3sniper_cape")
    SetClassProperty("rep_inf_ep3_officer", "AnimatedAddon", "pauldron")
    SetClassProperty("rep_inf_ep3_officer", "GeometryAddon", "rep_inf_pauldron_addon") 
    SetClassProperty("rep_inf_ep3_officer", "AddonAttachJoint", "bone_ribcage")   
end --allow option to switch 327th off, mainly if there is a future TC that breaks this. 
--just place a file named no327endor.txt (doesn't have to actually contain anything, just named that) to disable 327th
   
	cp1 = CommandPost:New{name = "CP1"}
	cp2 = CommandPost:New{name = "CP2"}
	cp4 = CommandPost:New{name = "CP4"}
	cp5 = CommandPost:New{name = "CP5"}
	cp6 = CommandPost:New{name = "CP6"}
	cp10 = CommandPost:New{name = "CP10"}

	--This sets up the actual objective.	This needs to happen after cp's are defined
	conquest = ObjectiveConquest:New{teamATT = ATT, teamDEF = DEF, textATT = "game.modes.con", textDEF = "game.modes.con2", multiplayerRules = true}
	
	--This adds the CPs to the objective.	This needs to happen after the objective is set up
	conquest:AddCommandPost(cp1)
	conquest:AddCommandPost(cp2)
	conquest:AddCommandPost(cp4)
	conquest:AddCommandPost(cp5)
	conquest:AddCommandPost(cp6)
	conquest:AddCommandPost(cp10)
	
	conquest:Start()

	EnableSPHeroRules()
end

---------------------------------------------------------------------------
-- ScriptInit
---------------------------------------------------------------------------
function ScriptInit()
	StealArtistHeap(1150*1024)
	
	-- Designers, these two lines *MUST* be first.
	SetPS2ModelMemory(2460000) --these values haven't been tested to work for CW on PS2

    SetMemoryPoolSize ("Combo",6)              -- should be ~ 2x number of jedi classes
    SetMemoryPoolSize ("Combo::State",160)      -- should be ~12x #Combo
    SetMemoryPoolSize ("Combo::Transition",160) -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Condition",160)  -- should be a bit bigger than #Combo::State
    SetMemoryPoolSize ("Combo::Attack",160)     -- should be ~8-12x #Combo
    SetMemoryPoolSize ("Combo::DamageSample",1800)  -- should be ~8-12x #Combo::Attack
    SetMemoryPoolSize ("Combo::Deflect",12)     -- should be ~1x #combo       -- should be ~1x #combo

	ReadDataFile("ingame.lvl")
	
	SetWorldExtents(1277.3)

	local REP = 1
	local CIS = 2
	local ATT = 1
	local DEF = 2
	
	--ReadDataFile("sound\\yav.lvl;yav1cw") --debug purposes
        ReadDataFile("sound\\endcw.lvl;end1cw") 

	SetTeamAggressiveness(REP, 1.0)
	SetTeamAggressiveness(CIS, 0.7)

	SetMaxFlyHeight(43)
	SetMaxPlayerFlyHeight(43)

    ReadDataFile("SIDE\\rep.lvl",
                             "rep_inf_ep3_rifleman",
                             "rep_inf_ep3_rocketeer",
                             "rep_inf_ep3_engineer",
                             "rep_inf_ep3_sniper",
                             "rep_inf_ep3_officer",
                             "rep_inf_ep3_jettrooper",
                             "rep_hero_aalya",
                             "rep_hover_barcspeeder",
                             "rep_walk_oneman_atst")
    ReadDataFile("SIDE\\cis.lvl",
                             "cis_inf_rifleman",
                             "cis_inf_rocketeer",
                             "cis_inf_engineer",
                             "cis_inf_sniper",
                             "cis_inf_officer",
                             "cis_hover_stap",
                             --"cis_hero_grievous",
                             "cis_inf_droideka")

	--ReadDataFile("SIDE\\imp.lvl",
	--			"imp_hover_speederbike")	--replaced these with STAPs, there's a lvl to use these though
    if( ScriptCB_IsFileExist("no327endor.txt") ~= 1 ) then    
        ReadDataFile("side\\327skin.lvl",
                "327skin")    --load 327th skins to override existing Ep3 trooper appearances
    end            
                
	ReadDataFile("SIDE\\tur.lvl",
				"tur_bldg_laser")	

	--[[ReadDataFile("SIDE\\ewk.lvl",
						"ewk_inf_basic")]]--
    ReadDataFile("side\\ewkcw.lvl",
                "ewk_inf_basic") --needed because of updated spear values to affect droids
    --custom heroes
    --ReadDataFile("..\\..\\addon\\cwendorhoth\\data\\_LVL_PC\\side\\imagundi.lvl",
    --            "rep_hero_imagundi") --Going with Aayla Secura because canonically 327th fought on Endor
    ReadDataFile("side\\sorabulq.lvl",
                "cis_hero_sorabulq")                   

	SetupTeams{
		rep = {
			team = REP,
			units = 29,
			reinforcements = 150,
			soldier	= { "rep_inf_ep3_rifleman",10, 25},
			assault	= { "rep_inf_ep3_rocketeer",1,4},
			engineer = { "rep_inf_ep3_engineer",1,4},
			sniper	= { "rep_inf_ep3_sniper",1,4},
			officer = {"rep_inf_ep3_officer",1,4},
			special = { "rep_inf_ep3_jettrooper",1,4},
		},	
		cis = {
			team = CIS,
			units = 29,
			reinforcements = 150,
			soldier	= { "cis_inf_rifleman",10, 25},
			assault	= { "cis_inf_rocketeer",1,4},
			engineer = { "cis_inf_engineer",1,4},
			sniper	= { "cis_inf_sniper",1,4},
			officer = {"cis_inf_officer",1,4},
			special = { "cis_inf_droideka",1,4},
		}
	}
	
	SetHeroClass(REP, "rep_hero_aalya")
	SetHeroClass(CIS, "cis_hero_sorabulq")

	---[[	Ewoks
	SetTeamName(3, "locals")
	AddUnitClass(3, "ewk_inf_trooper", 3)
	AddUnitClass(3, "ewk_inf_repair", 3)
	SetUnitCount(3, 6)
	
	SetTeamAsFriend(3,ATT)
	SetTeamAsEnemy(3,DEF)
	SetTeamAsFriend(ATT, 3)
	SetTeamAsEnemy(DEF, 3)
	--]]
	
	--temp until you rescript this mission
	AddAIGoal(1,"Conquest",100);
	AddAIGoal(2,"Conquest",100);
	AddAIGoal(3,"Conquest",100);
	--temp until you rescript this mission

	--	Level Stats
	ClearWalkers()
    AddWalkerType(0, 4) -- special -> droidekas
    AddWalkerType(1, 3) -- 1x2 (1 pair of legs)
    AddWalkerType(2, 0) -- 2x2 (2 pairs of legs)
    AddWalkerType(3, 0) -- 3x2 (3 pairs of legs)
	
	local weaponCnt = 240
	SetMemoryPoolSize("ActiveRegion", 4)
	SetMemoryPoolSize("Aimer", 27)
	SetMemoryPoolSize("AmmoCounter", weaponCnt)
	SetMemoryPoolSize("BaseHint", 100)
	SetMemoryPoolSize("EnergyBar", weaponCnt)
	SetMemoryPoolSize("EntityFlyer", 9) -- 3xATST + rocket upgrade
	SetMemoryPoolSize("EntityHover", 9)
	SetMemoryPoolSize("EntityLight", 23)
	SetMemoryPoolSize("EntityMine", 8)
	SetMemoryPoolSize("EntitySoundStatic", 95)
	SetMemoryPoolSize("EntitySoundStream", 4)
	SetMemoryPoolSize("MountedTurret", 6)
	SetMemoryPoolSize("Navigator", 39)
	SetMemoryPoolSize("Obstacle", 745)
	SetMemoryPoolSize("PathFollower", 39)
	SetMemoryPoolSize("PathNode", 120)
	SetMemoryPoolSize("ShieldEffect", 0)
	SetMemoryPoolSize("SoundSpaceRegion", 6)
	SetMemoryPoolSize("TentacleSimulator", 14)
	SetMemoryPoolSize("TreeGridStack", 600)
	SetMemoryPoolSize("UnitAgent", 39)
	SetMemoryPoolSize("UnitController", 39)
	SetMemoryPoolSize("Weapon", weaponCnt)
    --adjusted pools (based off BF2 PC Debug Log)
    SetMemoryPoolSize("SoldierAnimation", 400)
    --SetMemoryPoolSize("Combo::Attack", 140)
    SetMemoryPoolSize("ParticleTransformer::ColorTrans", 1700)
    SetMemoryPoolSize("Music", 35)
	
	SetSpawnDelay(10.0, 0.25)
	ReadDataFile("end\\end1.lvl", "end1_conquest")
    ReadDataFile("end\\end1cw.lvl", "end1_cwveh") 
	SetDenseEnvironment("true")
	AddDeathRegion("deathregion")
	SetStayInTurrets(1)

	--	Sound
	voiceSlow = OpenAudioStream("sound\\global.lvl", "rep_unit_vo_slow")
	AudioStreamAppendSegments("sound\\global.lvl", "cis_unit_vo_slow", voiceSlow)
	AudioStreamAppendSegments("sound\\global.lvl", "global_vo_slow", voiceSlow)
	
	voiceQuick = OpenAudioStream("sound\\global.lvl",	"rep_unit_vo_quick")
	AudioStreamAppendSegments("sound\\global.lvl",	"cis_unit_vo_quick", voiceQuick)
	
	OpenAudioStream("sound\\global.lvl",	"cw_music")
	-- OpenAudioStream("sound\\global.lvl",	"global_vo_quick")
	-- OpenAudioStream("sound\\global.lvl",	"global_vo_slow")
	OpenAudioStream("sound\\endcw.lvl",	"end1cw")
	OpenAudioStream("sound\\endcw.lvl",	"end1cw")
	OpenAudioStream("sound\\endcw.lvl",	"end1cw_emt")

	SetBleedingVoiceOver(REP, REP, "rep_off_com_report_us_overwhelmed", 1)
	SetBleedingVoiceOver(REP, CIS, "rep_off_com_report_enemy_losing",	1)
	SetBleedingVoiceOver(CIS, REP, "cis_off_com_report_enemy_losing",	1)
	SetBleedingVoiceOver(CIS, CIS, "cis_off_com_report_us_overwhelmed", 1)

	SetLowReinforcementsVoiceOver(REP, REP, "rep_off_defeat_im", .1, 1)
	SetLowReinforcementsVoiceOver(REP, CIS, "rep_off_victory_im", .1, 1)
	SetLowReinforcementsVoiceOver(CIS, CIS, "cis_off_defeat_im", .1, 1)
	SetLowReinforcementsVoiceOver(CIS, REP, "cis_off_victory_im", .1, 1)

    SetOutOfBoundsVoiceOver(CIS, "cisleaving")
    SetOutOfBoundsVoiceOver(REP, "repleaving")

	SetAmbientMusic(REP, 1.0, "rep_end_amb_start",	0,1)
	SetAmbientMusic(REP, 0.8, "rep_end_amb_middle", 1,1)
	SetAmbientMusic(REP, 0.2, "rep_end_amb_end",	2,1)
	SetAmbientMusic(CIS, 1.0, "cis_end_amb_start",	0,1)
	SetAmbientMusic(CIS, 0.8, "cis_end_amb_middle", 1,1)
	SetAmbientMusic(CIS, 0.2, "cis_end_amb_end",	2,1)

	SetVictoryMusic(REP, "rep_end_amb_victory")
	SetDefeatMusic(REP, "rep_end_amb_defeat")
	SetVictoryMusic(CIS, "cis_end_amb_victory")
	SetDefeatMusic(CIS, "cis_end_amb_defeat")

	SetSoundEffect("ScopeDisplayZoomIn",	"binocularzoomin")
	SetSoundEffect("ScopeDisplayZoomOut", "binocularzoomout")
	--	SetSoundEffect("BirdScatter",		"birdsFlySeq1")
	SetSoundEffect("SpawnDisplayUnitChange",		"shell_select_unit")
	SetSoundEffect("SpawnDisplayUnitAccept",		"shell_menu_enter")
	SetSoundEffect("SpawnDisplaySpawnPointChange", "shell_select_change")
	SetSoundEffect("SpawnDisplaySpawnPointAccept", "shell_menu_enter")
	SetSoundEffect("SpawnDisplayBack",			"shell_menu_exit")

	SetAttackingTeam(ATT)

	--Endor
	--Shield Bunker
	AddCameraShot(0.997654, 0.066982, 0.014139, -0.000949, 155.137131, 0.911505, -138.077072)
	--Village
	AddCameraShot(0.729761, 0.019262, 0.683194, -0.018033, -98.584869, 0.295284, 263.239288)
	--Village
	AddCameraShot(0.694277, 0.005100, 0.719671, -0.005287, -11.105947, -2.753207, 67.982201)
end
