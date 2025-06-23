# gd_player_state_machine

# License: MIT

# status:
- vaulting test.
- obstacle test.

# Information:
	
  This is sample project for state machines to test basic movement and interact for player controls. There are different way to handle state machines depend on the game play and controls. It is base on GDQuest creator tutorial but out date some degree for missing or remove api for Godot 4.4.1 changes. Which had to adapt to change.

  The reason for state machines is check for condition for input from user controls and state. One is example is prone pose while jump which should not be doing. The prone position can only move slowly but can't jump. It need to be out the pose stance. By Crouch or stand to jump. Another is ladder state to prevent gravity fall.

  Another point is later use AI logic state.

  Testing vehicle interact.

# Features:
- state machine
	- [x] idle
	- [x] walk
	- [x] sprint
	- [x] jump
	- [x] edge climb with area 3d (wip)
	- [x] fall
	- [ ] crouch
	- [ ] slide
	- [ ] prone
	- [x] ghost (wip)
	- [x] fly (wip)
	- [ ] ladder
	- [ ] climb over
	- [ ] death

- UI debug
	- [x] player state
	- [x] draw line
	- [x] draw point
- [ ] Vehicle
	- [x] car
- [ ] Ladder
- [ ] Edge Climb
- [ ] Inventory
- [ ] creature

# Design:
	Working on the player state and interacting item, vehicle, mount, ladder and so on for testing.

## Controls:
- W,A,S,D = movement
- mouse motion = camera

- Backtick / backquote  = console command / Dev Console CMD
	- [x] ghost =  disable collision (n/a)
	- [x] walk = normal physics set
	- [x] fly
	- [ ] god (no damage / N/A)
	- [ ] summon item name
	- [ ] addbots N/A
	- [ ] killbots N/A
- 



# Credits:
- https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
- https://docs.godotengine.org/en/3.2/tutorials/misc/state_design_pattern.html
- https://gdscript.com/solutions/godot-state-machine/
- https://www.sandromaglione.com/articles/how-to-implement-state-machine-pattern-in-godot
- https://www.youtube.com/watch?v=zcLxBk-Els8 How to make a BASIC FPS CLIMB / VAULT system in Godot 4.2!
- https://www.youtube.com/watch?v=vapZQ0EuXAs GODOT 4 DYNAMIC MANTLE AND VAULT TUTORIAL
- https://www.youtube.com/@Brokencircuitboard
- https://www.youtube.com/watch?v=JnrhURF1jgM How To Draw Lines and Points in 3D - Godot 4 Tutorial
- https://www.reddit.com/r/godot/comments/14pean4/godot_4xgdextensions_forward_left_up_of_a_node/
- https://docs.godotengine.org/en/stable/tutorials/3d/using_transforms.html
- https://www.youtube.com/watch?v=fMC9JWg4BMk Click and Drag 3D Rotation in Godot

# Content Credits:
- https://kenney.nl/assets/prototype-textures
- 

# Addons Credits:
- console
	- Developer Console
	- Author: jitspoe
- 
	
