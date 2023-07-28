-- initialize for Galactic Civil War
ifs_freeform_init_gcw = function(this, ALL, IMP)

	-- common init
	ifs_freeform_init_common(this)

	-- default victory condition (take all planets)
	this:SetVictoryPlanetLimit(nil)
	
	-- associate codes with teams
	this.teamCode = {
		[ALL] = "all",
		[IMP] = "imp"
	}
	
	-- use GCW setup
	this.Setup = function(this)
		-- remove unused planets
		--DeleteEntity("geo")
		--DeleteEntity("kam")
		--DeleteEntity("kam_system")
		--DeleteEntity("geo_system")
		--DeleteEntity("end_star")
		--DeleteEntity("hot_star")
		--DeleteEntity("tantive")
					
		-- create the connectivity graph
		this.planetDestination = {
			["cor"] = { "star20", "myg", "star19" },
			["dag"] = { "star05", "star06", "nab" },
			["end"] = { "star20", "star19" },
			["fel"] = { "star13", "yav", "star14", "rhn" },
			["geo"] = { "star07", "tat", "star09"},
			["hot"] = { "star02", "star03" },
			["kas"] = { "star12", "star13", "star15", "umb" },
			["kam"] = { "star12", "star13", "tat" },
			["mus"] = { "star02", "star04", "star05" },
			["myg"] = { "star17", "cor", "dea", "star16" },
			["nab"] = { "star07", "star12", "cat", "dag" },
			["pol"] = { "star04", "star02", "bes" },
			["tat"] = { "geo", "kam", "star09", "tan" },
			["uta"] = { "star04", "star05", "star06" },
			["yav"] = { "fel", "star16", "kor"},
			--["star01"] = { "end", "star02", "hot" },
			["star02"] = { "mus", "star20", "pol", "hot" },
			["star03"] = { "hot", "bes" },
			["star04"] = { "mus", "pol", "uta" },
			["star05"] = { "mus", "uta", "dag" },
			["star06"] = { "uta", "dag", "star07" },
			["star07"] = { "nab", "geo", "star06" },
			["star08"] = { "star06", "geo" },
			["star09"] = { "tat", "geo" },
			["dea"] = { "myg" }, --death star CIS
			["star11"] = { "tan", "sal" }, --arvala REP for DLC
			["star12"] = { "kam", "nab", "kas" },
			["star13"] = { "kas", "kam", "fel" },
			["star14"] = { "fel", "kor", "rax", "sal" },
			["star15"] = { "kas", "rhn", "star16" },
			["star16"] = { "yav", "myg", "star15" },
			["star17"] = { "star20", "myg", "umb", "cat" },
			--["star18"] = { "cor", "star19" },
			["star19"] = { "end", "cor" }, --amador REP for DLC
			["star20"] = { "star02", "cor", "end", "star17" },
			["sal"] = { "rax", "star11", "star14" }, --saleucami CIS done
			["kor"] = { "star14", "yav" }, --korriban CIS done
			["tan"] = { "tat", "star11" }, --tantive REP/CIS done
			["cat"] = { "star17", "nab" }, --cato CIS done
			["rax"] = { "star14", "sal" }, --Raxus Prime CIS for DLC done
			["bes"] = { "star03", "pol" }, --bespin REP done
			["rhn"] = { "fel", "star15" }, --rhen var REP
			["umb"] = { "kas", "star17" }, --Umbara CIS for DLC done	
		}

		-- resource value for each planet
		this.planetValue = {
			["cor"] = { victory = 60, defeat = 20, turn = 3 },
			["dag"] = { victory = 60, defeat = 20, turn = 3 },
			["end"] = { victory = 100, defeat = 35, turn = 10 },
			["fel"] = { victory = 50, defeat = 20, turn = 3 },
			["hot"] = { victory = 100, defeat = 35, turn = 10 },
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
            ["sal"] = { victory = 50, defeat = 20, turn = 3 },
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
			["con"] = { "spa1g_ass", "spa8g_ass", "spa9g_ass" }
		}
		this.planetMission = {
			["cor"] = {
				["con"] = "cor1g_con",
				["ctf"] = "cor1g_ctf",
				--["sub"] = "cor1g_sub",
				["sgc"] = "cor1g_sgc",
			},
			["dag"] = {
				["con"] = "dag1g_con",
				["ctf"] = "dag1g_ctf",
			},
			["end"] = {
				["con"] = "end1g_con",
				["1flag"] = "end1g_1flag",
			},
			["fel"] = {
				["con"] = "fel1g_con",
				["1flag"] = "fel1g_1flag",
			},
			["hot"] = {
				["con"] = "hot1g_con",
				["1flag"] = "hot1g_1flag",
			},
			["kas"] = {
				["con"] = { "kas2g_con", "kas3g_con", "kas1g_con" },
				["ctf"] = "kas2g_ctf",
				--["sub"] = { "kas2g_sub", "kas3g_sub", "kas1g_sub" },
				["sgc"] = { "kas2g_sgc", "kas3g_sgc", "kas1g_sgc" },
			},
			["mus"] = {
				["con"] = "mus1g_con",
				["ctf"] = "mus1g_ctf",
				--["sub"] = "mus1g_sub",
				["sgc"] = "mus1g_sgc",
			},
			["myg"] = {
				["con"] = "myg1g_con",
				["ctf"] = "myg1g_ctf",
				--["sub"] = "myg1g_sub",
				["sgc"] = "myg1g_sgc",
			},
			["nab"] = {
				["con"] = { "nab2g_con", "nab1g_con" },
				["ctf"] = "nab2g_ctf",
				--["sub"] = "nab2g_sub",
				["sgc"] = "nab2g_sgc",
			},
			["pol"] = {
				["con"] = "pol1g_con",
				["ctf"] = "pol1g_ctf",
			},
			["tat"] = {
				["con"] = { "tat3g_con", "tat2g_con", "tat1g_con" },
				["1flag"] = "tat3c_1flag",
				["ctf"] = "tat2g_ctf",
			},
			["uta"] = {
				["con"] = "uta1g_con",
				["1flag"] = "uta1g_1flag",
				--["sub"] = "uta1g_sub",
				["sgc"] = "uta1g_sgc",
			},
			["yav"] = {
				["con"] = { "yav1g_con", "yav2g_con" },
				["1flag"] = "yav1g_1flag",
			},
			--below are restored maps
			["dea"] = {
				["con"] = "dea1g_con",
				["1flag"] = "dea1g_1flag",
			},     
			["kam"] = {
				["con"] = { "kam1g_con", "kam2g_con" },
				--["sub"] = { "kam1g_sub", "kam2g_sub"},
				["sgc"] = { "kam1g_sgc", "kam2g_sgc"},
				["1flag"] = "kam1g_1flag",
			},
			["geo"] = {
				["con"] = { "geo1g_con", "geo2g_con" },
			}, 			
			--new maps
			["bes"] = {
				["con"] = { "bes1g_con", "bes2g_con" },
				--["sub"] = "bes1g_sub",
				["sgc"] = "bes1g_sgc",
				["ctf"] = "bes2g_ctf",
			},     
			["sal"] = {
				["con"] = "sal1g_con",
				["ctf"] = "sal1g_ctf",
				--["sub"] = "sal1g_sub",
				["sgc"] = "sal1g_sgc",
			},
			["tan"] = {
				["con"] = "tan1g_con",
				["1flag"] = "tan1g_1flag",
			}, 
			["kor"] = {
				["con"] = "kor1g_con",
				["ctf"] = "kor1g_ctf",
			},
			["rhn"] = {
				["con"] = { "rhn1g_con", "rhn2g_con" },
				["1flag"] = { "rhn1g_1flag", "rhn2g_1flag" },
				["ctf"] = "rhn2g_ctf",
			}, 	
			--DLC Maps
			["cat"] = {
				["con"] = "cat1g_con",
			},
			["umb"] = {
				["con"] = "025g_con",
			},
			["rax"] = {
				["con"] = "rax019g_con",
			},
			["star06"] = {
				["con"] = "sul1g_con", --Sullust
			},
			["star11"] = {
				["con"] = "ARVg_con", --Arvala 7
			},
			["star14"] = {
				["con"] = "thu1g_con", --Thule
			},
			["star15"] = {
				["con"] = "boz1g_con", --Boz Pity
			},
			["star17"] = {
				["con"] = "ord1g_con", --Ord Mantell
			},
			["star19"] = {
				["con"] = "AMAg_con", --Amador
			},			
		}
		
		-- associate names with teams
		this.teamName = {
			[0] = "",
			[ALL] = "common.sides.all.name",
			[IMP] = "common.sides.imp.name"
		}
		
		-- associate names with team bases
		this.baseName = {
			[ALL] = "ifs.freeform.base.all",
			[IMP] = "ifs.freeform.base.imp"
		}
		
		-- associate names with team fleets
		this.fleetName = {
			[0] = "",
			[ALL] = "ifs.freeform.fleet.all",
			[IMP] = "ifs.freeform.fleet.imp"
		}
		
		-- associate entity class with team fleets
		this.fleetClass = {
			[ALL] = "gal_prp_moncalamaricruiser",
			[IMP] = "gal_prp_stardestroyer"
		}
		
		-- associate icon textures with team fleets
		this.fleetIcon = {
			[ALL] = "all_fleet_normal_icon",
			[IMP] = "imp_fleet_normal_icon"
		}
		this.fleetStroke = {
			[ALL] = "all_fleet_normal_stroke",
			[IMP] = "imp_fleet_normal_stroke"
		}
		
		-- set the explosion effect for each team
		this.fleetExplosion = {
			[ALL] = "gal_sfx_moncalamaricruiser_exp",
			[IMP] = "gal_sfx_stardestroyer_exp"
		}
		
		-- team base planets
		this.planetBase = {
			[ALL] = "hot",
			[IMP] = "end"
		}
		
		-- team potential starting locations
		this.planetStart = {
			[ALL] = { "hot", "yav", "dag" },
			[IMP] = { "end", "cor", "mus" }
		}
	end
end
