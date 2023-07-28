-- start REP campaign

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
function ifs_freeform_start_rep(this)

	-- save scenario type
	this.scenario = "rep"
	
	-- assigned teams
	local REP = 1
	local CIS = 2
	
	-- CW init
	ifs_freeform_init_cw(this, REP, CIS)
	
	-- set to co-op play
	ifs_freeform_controllers(this, { [0] = REP, [1] = REP, [2] = REP, [3] = REP })

	-- REP start
	this.Start = function(this)
		-- perform common start
		ifs_freeform_start_common(this)

		-- set team for each planet
		this.planetTeam = {
			["cor"] = REP,
			["dag"] = CIS,
			["fel"] = CIS,
			["geo"] = CIS,
			["kam"] = REP,
			["kas"] = CIS,
			["mus"] = CIS,
			["myg"] = CIS,
			["nab"] = REP,
			["pol"] = CIS,
			["tat"] = CIS,
			["uta"] = CIS,
			["yav"] = CIS,
			--restored
			["dea"] = CIS,
			["hot"] = CIS,
			["end"] = REP,			
			--new
			["sal"] = CIS,
			["kor"] = CIS,
			["bes"] = REP,
			["rhn"] = REP,
			["tan"] = CIS,			
			--dlc		
			--["cat"] = CIS,
			--["umb"] = CIS,
			--["rax"] = CIS,
			--["star11"] = REP,
			--["star19"] = REP,					
   		}
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "cat1%s_%s") ~= nil) then --cato
			this.planetTeam["cat"] = CIS			
		end --these mission files are added by the DLCs, and if they in the table, then we assign the planet to the map	
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "025%s_%s") ~= nil) then --umbara
			this.planetTeam["umb"] = CIS			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "rax019%s_%s") ~= nil) then --raxus prime
			this.planetTeam["rax"] = CIS			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "sul1%s_%s") ~= nil) then --sullust
			this.planetTeam["star06"] = CIS			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ARV%s_%s") ~= nil) then --arvala 7
			this.planetTeam["star11"] = REP			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "thu1%s_%s") ~= nil) then --thule
			this.planetTeam["star14"] = CIS			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "boz1%s_%s") ~= nil) then --boz pity
			this.planetTeam["star15"] = CIS			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ord1%s_%s") ~= nil) then --ord mantell
			this.planetTeam["star17"] = REP			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "AMA%s_%s") ~= nil) then --amador
			this.planetTeam["star19"] = REP			
		end
		-- create starting fleets for each team
		this.planetFleet = {}
		for team, start in pairs(this.planetStart) do
			local planet = start[math.random(table.getn(start))]
			this.planetFleet[planet] = team
		end
	end
end
