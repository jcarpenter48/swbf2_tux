-- initialize for Clone Wars
ifs_freeform_init_cw = function(this, REP, CIS)
	
	-- common init
	ifs_freeform_init_common(this)

	-- default victory condition (take all planets)
	this:SetVictoryPlanetLimit(nil)
	
	-- associate codes with teams
	this.teamCode = {
		[REP] = "rep",
		[CIS] = "cis"
	}

	-- use CW setup
	this.Setup = function(this)
		-- remove unused planets
		--DeleteEntity("end")
		--DeleteEntity("hot")
		--DeleteEntity("end_system")
		--DeleteEntity("hot_system")
		--DeleteEntity("kam_star")
		--DeleteEntity("geo_star")
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
			["star06"] = { "uta", "dag", "star07" }, --SULLUST DLC CIS
			["star07"] = { "nab", "geo", "star06" },
			["star08"] = { "star06", "geo" },
			["star09"] = { "tat", "geo" },
			["dea"] = { "myg" }, --death star CIS
			["star11"] = { "tan", "sal" }, --ARVALA 7 DLC REP
			["star12"] = { "kam", "nab", "kas" },
			["star13"] = { "kas", "kam", "fel" },
			["star14"] = { "fel", "kor", "rax", "sal" }, --THULE DLC CIS
			["star15"] = { "kas", "rhn", "star16" }, --BOZ PITY DLC CIS
			["star16"] = { "yav", "myg", "star15" },
			["star17"] = { "star20", "myg", "umb", "cat" }, --ORD MANTELL DLC REP
			--["star18"] = { "cor", "star19" },
			["star19"] = { "end", "cor" }, --AMADOR DLC REP
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
			["dag"] = { victory = 50, defeat = 20, turn = 3 },
			["fel"] = { victory = 50, defeat = 20, turn = 3 },
			["geo"] = { victory = 100, defeat = 35, turn = 10 },
			["kas"] = { victory = 50, defeat = 20, turn = 3 },
			["kam"] = { victory = 100, defeat = 35, turn = 10 },
			["mus"] = { victory = 60, defeat = 20, turn = 3 },
			["myg"] = { victory = 50, defeat = 20, turn = 3 },
			["nab"] = { victory = 60, defeat = 20, turn = 3 },
			["pol"] = { victory = 50, defeat = 20, turn = 3 },
			["tat"] = { victory = 50, defeat = 20, turn = 3 },
			["uta"] = { victory = 60, defeat = 20, turn = 3 },
			["yav"] = { victory = 50, defeat = 20, turn = 3 },
			--below are restored entities
			["dea"] = { victory = 40, defeat = 20, turn = 3 },  
			["hot"] = { victory = 50, defeat = 20, turn = 3 },
			["end"] = { victory = 50, defeat = 20, turn = 3 }, 
			--new galaxy entities below
			["bes"] = { victory = 50, defeat = 20, turn = 3 },
            ["sal"] = { victory = 50, defeat = 20, turn = 3 },
			["tan"] = { victory = 20, defeat = 10, turn = 2 }, 
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

		
		-- mission(s) to launch for each planet
		this.spaceMission = {
			["con"] = { "spa3c_ass", "spa6c_ass", "spa7c_ass" }
		}
		this.planetMission = {
			["cor"] = {
				["con"] = "cor1c_con",
				["ctf"] = "cor1c_ctf",
				["sgc"] = "cor1c_sgc",
			},
			["dag"] = {
				["con"] = "dag1c_con",
				["ctf"] = "dag1c_ctf",
			},
			["fel"] = {
				["con"] = "fel1c_con",
				["1flag"] = "fel1c_1flag",
			},
			["geo"] = {
				["con"] = { "geo1c_con", "geo2c_con" },
				["ctf"] = "geo1c_ctf",
				--["sub"] = "geo1c_sub",
				["sgc"] = "geo1c_sgc",
			},
			["kam"] = {
				["con"] = { "kam1c_con", "kam2c_con" },
				["1flag"] = "kam1c_1flag",
				--["sub"] = { "kam1c_sub", "kam2c_sub" },
				--["sgc"] = { "kam1c_sgc", "kam2c_sgc" },
			},
			["kas"] = {
				["con"] = { "kas2c_con", "kas3c_con", "kas1c_con" },
				["ctf"] = "kas2c_ctf",
				--["sub"] = { "kas2c_sub", "kas3c_sub", "kas1c_sub" },
				["sgc"] = { "kas2c_sgc", "kas3c_sgc", "kas1c_sgc" },
			},
			["mus"] = {
				["con"] = "mus1c_con",
				["ctf"] = "mus1c_ctf",
			},
			["myg"] = {
				["con"] = "myg1c_con",
				["ctf"] = "myg1c_ctf",
			},
			["nab"] = {
				["con"] = { "nab2c_con", "nab1c_con" },
				["ctf"] = "nab2c_ctf",
				--["sub"] = "nab2c_sub",
				["sgc"] = "nab2c_sgc",
			},
			["pol"] = {
				["con"] = "pol1c_con",
				["ctf"] = "pol1c_ctf",
			},
			["tat"] = {
				["con"] = { "tat3c_con", "tat2c_con", "tat1c_con" },
				["1flag"] = "tat3c_1flag",
				["ctf"] = "tat2c_ctf",
			},
			["uta"] = {
				["con"] = "uta1c_con",
				["1flag"] = "uta1c_1flag",
			},
			["yav"] = {
				["con"] = { "yav1c_con", "yav2c_con" },
				["1flag"] = { "yav1c_1flag", "yav2c_1flag" },
				["ctf"] = "yav2c_ctf",
			},
			--below are restored maps
			["dea"] = {
				["con"] = "dea1c_con",
				["1flag"] = "dea1c_1flag",
			},     
			["hot"] = {
				["con"] = "hot1c_con",
			},
			["end"] = {
				["con"] = "end1c_con",
			}, 			
			--new maps
			["bes"] = {
				["con"] = { "bes1c_con", "bes2c_con" },
				["ctf"] = "bes2c_ctf",
			},     
			["sal"] = {
				["con"] = "sal1c_con",
				["ctf"] = "sal1c_ctf",
			},
			["tan"] = {
				["con"] = "tan1c_con",
				["1flag"] = "tan1c_1flag",
			}, 
			["kor"] = {
				["con"] = "kor1c_con",
				["ctf"] = "kor1c_ctf",
			},
			["rhn"] = {
				["con"] = { "rhn1c_con", "rhn2c_con" },
				["1flag"] = { "rhn1c_1flag", "rhn2c_1flag" },
				["ctf"] = "rhn2c_ctf",
			}, 				
			--DLC Maps
			["cat"] = {
				["con"] = "cat1c_con",
			},
			["umb"] = {
				["con"] = "025c_con",
			},
			["rax"] = {
				["con"] = "rax019c_con",
			},
			["star06"] = {
				["con"] = "sul1c_con", --Sullust
			},
			["star11"] = {
				["con"] = "ARVc_con", --Arvala 7
			},
			["star14"] = {
				["con"] = "thu1c_con", --Thule
			},
			["star15"] = {
				["con"] = "boz1c_con", --Boz Pity
			},
			["star17"] = {
				["con"] = "ord1c_con", --Ord Mantell
			},
			["star19"] = {
				["con"] = "AMAc_con", --Amador
			},
		}
		
		-- associate names with teams
		this.teamName = {
			[0] = "",
			[REP] = "common.sides.rep.name",
			[CIS] = "common.sides.cis.name"
		}
		
		-- associate names with team bases
		this.baseName = {
			[REP] = "ifs.freeform.base.rep",
			[CIS] = "ifs.freeform.base.cis"
		}
		
		-- associate names with team fleets
		this.fleetName = {
			[0] = "",
			[REP] = "ifs.freeform.fleet.rep",
			[CIS] = "ifs.freeform.fleet.cis"
		}
		
		-- associate entity class with team fleets
		this.fleetClass = {
			[REP] = "gal_prp_assaultship",
			[CIS] = "gal_prp_fedcruiser"
		}
			
		-- associate icon textures with team fleets
		this.fleetIcon = {
			[REP] = "rep_fleet_normal_icon",
			[CIS] = "cis_fleet_normal_icon"
		}
		this.fleetStroke = {
			[REP] = "rep_fleet_normal_stroke",
			[CIS] = "cis_fleet_normal_stroke"
		}
		
		-- set the explosion effect for each team
		this.fleetExplosion = {
			[REP] = "gal_sfx_assaultship_exp",
			[CIS] = "gal_sfx_fedcruiser_exp"
		}
		
		-- team base planets
		this.planetBase = {
			[REP] = "kam",
			[CIS] = "geo"
		}
		
		-- team potential starting locations
		this.planetStart = {
			[REP] = { "cor", "kam", "nab" },
			[CIS] = { "geo", "uta", "mus", "fel" }
		}
	end
end
