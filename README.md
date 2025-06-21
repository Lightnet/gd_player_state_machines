# gd_player_state_machine

# License: MIT

# status:
- vaulting test.
- obstacle test.

# Information:
	There are different way to handle state machine depend on the game play and controls.
	
	It base on gdquest creator tutorial but out date some degree for missing api for Godot 4.4.1 changes. Which had to adapt to change.

	There is reason for state machine is one is control how player interact and body pose. One is example is prone pose while jump which should not be doing. The prone position can only move slowly but can't jump. It need to be out the pose stance. By Crouch or stand to jump.

	Another is ladder state to prevent gravity fall.

# Features:
- state machine
	- [x] idle
	- [x] walk
	- [ ] sprint
	- [x] jump
	- [x] edge climb with area 3d (wip)
	- [x] fall
	- [ ] crouch
	- [ ] slide
	- [ ] prone
	- [ ] ghost
	- [ ] fly
	- [ ] ladder
	- [ ] climb over
	- [ ] ladder
	- [ ] death

- UI debug
	- player state
	- draw line

# Credits:
- https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/
- https://docs.godotengine.org/en/3.2/tutorials/misc/state_design_pattern.html
- https://gdscript.com/solutions/godot-state-machine/
- https://www.sandromaglione.com/articles/how-to-implement-state-machine-pattern-in-godot
- https://www.youtube.com/watch?v=zcLxBk-Els8 How to make a BASIC FPS CLIMB / VAULT system in Godot 4.2!
- https://www.youtube.com/watch?v=vapZQ0EuXAs GODOT 4 DYNAMIC MANTLE AND VAULT TUTORIAL
- https://www.youtube.com/@Brokencircuitboard
- https://www.youtube.com/watch?v=JnrhURF1jgM How To Draw Lines and Points in 3D - Godot 4 Tutorial
