-- initialize for Reconquest of the Rim
ifs_freeform_init_ror = function(this, IMP, CIS)

	-- common init
	ifs_freeform_init_common(this)

	-- default victory condition (take all planets)
	this:SetVictoryPlanetLimit(nil)
	
	-- associate codes with teams
	this.teamCode = {
		[CIS] = "cis",
		[IMP] = "imp"
	}
	
	-- use RoR setup
	this.Setup = function(this)
		-- remove unused planets
		--DeleteEntity("geo")
		--DeleteEntity("kam")
		--DeleteEntity("kam_system")
		--DeleteEntity("geo_system")
		--DeleteEntity("end_star")
		--DeleteEntity("hot_star")
		DeleteEntity("tantive")
					
		-- create the connectivity graph
		this.planetDestination = {
			["cor"] = { "star20", "myg", "star19" },
			["dag"] = { "star05", "star06", "nab" },
			--["end"] = { "star20", "star19" },
			--["fel"] = { "star13", "yav", "star14", "rhn" },
			["geo"] = { "star07", "star09"},
			--["hot"] = { "star02", "star03" },
			["kas"] = { "star12", "star13", "star15", "umb" },
			["kam"] = { "star12", "star13", "tat" },
			["mus"] = { "star02", "star04", "star05" },
			["myg"] = { "star17", "cor", "dea", "star16" },
			["nab"] = { "star07", "star12", "cat", "dag" },
			["pol"] = { "star04", "star02", "bes" },
			["tat"] = { "kam", "star09", "tan" },
			["uta"] = { "star04", "star05", "star06" },
			["yav"] = { "star14", "star16", "kor"},
			--["star01"] = { "end", "star02", "hot" },
			["star02"] = { "mus", "star20", "pol", "bes" },
			--["star03"] = { "hot", "bes" },
			["star04"] = { "mus", "pol", "uta" },
			["star05"] = { "mus", "uta", "dag" },
			["star06"] = { "uta", "dag", "star07" },
			["star07"] = { "nab", "geo", "star06" },
			["star08"] = { "star06", "geo" },
			["star09"] = { "tat", "geo" },
			["dea"] = { "myg", "star19" }, --death star CIS
			["star11"] = { "tan", "sal" }, --arvala REP for DLC
			["star12"] = { "kam", "nab", "kas" },
			["star13"] = { "kas", "kam", "star14" },
			["star14"] = { "star13", "kor", "rax", "sal", "rhn" },
			["star15"] = { "kas", "rhn", "star16" },
			["star16"] = { "yav", "myg", "star15" },
			["star17"] = { "star20", "myg", "umb", "cat" },
			--["star18"] = { "cor", "star19" },
			["star19"] = { "dea", "cor" }, --amador REP for DLC
			["star20"] = { "star02", "cor", "star17" },
			["sal"] = { "rax", "star11", "star14" }, --saleucami CIS done
			["kor"] = { "star14", "yav" }, --korriban CIS done
			["tan"] = { "tat", "star11" }, --tantive REP/CIS done
			["cat"] = { "star17", "nab" }, --cato CIS done
			["rax"] = { "star14", "sal" }, --Raxus Prime CIS for DLC done
			["bes"] = { "star02", "pol" }, --bespin REP done
			["rhn"] = { "star14", "star15" }, --rhen var REP
			["umb"] = { "kas", "star17" }, --Umbara CIS for DLC done	
		}

		-- resource value for each planet
		this.planetValue = {
			["cor"] = { victory = 100, defeat = 35, turn = 10 },
			["dag"] = { victory = 60, defeat = 20, turn = 3 },
			["end"] = { victory = 50, defeat = 20, turn = 3 },
			["fel"] = { victory = 50, defeat = 20, turn = 3 },
			["hot"] = { victory = 50, defeat = 20, turn = 3 },
			["kas"] = { victory = 50, defeat = 20, turn = 3 },
			["mus"] = { victory = 60, defeat = 20, turn = 3 },
			["myg"] = { victory = 50, defeat = 20, turn = 3 },
			["nab"] = { victory = 50, defeat = 20, turn = 3 },
			["pol"] = { victory = 50, defeat = 20, turn = 3 },
			["tat"] = { victory = 50, defeat = 20, turn = 3 },
			["uta"] = { victory = 50, defeat = 20, turn = 3 },
			["yav"] = { victory = 60, defeat = 20, turn = 3 },
			--below are restored entities
			["dea"] = { victory = 40, defeat = 20, turn = 3 },  
			["kam"] = { victory = 50, defeat = 20, turn = 3 },
			["geo"] = { victory = 50, defeat = 20, turn = 3 }, 
			--new galaxy entities below
			["bes"] = { victory = 50, defeat = 20, turn = 3 },
            ["sal"] = { victory = 100, defeat = 35, turn = 10 },
			["tan"] = { victory = 30, defeat = 10, turn = 3 }, 
			["kor"] = { victory = 30, defeat = 10, turn = 3 },
			["rhn"] = { victory = 50, defeat = 20, turn = 3 },	
			--for DLC or later
			["cat"] = { victory = 60, defeat = 20, turn = 4 },
			["umb"] = { victory = 60, defeat = 20, turn = 3 },
			["rax"] = { victory = 40, defeat = 10, turn = 3 },
			["star06"] = { victory = 50, defeat = 20, turn = 3 }, --Sullust
			["star11"] = { victory = 30, defeat = 10, turn = 3 }, --Arvala 7
			["star14"] = { victory = 50, defeat = 20, turn = 3 }, --Thule
			["star15"] = { victory = 40, defeat = 20, turn = 3 }, --Boz Pity
			["star17"] = { victory = 50, defeat = 20, turn = 3 }, --Ord Mantell
			["star19"] = { victory = 30, defeat = 10, turn = 3 }, --Amador			
		}
		
		this.spaceValue = {
			victory = 30, defeat = 10,
		}
		
		-- mission to launch for each planet
		this.spaceMission = {
			["con"] = "spa3r_ass" --space kashyyyk assault derivative
			--["con"] = "spa4g_ass" --space mustafar assault
		}
		this.planetMission = {
			["cor"] = {
				["con"] = "cor1r_con",
			},
			["dag"] = {
				["con"] = "dag1r_con",
			},
			["end"] = {
				["con"] = "end1r_con",
			},
			["fel"] = {
				["con"] = "fel1r_con",
			},
			["hot"] = {
				["con"] = "hot1r_con",
			},
			["kas"] = {
				--["con"] = "kas2r_con",
				["con"] = { "kas2r_con", "kas3r_con", "kas1r_con" },
			},
			["mus"] = {
				["con"] = "mus1r_con", --works as is
			},
			["myg"] = {
				["con"] = "myg1r_con", --works as is
			},
			["nab"] = {
				["con"] = "nab2r_con",
			},
			["pol"] = {
				["con"] = "pol1r_con",
			},
			["tat"] = {
				["con"] = { "tat3r_con", "tat2r_con" },
			},
			["uta"] = {
				["con"] = "uta1r_con",
			},
			["yav"] = {
				["con"] = "yav1r_con",
			},
			--below are restored maps
			["dea"] = {
				["con"] = "dea1r_con",
			},     
			["kam"] = {
				["con"] = { "kam1r_con", "kam2r_con" }, --cross era
			},
			["geo"] = {
				["con"] = "geo1r_con",
			}, 			
			--new maps
			["bes"] = {
				["con"] = "bes2r_con",
			},     
			["sal"] = {
				["con"] = "sal1r_con", --works as is
			},
			["tan"] = {
				["con"] = "tan1r_con",
			}, 
			["kor"] = {
				["con"] = "kor1r_con",
			},
			["rhn"] = {
				["con"] = "rhn2r_con", --works as is
			}, 	
			--DLC Maps
			["cat"] = {
				["con"] = "cat1r_con",
			},
			["umb"] = {
				["con"] = "025r_con",
			},
			["rax"] = {
				["con"] = "rax019r_con",
			},
			["star06"] = {
				["con"] = "sul1r_con",
			},
			["star11"] = {
				["con"] = "ARVr_con",
			},
			["star14"] = {
				["con"] = "thu1r_con",
			},
			["star15"] = {
				["con"] = "boz1r_con",
			},
			["star17"] = {
				["con"] = "ord1r_con",
			},
			["star19"] = {
				["con"] = "AMAr_con",
			},			
		}
		
		-- associate names with teams
		this.teamName = {
			[0] = "",
			[CIS] = "common.sides.cis.name",
			[IMP] = "common.sides.imp.name"
		}
		
		-- associate names with team bases
		this.baseName = {
			[CIS] = "ifs.freeform.base.cis",
			[IMP] = "ifs.freeform.base.imp"
		}
		
		-- associate names with team fleets
		this.fleetName = {
			[0] = "",
			[CIS] = "ifs.freeform.fleet.cis",
			[IMP] = "ifs.freeform.fleet.imp"
		}
		
		-- associate entity class with team fleets
		this.fleetClass = {
			[CIS] = "gal_prp_fedcruiser",
			[IMP] = "gal_prp_stardestroyer"
		}
		
		-- associate icon textures with team fleets
		this.fleetIcon = {
			[CIS] = "cis_fleet_normal_icon",
			[IMP] = "imp_fleet_normal_icon"
		}
		this.fleetStroke = {
			[CIS] = "cis_fleet_normal_stroke",
			[IMP] = "imp_fleet_normal_stroke"
		}
		
		-- set the explosion effect for each team
		this.fleetExplosion = {
			[CIS] = "gal_sfx_fedcruiser_exp",
			[IMP] = "gal_sfx_stardestroyer_exp"
		}
		
		-- team base planets
		this.planetBase = {
			[CIS] = "sal",
			[IMP] = "cor"
		}
		
		-- team potential starting locations
		this.planetStart = {
			[CIS] = { "sal", "uta", "kor" },
			[IMP] = { "dea", "cor", "nab" }
		}
	end
end
