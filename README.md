# SWBF2 (2005) Xbox - Unofficial Title Update
## Features
Update this section!

WIP Video Preview of Some Features:
https://www.youtube.com/watch?v=RGbPfWr0dlg

- New Game Modes
- New Maps
- New Heroes
- New Units
- Expanded Galactic Conquest
- More mission slots available for DLC (you must **NOT** install Pandemic's Official DLC Packs alongside this Title Update mod)
- And other additions or changes
- Retains Full Multiplayer Compatibility with regular Title Update Players (*todo:* test that this works stably for all gamemodes)

### New Game Modes
<img src="https://github.com/jcarpenter48/swbf2_tux/assets/70227084/3d8ad432-07ae-431a-896c-66e7b17003b5" width="45%"></img> <img src="https://github.com/jcarpenter48/swbf2_tux/assets/70227084/b689aa31-81ae-471e-a421-5acd704a84ec" width="45%"></img> 

- PSP Challenge Campaigns
- Order 66
- Subjugation
- New Hunt Modes
- New Hero Assault Modes
- New combinations like Clone Wars Hoth and Endor
  
### New Maps
- Bespin Cloud City (SWBF1)
- Bespin Platforms (SWBF1)
- Geonosis: Spire (SWBF1)
- Kamino: Tipoca City (SWBF1)
- Kashyyyk: Docks (SWBF1)
- Kashyyyk: Islands (SWBF1)
- Mustafar: Laboratory (SWBFES)
- Naboo: Plains (SWBF1)
- Naboo: Theed Streets (SWBF1 2003 Beta)
- Rhen Var: Citadel (SWBF1)
- Rhen Var: Harbour (SWBF1)
- Tatooine: Dune Sea (SWBF1)
- Yavin 4: Arena (SWBF1)
- Korriban: Ruins (SWBFRS)
- Saleucami: Caldera City (SWBFRS)
- Coruscant: Streets (SWBF1 by Rends)
- Space: Kamino (restored by DylanRocket)
- **Support for current and future Xbox Mod DLC Maps**
  
### New Heroes


### New Units


### Expanded Galactic Conquest
<img src="https://github.com/jcarpenter48/swbf2_tux/assets/70227084/2f941882-7282-4edb-8e36-42fe2cc847b6" width="23%"></img> <img src="https://github.com/jcarpenter48/swbf2_tux/assets/70227084/acd6a751-0a44-45c6-8d0c-6e4d1a8802d8" width="23%"></img> <img src="https://github.com/jcarpenter48/swbf2_tux/assets/70227084/fdbd348f-6750-4729-a3c5-4365b4b85294" width="23%"></img> <img src="https://github.com/jcarpenter48/swbf2_tux/assets/70227084/ad6c6ad2-b4e5-4049-bf92-e1ab6c6cf595" width="23%"></img> 
- More planets are available across all eras of Galactic Conquest
- **Support for dynamic addition of current and future Xbox Mod DLC Maps**
- Player selection of Team upon initialization of any Galactic Conquest scenario
- Restored Sensor Array Bonus
- Planets feature multiple maps that are randomly selected for play
- Planets with multiple game modes allow players (defenders only in splitscreen play) to choose the battle mode
- Auto-Resolve any battle
- Empire vs. CIS Galactic Conquest scenario

## Installation and Usage
Update this section!

## Credits
### "Unofficial Update Contributors"
- BK2-Modder - Lead,
- BAD-AL - Developer
- Dark_Phantom - Developer
- [GT]Teancum - Father of SWBF2 Xbox Modding

### Unofficial Update Special Thanks
- iamashaymin - Console Modding Research
- AnthonyBF2 - Console Modding Research
- BAD-AL - LVLTool, CoreMerge, and more
- Dark_Phantom - Tools and Research
- Calrissian97 - MSHConsole
- Sleepkiller - Model Edit
		
### With Content By
		{ str = "BK2-Modder - Scripts, Worlds, and More", },
		{ str = "BAD-AL - Scripts, Sounds, and More", },
		{ str = "Dark_Phantom - Scripts", },
		{ str = "[GT]Teancum - Scripts, Worlds, and Models", },
		{ str = "Calrissian97 - Updated BF1 Maps", },
		{ str = "DylanRocket - Restored Space Kamino", },		
		{ str = "iamashaymin - Miscellaneous", },
		{ str = "AnthonyBF2 - Miscellaneous", },
		{ str = "Rends - Coruscant Streets", },
		{ str = "The Conversion Pack Team - Miscellaneous", },
		{ str = "noobasaurus - Scripts", },
		{ str = "]v[ - +123 Mod Assets", },
		{ str = "giftheck  - Miscellaneous", },
		{ str = "CodaRez  - Misc. Models", },
		{ str = "ARC_Commander  - BFX Assets", },
		{ str = "Ranisdeguery  - Commando Assets", },
		{ str = "Sithani - Commando Assets", },
		{ str = "Andeweget - Commando Assets", },
		{ str = "NeoMarz - Zam Wesell Assets", },
		{ str = "Qdin - Commander Cody Assets", },
		{ str = "[GT]Gogie - Korriban Work", },
		{ str = "DarthD.U.C.K. - Royal Guard Assets", },
		{ str = "Satti and dragon93 - Clone Skin Assets", },
		{ str = "Ryan Hank - Grievous Animations", },
		{ str = "NB6090 - Padme Amidala Assets", },
		{ str = "The Collective - Mustafarian Assets", },

## Xbox Title Update to-do (07/27/23):
### Core
- [x] Try to figure out why locals aren't spawning on Geonosis Spire
- [x] Fix or replace towcables on Geonosis Spire GCW
- [x] Galactic Conquest voices (planet voiceovers)
- [x] Galactic Conquest AI Fleet-building (no idea if this was a problem with base-game or not, or if it's an emulator problem or actually related to the recompiled shell)
- [x] Rebel Raider challenges (Mygeeto is mostly working, need to repeat the process for the other maps and then fix things up) should be workable, except spa1 which was removed
- [x] spa3_r - Needs TIE spawns lowered some, ship icon for Imperial Venator
- [x] Merge Imperial Enforcer AI improvements in
- [x] replace kam1c_c with new copy of script that removes ingame intro movie call (we're using the transition movie instead); this is fine since it is a singleplayer only mission script, so no worries about desync (fingers crossed)
- [ ] Localization bug: Hero Assault, when on loading screen, says 'Space Assault'

### Stretch
- [x] Space Kamino Ingame Movie (this will be tough) workaround, placing these movies in shell.mvs and calling them as the transition movies instead works fine
- [x] Cut Objective Mode scripts or find a way to restrict them to only showing up for splitscreen? CUTTING THIS MODE
- [x] Commander Cody on Utapau Order 66 
- [x] Commander Bly Clone Commando on Felucia Order 66
- [x] Order 66 Mygeeto
- [x] Order 66 Kashyyyk
- [ ] Space Mustafar Assault?
- ~~[ ] Challenge Campaigns stats screen(s)?~~

### Localization
- [x] Another Localization Pass,
- [x] think the two Order 66 modes are missing some localization

### Testing
Splitscreen Stability Testing: 
- [x] Challenges, 
- [x] Subjugation, 
- [x] Order 66, 
- [x] Reconquest of the Rim, 
- [x] Galactic Conquest
- [x] Galactic Conquest Testing (misc)
- [ ] Multiplayer Testing (System Link, Insignia)

Performance Testing:
- [x] Naboo: Theed Streets

