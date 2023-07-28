--Versus Mode Galactic Conquest
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
function ifs_freeform_start_custom(this, prefs)

	-- save scenario type
	this.scenario = "custom"
	
	-- custom init
	ifs_freeform_init_custom(this, prefs)
	
	-- set to versus play
	ifs_freeform_controllers(this, { [0] = 1, [1] = 2, [2] = 1, [3] = 2 })

	this.Start = function(this)
		-- perform common start
		ifs_freeform_start_common(this)

		-- apply layout
		if prefs.bRandomLayout then
			-- assign forced planets
			this.planetTeam = {}
			for team, start in pairs(this.planetStart) do
				for _, planet in ipairs(start) do
					this.planetTeam[planet] = team
				end
			end
		
			-- get remaining planets
			local planetList = {}
			for planet, _ in pairs(this.planetDestination) do
				if string.len(planet) == 3 and not this.planetTeam[planet] then
					if planet ~= "cat" and planet ~= "umb" and planet ~= "rax"  then
						--exclude umbara, cato, and raxus in case they aren't present
						table.insert(planetList, planet)
					end
				end
			end
			--add the stars we've hijacked as planets (they are greater than 3 chars in length, loop doesn't like)
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "cat1%s_%s") ~= nil) then --cato
				table.insert(planetList, "cat")			
			end --these mission files are added by the DLCs, and if they in the table, then we assign the planet to the map	
			--if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "025%s_%s") ~= nil) then --umbara
			--	table.insert(planetList, "umb")		
			--end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "rax019%s_%s") ~= nil) then --raxus prime
				table.insert(planetList, "rax")			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "sul1%s_%s") ~= nil) then --sullust
				table.insert(planetList, "star06")			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ARV%s_%s") ~= nil) then --arvala 7
				table.insert(planetList, "star11")		
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "thu1%s_%s") ~= nil) then --thule
				table.insert(planetList, "star14")			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "boz1%s_%s") ~= nil) then --boz pity
				table.insert(planetList, "star15")		
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ord1%s_%s") ~= nil) then --ord mantell
				table.insert(planetList, "star17")		
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "AMA%s_%s") ~= nil) then --amador
				table.insert(planetList, "star19")		
			end	
            --add the stars we've hijacked as planets (they are greater than 3 chars in length, loop doesn't like)
			--table.insert(planetList, "star17")
			--table.insert(planetList, "star06")
            --table.insert(planetList, "star11")
            --table.insert(planetList, "star14")
           -- table.insert(planetList, "star15")
            --table.insert(planetList, "star19")
			-- permute the list
			local n = table.getn(planetList)
			for i=1,100 do
				local p1 = math.random(n)
				local p2 = math.random(n)
				local t = planetList[p1]
				planetList[p1] = planetList[p2]
				planetList[p2] = t
			end
			
			-- assign planet teams
			for i=1,n do
				this.planetTeam[planetList[i]] = math.ceil(i * 2 / n)
			end
		elseif prefs.iEra == 1 then
			-- set team for each planet, CW, REP = 1, CIS = 2
			this.planetTeam = {
				["cor"] = 1,
				["dag"] = 1,
				["fel"] = 2,
				["geo"] = 2,
				["kam"] = 1,
				["kas"] = 1,
				["mus"] = 2,
				["myg"] = 2,
				["nab"] = 1,
				["pol"] = 1,
				["tat"] = 1,
				["uta"] = 2,
				["yav"] = 2,
				--restored
				["dea"] = 2,
				["hot"] = 2,
				["end"] = 1,			
				--new
				["sal"] = 2,
				["kor"] = 2,
				["bes"] = 1,
				["rhn"] = 1,
				["tan"] = 1,			
				--dlc
				--["cat"] = CIS,
				--["umb"] = REP,
				--["rax"] = CIS,
				--["star11"] = REP,
				--["star19"] = REP,				
   			}
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "cat1%s_%s") ~= nil) then --cato
				this.planetTeam["cat"] = 2			
			end --these mission files are added by the DLCs, and if they in the table, then we assign the planet to the map	
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "025%s_%s") ~= nil) then --umbara
				this.planetTeam["umb"] = 2			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "rax019%s_%s") ~= nil) then --raxus prime
				this.planetTeam["rax"] = 2			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "sul1%s_%s") ~= nil) then --sullust
				this.planetTeam["star06"] = 1			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ARV%s_%s") ~= nil) then --arvala 7
				this.planetTeam["star11"] = 1			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "thu1%s_%s") ~= nil) then --thule
				this.planetTeam["star14"] = 2			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "boz1%s_%s") ~= nil) then --boz pity
				this.planetTeam["star15"] = 2			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ord1%s_%s") ~= nil) then --ord mantell
				this.planetTeam["star17"] = 1			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "AMA%s_%s") ~= nil) then --amador
				this.planetTeam["star19"] = 1			
			end			
		elseif prefs.iEra == 2 then
	   		-- set team for each planet, GCW, ALL = 1, IMP = 2
   			this.planetTeam = {
				["cor"] = 2,
				["dag"] = 1,
				["end"] = 2,
				["fel"] = 1,
				["hot"] = 1,
				["kas"] = 1,
				["mus"] = 2,
				["myg"] = 2,
				["nab"] = 1,
				["pol"] = 1,
				["tat"] = 2,
				["uta"] = 2,
				["yav"] = 1,
				--restored
				["dea"] = 2,       
                ["kam"] = 2,
				["geo"] = 1,			
				--new
				["sal"] = 2,
				["kor"] = 2,
				["bes"] = 1,
				["rhn"] = 1,
				["tan"] = 1,			
				--dlc
				--["cat"] = 2,
				--["umb"] = 1,
				--["rax"] = 1,
				--["star11"] = 2,
				--["star19"] = 2,					
			}
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "cat1%s_%s") ~= nil) then --cato
				this.planetTeam["cat"] = 2			
			end --these mission files are added by the DLCs, and if they in the table, then we assign the planet to the map	
			--if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "025%s_%s") ~= nil) then --umbara
			--	this.planetTeam["umb"] = 2			
			--end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "rax019%s_%s") ~= nil) then --raxus prime
				this.planetTeam["rax"] = 2			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "sul1%s_%s") ~= nil) then --sullust
				this.planetTeam["star06"] = 1			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ARV%s_%s") ~= nil) then --arvala 7
				this.planetTeam["star11"] = 1			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "thu1%s_%s") ~= nil) then --thule
				this.planetTeam["star14"] = 2			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "boz1%s_%s") ~= nil) then --boz pity
				this.planetTeam["star15"] = 1			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "ord1%s_%s") ~= nil) then --ord mantell
				this.planetTeam["star17"] = 2			
			end
			if ( findEntry(sp_missionselect_listbox_contents, "mapluafile", "AMA%s_%s") ~= nil) then --amador
				this.planetTeam["star19"] = 1			
			end			
		end
		
		-- create starting fleets for each team
		this.planetFleet = {}
--		for team, start in pairs(this.planetStart) do
--			local planet = start[math.random(table.getn(start))]
--			this.planetFleet[planet] = team
--		end
	end
end