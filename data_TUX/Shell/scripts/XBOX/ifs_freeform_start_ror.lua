-- start balanced reconquest of the rim

--we define this to check for DLC being present
function findEntry(table, key, value)
    for i, entry in ipairs(table) do
        if entry[key] == value then
            return entry
        end
    end
    return nil
end

--the meat and potatoes
function ifs_freeform_start_ror(this)

	-- save scenario type
	this.scenario = "ror"
	
	-- assigned teams
	local IMP = 1
	local CIS = 2
	
	-- RotR init
	ifs_freeform_init_ror(this, IMP, CIS)

	-- set to versus play
	--ifs_freeform_controllers(this, { [0] = IMP, [1] = CIS, [2] = IMP, [3] = CIS })
	ifs_freeform_controllers(this, { [0] = 1, [1] = 2, [2] = 1, [3] = 2 })

	-- balanced CW start
	this.Start = function(this)
		-- perform common start
		ifs_freeform_start_common(this)

		-- set team for each planet
		this.planetTeam = {
			["cor"] = IMP,
			--["dag"] = IMP,
			--["fel"] = CIS,
			["geo"] = CIS,
			["kam"] = IMP,
			--["kas"] = IMP,
			["mus"] = CIS,
			["myg"] = CIS,
			["nab"] = IMP,
			["pol"] = IMP,
			["tat"] = IMP,
			["uta"] = IMP,
			["yav"] = CIS,
			--restored
			["dea"] = CIS, --
			--["hot"] = CIS,
			--["end"] = IMP,			
			--new
			["sal"] = CIS,
			["kor"] = CIS,
			["bes"] = IMP,
			["rhn"] = IMP,
			--["tan"] = IMP,			
			--dlc
			--["cat"] = CIS,
			--["umb"] = IMP,
			--["rax"] = CIS,
			--["star11"] = IMP,
			--["star19"] = IMP,				
   		}
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "cat1r_con") ~= nil) then --cato
			this.planetTeam["cat"] = IMP			
		end --these mission files are added by the DLCs, and if they in the table, then we assign the planet to the map	
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "sul1r_con") ~= nil) then --sullust
			this.planetTeam["star06"] = CIS			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "thu1r_con") ~= nil) then --thule
			this.planetTeam["star14"] = CIS			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "boz1r_con") ~= nil) then --boz pity
			this.planetTeam["star15"] = CIS			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ord1r_con") ~= nil) then --ord mantell
			this.planetTeam["star17"] = IMP			
		end
--		-- create starting starports for each team
--		this.planetPort = {
--			["kam"] = IMP,
--			["geo"] = CIS,
--		}
		
		-- create starting fleets for each team
		this.planetFleet = {
			["cor"] = IMP,
			["sal"] = CIS,
		}
	end
end
