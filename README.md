9/8/2025
- Started project using the Dodge the Creeps tutorial on https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html

9/9/2025
- Completed initial tutorial. It took ~2.5 hrs total to finish with a bit of troubleshooting.
- Game changed to push creeps off the screen.
  - Player node is now a StaticBody2D to enable collisions between the player and the creeps.
  - Mob spawning algorithm changed to spit out ~100 creeps that float around and push into each other.
  - Scoring system changed into a countdown timer, with the game over state being running out of time.
  - Game win state added when all creeps are gone from the screen.
  -Added a "Remaining Creeps" counter to the bottom of the screen.
- Added a new player sprite from the wonderful Otterisk at https://otterisk.itch.io/hana-caraka-base-character
- Added a game winning sound from https://pixabay.com/sound-effects/success-bell-6776/

9/15/2025
- Slightly unrelated to the assignment. Updated the game's window and changed how the game treats its borders. (2hr) Adds soft gate that mobs now have to be physically pushed off the map.
- Removing 4 mobs now adds a second to the timer. Timer is adjusted to 60 seconds. (10 min) This makes time a resource that is constantly draining while adding time when the objective is being completed.
- Added hard gates through levels with speed upgrades along with enemy count increases at each level. 2 new loops added by leveling up and having more enemies to push off the screen. The scaling levels will change the approach the player takes to remove all of the enemies. (1 hr)
- Added lighting effects. This was done in class and took longer to figure out than it did to implement. (1 hr)

9/16/2025
- The game now scales lighting and the speed the clock runs down based on the level. The lighting creates a soft gate in your ability to see the enemies, as the mob become easier to see the further you go. (2hrs)
- Attempted to add a final loop in adding a powerup coin, but I couldn't get the signals to react correctly in time. (1hr)

9/23/2025
- Added coin assets from Brackey's platforming tutorial: https://brackeysgames.itch.io/brackeys-platformer-bundle (10 min)
- Fixed coin pickup (2hr)
- Added new sounds from BDCraft: https://bdcraft.net/downloads/soundspack-minecraft/ (10 min)
- Implemented global audio manager (1hr)
- Fixed music loop (10 min)
- Added lighting to creeps (10 min)
- Adjustments made to game scaling (1 hr)
