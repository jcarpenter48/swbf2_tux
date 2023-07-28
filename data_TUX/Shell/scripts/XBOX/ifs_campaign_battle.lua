--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

ifs_campaign_battle = NewIFShellScreen {
	nologo = 1,
	movieIntro      = nil,
	movieBackground = nil,
	bNohelptext_accept = 1,
	bNohelptext_back = 1,
	bNohelptext_backPC = 1,

	Enter = function(this, bFwd)
		gIFShellScreenTemplate_fnEnter(this, bFwd) -- call default enter function
	
		if bFwd then
			ifs_campaign_main:SetZoom(2)
			
			MoveCameraToEntity(ifs_campaign_main.planetSelected .. "_camera")
			SnapMapCamera()
			
			IFObj_fnSetVis(this.title, nil)
			
			-- remove player group
			IFObj_fnSetVis(this.player, nil)
			
			IFObj_fnSetVis(this.description.caption, 1)
			--if (ifs_campaign_main.turnNumber < 12) then --hack!
				IFText_fnSetString(this.description.caption, "ifs.campaignname." .. ifs_campaign_main.turnNumber)
				IFText_fnSetString(this.info.text, "ifs.campaigndesc." .. ifs_campaign_main.turnNumber)
			--[[
			elseif (ifs_campaign_main.turnNumber == 13) then
				IFText_fnSetString(this.info.caption, "ifs.campaignname.12")
				IFText_fnSetString(this.info.text, "ifs.campaigndesc.12")
			elseif (ifs_campaign_main.turnNumber == 14) then
				IFText_fnSetString(this.info.caption, "ifs.campaignname.13")
				IFText_fnSetString(this.info.text, "ifs.campaigndesc.13")
			elseif (ifs_campaign_main.turnNumber == 15) then
				IFText_fnSetString(this.info.caption, "ifs.campaignname.14")
				IFText_fnSetString(this.info.text, "ifs.campaigndesc.14")
			elseif (ifs_campaign_main.turnNumber == 16) then
				IFText_fnSetString(this.info.caption, "ifs.campaignname.15")
				IFText_fnSetString(this.info.text, "ifs.campaigndesc.15")
			elseif (ifs_campaign_main.turnNumber == 17) then
				IFText_fnSetString(this.info.caption, "ifs.campaignname.16")
				IFText_fnSetString(this.info.text, "ifs.campaigndesc.16")
			elseif (ifs_campaign_main.turnNumber == 18) then
				IFText_fnSetString(this.info.caption, "ifs.campaignname.17")
				IFText_fnSetString(this.info.text, "ifs.campaigndesc.17")
			--elseif (ifs_campaign_main.turnNumber == 19) then
			--	IFText_fnSetString(this.info.caption, "ifs.campaignname.18")
			--	IFText_fnSetString(this.info.text, "ifs.campaigndesc.18")
			--elseif (ifs_campaign_main.turnNumber == 20) then
			--	IFText_fnSetString(this.info.caption, "ifs.campaignname.19")
			--	IFText_fnSetString(this.info.text, "ifs.campaigndesc.19")
			--]]--
			--else
				--local turnOffset = ifs_campaign_main.turnNumber - 1 --unfortunately this doesn't seem to work, hence this awfulness
			--	IFText_fnSetString(this.info.caption, "ifs.campaignname." .. (ifs_campaign_main.turnNumber - 1))
			--	IFText_fnSetString(this.info.text, "ifs.campaigndesc." .. (ifs_campaign_main.turnNumber - 1))
			--	IFText_fnSetString(this.info.caption, "ifs.campaignname.18")
			--	IFText_fnSetString(this.info.text, "ifs.campaigndesc.18")
		    --end
			
			if ifs_campaign_mission[ifs_campaign_main.turnNumber].space then
				ifs_freeform_SetButtonVis(this, "misc", true)
				ifs_freeform_SetButtonName(this, "misc", "ifs.freeform.skipspace")
			else
				ifs_freeform_SetButtonVis(this, "misc", false)
			end
			
			this.allowBack = ScriptCB_IsScreenInStack("ifs_campaign_overview")

			ifs_freeform_SetButtonVis( this, "back", this.allowBack )
			ifs_freeform_SetButtonName( this, "accept", "ifs.freeform.attack" )
			ifs_freeform_SetButtonVis(this, "help", nil)
		end
		
		-- prompt for save if necessary
		ifs_campaign_main:PromptSave()
	end,

	Exit = function(this, bFwd)
	end,

	Update = function(this, fDt)
		gIFShellScreenTemplate_fnUpdate(this, fDt) -- call base class

		-- update zoom values
		ifs_campaign_main:UpdateZoom()
	end,
	
	Input_Accept = function(this, joystick)
		if(gPlatformStr == "PC") then
			--print( "this.CurButton = ", this.CurButton )
			if( this.CurButton == "_accept" ) then
				-- purchase the item
			elseif( this.CurButton == "_back" ) then
				-- handle in Input_Back
				if this.allowBack then
					-- go back a screen
					ScriptCB_PopScreen()
				end
				return
			elseif( this.CurButton == "_next" ) then
				return
			else
				return
			end
		end		
			
 		ifelm_shellscreen_fnPlaySound(this.acceptSound)
 		
		-- get the active mission
		local mission = ifs_campaign_mission[ifs_campaign_main.turnNumber]
	
--		-- send team codes and items to the mission
--		local missionSetup = {}
--		local teamUnits = {}
--		teamUnits[mission.side] = ifs_purchase_unit_owned[1]
--		missionSetup.units = teamUnits
--		ScriptCB_SaveMissionSetup(teamUnits)
	
		-- set forced teams
		-- (ignore controller's actual team)
		for controller, team in pairs(ifs_campaign_main.controllerTeam) do
			ScriptCB_MetagameSetSide(ifs_campaign_main.controllerPlayer[controller], mission.side)
		end
		
		-- Reset difficulty to what's in profile
		ScriptCB_SetDifficulty(ScriptCB_GetDifficulty())

		-- set the mission to launch				
		ScriptCB_SetMissionNames(mission.space or mission.level, nil)
		
		-- go to the battle card screen
		ScriptCB_PushScreen("ifs_campaign_battle_card")
	end,
	
	Input_Misc = function(this, joystick)
		if ifs_campaign_mission[ifs_campaign_main.turnNumber].space then
			-- skip the mission
			ifs_campaign_main:NextTurn()
		end
		
	end, -- Input_Misc

	Input_Back = function(this, joystick)
		if this.allowBack then
			-- go back a screen
			ScriptCB_PopScreen()
		end
	end,
	
	Input_Start = function(this, joystick)
		-- open pause menu
		ScriptCB_PushScreen("ifs_campaign_menu")
	end,
}

ifs_freeform_AddCommonElements(ifs_campaign_battle)
AddIFScreen(ifs_campaign_battle,"ifs_campaign_battle")