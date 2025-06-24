
# Information:
	Work in progress.
	
	This is simple controller to handle check for global access to what state?
	
# files:
```
- player_manager.gd > PlayerManager (Glboal)
```
# api:

## idle.gd
```
#...
if not PlayerManager.is_enable_controller():
	return
```
This idle script handle input disable since the player is idle state when not moving.

When there is menu it disable player input.
