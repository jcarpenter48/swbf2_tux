-- PSP ifs_minicamp_campselect.lua

-- Originally located (on PSP) at:
--     MainMenu->Singleplayer->Challenges
--     Shows a selection screen for:
--          "Imperial Enforcer"
--          "Rogue Assaaaian"
--          "Rebel Raider"
-- decompiled by cbadal 
-- verified
-- 
ifs_minicamp_campselect_vbutton_layout = {
--	yTop = -70,
	xWidth = 400,
	width = 400,
	xSpacing = 10,
	ySpacing = 5,
	font = gMenuButtonFont,
	bLeftJustifyButtons = 1,
    buttonlist = {
        { tag = "dipl", string = "ifs.sp.minicamp.dipl.title" },
        { tag = "merc", string = "ifs.sp.minicamp.merc.title" },
        { tag = "smug", string = "ifs.sp.minicamp.smug.title" }
    },
    title = "ifs.sp.minicamp.title"
}

ifs_minicamp_campselect = NewIFShellScreen {
	movieIntro      = nil, -- WAS "ifs_freeform_rise_newload_intro",
	movieBackground = "shell_sub_left", -- WAS "ifs_freeform_rise_newload",
	music           = "shell_soundtrack",
	bAcceptIsSelect = 1,

	buttons = NewIFContainer {
		ScreenRelativeX = 0.5, -- center
		ScreenRelativeY = 0.5, -- center
	},

	Enter = function(this, bFwd)
		gIFShellScreenTemplate_fnEnter(this, bFwd) -- call default enter function
		gMovieDisabled = nil
		gMovieAlwaysPlay = 1
		-- Resize menu to fit text
		ShowHideVerticalButtons(this.buttons,ifs_freeform_rise_newload_vbutton_layout)
		SetCurButton(this.CurButton)
	end,
	
	Exit = function(this, bFwd)
		if (not bFwd) then
			gMovieAlwaysPlay = nil
			ScriptCB_SetGameRules("instantaction")
		end

		gIFShellScreenTemplate_fnLeave(this, bFwd)
	end,

	Input_Accept = function(this)		
        if (gShellScreen_fnDefaultInputAccept(this)) then
            return
        end
		
        local mapTable = {} -- R1 
        --local result = -1     -- R2 
        --gPickedMapList = {}
        ifelm_shellscreen_fnPlaySound(this.acceptSound)

        if this.CurButton == "smug" then
            -- Rebel Raider; loads the 'xx_Smuggler' layer
			mapTable = {
                { Map = "myg1c_scm", Side = 1 },
                { Map = "Nab2c_scm", Side = 1 },
                { Map = "Hot1g_scm", Side = 1 },
                --{ Map = "Spa1g_scm", Side = 1 }, --sorry, I didn't feel like fixing this one
				{ Map = "quit1g_quit", Side = 1 } --hack!
            }
            --gMCMode = "smug"
            --result = ScriptCB_GetPSPMCProgress(0)
			ScriptCB_SetGameRules("instantaction") --the critical part!
			--ScriptCB_SetGameRules("campaign")
			ScriptCB_ClearMissionSetup()
			ScriptCB_SetMissionNames(mapTable, nil)
			ScriptCB_EnterMission()		
        elseif this.CurButton == "dipl" then
			-- Imperial Enforcer; loads the 'xxx_Sniper' layer 
            mapTable = {
                { Map = "Nab2g_dcm", Side = 1 },
                { Map = "Tat2g_dcm", Side = 1 },
                { Map = "End1g_dcm", Side = 1 },
                { Map = "Kas2g_dcm", Side = 1 },
				{ Map = "quit1g_quit", Side = 1 } --hack!
            }
            --gMCMode = "dipl"
            --result = ScriptCB_GetPSPMCProgress(1)
			ScriptCB_SetGameRules("instantaction")
			--ScriptCB_SetGameRules("campaign")
			ScriptCB_ClearMissionSetup()
			ScriptCB_SetMissionNames(mapTable, nil)
			ScriptCB_EnterMission()		
        elseif this.CurButton == "merc" then
            -- Rogue Assassin; loads the 'xxx_merc' layer 
			mapTable = { 
                { Map = "dag1g_mcm", Side = 1 },
				--{ Map = "tat3g_mcm", Side = 1 }, --corrupted script
                { Map = "myg1c_mcm", Side = 1 },
				{ Map = "cor1c_mcm", Side = 1 },
                { Map = "yav1g_mcm", Side = 1 },
                { Map = "Pol1c_mcm", Side = 1 },
				{ Map = "quit1g_quit", Side = 1 } --hack!
            }
            --gMCMode = "merc"
            --result = ScriptCB_GetPSPMCProgress(2)
			ScriptCB_SetGameRules("instantaction")
			--ScriptCB_SetGameRules("campaign")
			ScriptCB_ClearMissionSetup()
			ScriptCB_SetMissionNames(mapTable, nil)
			ScriptCB_EnterMission()			
        end
	
		--sadly ifs_instant_options_GetRandomizePlaylist() does not seem to work from where we are pushing ifs_minicamp_campselect, oh well
		
		--[[ this for loop looks like shit (to me), but decompiles exactly correct 
        for r4 in mapTable do 
			if  r4 + result <= table.getn(mapTable) then 
				table.insert(gPickedMapList, mapTable[r4 + result])
			end 
        end 

        if  table.getn(gPickedMapList) == 0 then 
			gPickedMapList = mapTable
		end 
		--]]--
		--ScriptCB_SetMissionNames(gPickedMapList, false)
		--ScriptCB_NewMiniCamp(1, gMCMode)
		--ScriptCB_EnterMission()		
		
		-- compare to code fron ifs_missionselect:
		--[[
		if(table.getn(gPickedMapList) > 1) then
			this.SelectedMap = 1
			ifs_missionselect_fnDeleteMap(this, 1) -- delete the "remove all entry"
			ScriptCB_SetMissionNames(gPickedMapList,ifs_instant_options_GetRandomizePlaylist())
			this.fnDone()
		else		
		--]]--
	end
}

ifs_minicamp_campselect.CurButton = 
	AddVerticalButtons(ifs_minicamp_campselect.buttons, ifs_minicamp_campselect_vbutton_layout)
AddIFScreen(ifs_minicamp_campselect, "ifs_minicamp_campselect")

--[[
    0: this
    1: mapTable
    2: result 
    3: mapTable
    4: nil 
    5: nil
    6: R(5) +R(2) = result + nil
    7: table.getn(mapTable) (4)
    8: 

]]