--
-- Copyright (c) 2005 Pandemic Studios, LLC. All rights reserved.
--

ifs_freeform_rise_newload_vbutton_layout = {
--	yTop = -70,
	xWidth = 400,
	width = 400,
	xSpacing = 10,
	ySpacing = 5,
	font = gMenuButtonFont,
	bLeftJustifyButtons = 1,
	buttonlist = { 	
		--{ tag = "spacetraining", string = "ifs.sp.spacetraining", },
		{ tag = "training", string = "ifs.sp.training", },
		{ tag = "campaign", string = "ifs.sp.archive", },
		{ tag = "new", string = "ifs.meta.load.new", },
		{ tag = "load", string = "ifs.meta.load.btnload", },
	},
	title = "ifs.sp.riseempire",
--	rotY = 35,
}


ifs_freeform_rise_newload = NewIFShellScreen {
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

		-- If base class handled this work, then we're done
		if(gShellScreen_fnDefaultInputAccept(this)) then
			return
		end

		local ScreenToPush = nil
		
 		ifelm_shellscreen_fnPlaySound(this.acceptSound)
		if(this.CurButton == "new") then
			ScriptCB_ClearMetagameState()
			ScriptCB_ClearCampaignState()
			ScriptCB_ClearMissionSetup()
			ScriptCB_SetLastBattleVictoryValid(nil)
			ifs_movietrans_PushScreen(ifs_campaign_main)
		elseif (this.CurButton == "load") then
			ifs_campaign_load.Mode = "Load"
			ifs_campaign_load.SkipPromptSave = 1
			ifs_movietrans_PushScreen(ifs_campaign_load)
		elseif (this.CurButton == "training") then
			-- If training has been completed, assme they want to replay it.
			ifs_sp_fnPostAskTraining(1)
		elseif (this.CurButton == "spacetraining" ) then
			ScreenToPush = ifs_spacetraining			
		elseif (this.CurButton == "campaign") then
			ScriptCB_SetGameRules("campaign")
			ifs_sp_briefing.era = "c1"
			ScreenToPush = ifs_sp_briefing			
		end
		
		--taken from ifs_sp to let us progress screens
		if(ScreenToPush) then
			-- We can't invalidate profile on this screen - NM 7/18/05
			if(ScriptCB_IsCurProfileDirty()) then
				this.NextScreenAfterSave = ScreenToPush
				ifs_sp_StartSaveProfile()
			else
				ifs_movietrans_PushScreen(ScreenToPush)
			end
		end -- have a ScreenToPush		
	end,

}

ifs_freeform_rise_newload.CurButton = AddVerticalButtons(ifs_freeform_rise_newload.buttons,ifs_freeform_rise_newload_vbutton_layout)
AddIFScreen(ifs_freeform_rise_newload,"ifs_freeform_rise_newload")
