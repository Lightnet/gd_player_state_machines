# gd_player_state_machines

# License: MIT

# status:
- player input and inventory testing

# Information:
	
  This is sample project for state machines for player input controls. This is prototype test.

# Overview:

This project implements a finite state machine (FSM) to manage player movement and interactions in a 2D/3D game developed in Godot 4.4.1. The state machine handles user input, enforces gameplay rules, and ensures logical transitions between player states (e.g., standing, crouching, prone, jumping, ladder climbing). The system is adapted from an older GDQuest tutorial, updated to accommodate API changes and deprecated features in Godot 4.4.1.

The state machine is designed to:
- Process user input and transition between states based on gameplay conditions.
- Prevent invalid actions, such as jumping while in a prone position.
- Support extensibility for future features, including AI logic and vehicle interactions.

# Purpose:
The state machine ensures robust and predictable player behavior by:
1. Managing mutually exclusive states (e.g., prone and jumping cannot occur simultaneously).
2. Enforcing gameplay constraints (e.g., slow movement in prone, no gravity during ladder climbing).
3. Providing a foundation for future AI-driven state logic and vehicle interaction systems.

# State Machine Design

## Core States

The system defines the following player states:
- Standing: Default state for normal movement (walking, running).
- Crouching: Reduced height, slower movement, allows transition to jumping.
- Prone: Low profile, very slow movement, prevents jumping until transitioning to crouching or standing.
- Jumping: Vertical movement, only accessible from standing or crouching states.
- Ladder Climbing: Disables gravity, allows vertical movement on ladders, prevents falling.

## State Transition Rules
- Prone Restrictions: Players cannot jump while prone. They must transition to crouching or standing first.
- Ladder State: Disables gravity to prevent falling and restricts horizontal movement.
- Input-Driven Transitions: States change based on user input (e.g., pressing "jump" from standing/crouching, or "prone" from crouching).

## Input Handling
The state machine processes input events using Godot’s updated input system (Input class in Godot 4.4.1). Each state checks for valid inputs and transitions accordingly. For example:

- ui_up or ui_down triggers ladder climbing when near a ladder.
- ui_jump initiates a jump only from valid states (standing, crouching).
- ui_crouch or ui_prone adjusts the player’s stance.

# Implementation Notes

## Godot 4.4.1 Adaptations
The original GDQuest tutorial relied on older Godot APIs, which have been deprecated or modified in Godot 4.4.1. Key adaptations include:

- Updated input handling to use Input.get_action_strength() and Input.is_action_just_pressed() for smoother control.
- Replaced deprecated node properties (e.g., Transform updates) with current equivalents.
- Adjusted physics interactions to use CharacterBody2D/CharacterBody3D for movement and collision.

### Code Structure
- State Machine Node: A dedicated node (StateMachine) manages state transitions and delegates input handling to the active state.
- State Scripts: EachWheel state (e.g., StandingState, ProneState) is implemented as a separate script, inheriting from a base State class.
- Player Node: The player (CharacterBody2D or CharacterBody3D) references the state machine and applies movement logic based on the current state.

### Gameplay Constraints
- Prone State: Movement speed is significantly reduced, and jumping is disabled until the player transitions out of prone (via crouching or standing).
- Ladder State: Gravity is disabled to allow smooth climbing. Horizontal movement is restricted to prevent unintended behavior.
- Jumping: Only available from standing or crouching states to maintain logical gameplay flow.

# Future Features

## AI Logic Integration
The state machine is designed to be extensible for AI-controlled characters. Planned enhancements include:
- AI State Transitions: AI-driven decisions (e.g., patrol, chase, idle) using similar state logic.
- Behavior Trees: Integration with Godot’s node-based systems to complement the state machine for complex AI behaviors.

## Vehicle Interaction Testing
The system will support vehicle interactions, including:
- Enter/Exit States: New states for entering, driving, and exiting vehicles.
- Vehicle-Specific Controls: Custom input mappings for vehicle movement and interactions.
- State Transitions: Seamless transitions between on-foot and vehicle states, ensuring no invalid actions (e.g., jumping while driving).

# Testing and Validation
- Unit Tests: Test state transitions to ensure invalid states (e.g., prone + jump) are blocked.
- Input Validation: Verify that inputs correctly trigger state changes (e.g., ladder climbing only near ladders).
- Physics Checks: Confirm gravity is disabled during ladder climbing and re-enabled on exit.
- Vehicle Interaction Prototypes: Initial tests for vehicle entry/exit and control handling.

# Known Issues and Limitations
- Some edge cases in state transitions (e.g., rapid input spamming) may require additional debouncing logic.
- Vehicle interaction is in early prototyping and not fully integrated.
- AI logic is planned but not yet implemented.

# Features:
- state machine
	- [x] idle
	- [x] walk
	- [x] sprint
	- [x] jump
	- [x] edge climb with area 3d (wip)
	- [x] fall
	- [x] crouch
	- [x] slide (simple test)
	- [x] prone (simple test)
	- [x] ghost (disable collision)
	- [x] fly
	- [ ] ladder
	- [ ] climb over
	- [ ] death

- UI 
	-debug
		- [x] player state
		- [x] draw line
		- [x] draw point
- [ ] Vehicle
	- [x] car
- [ ] Ladder
- [ ] Edge Climb
- [x] Inventory
	- [x] player ui ()
	- [x] drop item
	- [x] pick up
	- [x] equip ui (simple test)
	- [x] chest ui
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
	- [x] summon item_name item_count
	- [ ] addbots N/A
	- [ ] killbots N/A
- ...

# summon commands:
	To summon item it need to be lower case and space replace underscores which is from item/items folder.
```
summon apples
summon blue_book
```	
	Summon item name must match the ItemData.name = "Apples" but lower case for easy summon command.
```
summon apples 1
```
	You can add many item quantity count. Not added limited for one stack or cap check yet.


# State machines:
There are three files base to handle state machine. One file handle player with character3d. Two file handle the class state and state machine change state.

The player class handle the variables and object to hold components. State will get player data. State machine will handle loop and pass it to state and chanage state.

State machine handle set input condition(s) like crouch to handle shape collision, player position adjusted.

## player.gd
```
class_name Player extends CharacterBody3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D
#...
```
## state.gd
```
class_name State extends Node
signal finished(next_state_path: String, data: Dictionary)
func handle_input(_event: InputEvent) -> void:
func update(_delta: float) -> void:
func physics_update(_delta: float) -> void:
func enter(previous_state_path: String, data := {}) -> void:
func exit() -> void:
```
## state_machine.gd
```
class_name StateMachine extends Node
@export var initial_state: State = null
#...
func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
```

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
- ...
	
