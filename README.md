9/8/2025
- Started project using the Dodge the Creeps tutorial on https://docs.godotengine.org/en/stable/getting_started/first_2d_game/index.html

9/9/2025
- Completed initial tutorial
- Game changed to push creeps off the screen.
  - Player node is now a StaticBody2D to enable collisions between the player and the creeps.
  - Mob spawning algorithm changed to spit out ~100 creeps that float around and push into each other.
  - Scoring system changed into a countdown timer, with the game over state being running out of time.
  - Game win state added when all creeps are gone from the screen.
  -Added a "Remaining Creeps" counter to the bottom of the screen.
- Added a new player sprite from the wonderful Otterisk at https://otterisk.itch.io/hana-caraka-base-character
- Added a game winning sound from https://pixabay.com/sound-effects/success-bell-6776/
