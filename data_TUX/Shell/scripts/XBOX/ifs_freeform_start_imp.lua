-- start IMP campaign

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
function ifs_freeform_start_imp(this)

	-- save scenario type
	this.scenario = "imp"
	
	-- assigned teams
	local ALL = 1
	local IMP = 2
	
	-- GCW init
	ifs_freeform_init_gcw(this, ALL, IMP)
	
	-- set to co-op play
	ifs_freeform_controllers(this, { [0] = IMP, [1] = IMP, [2] = IMP, [3] = IMP })

	-- IMP start
	this.Start = function(this)
		-- perform common start
		ifs_freeform_start_common(this)

	   	-- set team for each planet
   		this.planetTeam = {
			["cor"] = IMP,
			["dag"] = ALL,
			["end"] = IMP,
			["fel"] = ALL,
			["hot"] = ALL,
			["kas"] = ALL,
			["mus"] = IMP,
			["myg"] = ALL,
			["nab"] = ALL,
			["pol"] = ALL,
			["tat"] = ALL,
			["uta"] = ALL,
			["yav"] = ALL,
			--restored
			["dea"] = IMP,
			["kam"] = IMP,       
			["geo"] = ALL,
			--new
			["tan"] = ALL,
			["kor"] = IMP,
			["bes"] = ALL,
			["rhn"] = ALL,
			["sal"] = ALL,			
			--dlc
			--["cat"] = IMP,
			--["umb"] = ALL,
			--["rax"] = ALL,
			--["star11"] = ALL,
			--["star19"] = IMP,				
		}
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "cat1%s_%s") ~= nil) then --cato
			this.planetTeam["cat"] = IMP			
		end --these mission files are added by the DLCs, and if they in the table, then we assign the planet to the map	
		--if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "025%s_%s") ~= nil) then --umbara
		--	this.planetTeam["umb"] = ALL			
		--end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "rax019%s_%s") ~= nil) then --raxus prime
			this.planetTeam["rax"] = IMP			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "sul1%s_%s") ~= nil) then --sullust
			this.planetTeam["star06"] = ALL			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ARV%s_%s") ~= nil) then --arvala 7
			this.planetTeam["star11"] = ALL			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "thu1%s_%s") ~= nil) then --thule
			this.planetTeam["star14"] = IMP			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "boz1%s_%s") ~= nil) then --boz pity
			this.planetTeam["star15"] = ALL			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ord1%s_%s") ~= nil) then --ord mantell
			this.planetTeam["star17"] = ALL			
		end
		if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "AMA%s_%s") ~= nil) then --amador
			this.planetTeam["star19"] = ALL			
		end		
		
		-- create starting fleets for each team
		this.planetFleet = {}
		for team, start in pairs(this.planetStart) do
			local planet = start[math.random(table.getn(start))]
			this.planetFleet[planet] = team
		end
	end
end
