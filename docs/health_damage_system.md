# health and damage system:
	The namming of the variable has to be easy to understand. As for damage and heal which for DamageType or _on_damage().
	
	So the name it as Hit as to reflect create getting hit by something. For easy to know if damage or heal effect.
	
	As for the damage number is name point or points. For correct naming standard for game.
	
	Name of function for on_damage(damage_data:DamageType) to _on_hit_received(hit_data:HitInfoData). 
	
	As for the prefixed "_" for unused function call will ingore without "_" it be light error.
	
	For reason change the DamageType to HitInfoData for better easy understanding for type for damage, heal, buff, debuf and others.
	
# Design build

## hit_info_data.gd
```
extends Resource
class_name HitInfoData

@export var name:String = "None"
@export var amount_point:float = 1.0 # damage or heal
@export var type:String = "Physical" #Type: Physical, damage, heal, buff, debuff
## if there no owner default here
## for this example is area effect tick
var current_owner_name:String = "None" 
var current_owner:Node3D #owner
```

## player.gd
```
signal hit_received(hit_info: HitInfoData)  # Emitted when entity is hit (damage or healing)
signal health_changed(new_health: int, old_health: int)  # Emitted when health changes
signal died()  # Emitted when health reaches zero
```
### _on_hit_received:
```
func _on_hit_received(hit_info:HitInfoData):
	if is_invulnerable:
		return
		
	if stats:
		var old_health: float = stats.health
		if hit_info.type == "Heal":
			stats.health += hit_info.point
			if stats.health > stats.health_max:
				stats.health = stats.health_max
			return
		stats.health -= hit_info.point
		print("stats.health: ", stats.health)
		if stats.health < 0:
			stats.health = 0
			emit_signal("died")
		var current_health_points: float = stats.health
		emit_signal("health_changed", current_health_points, old_health)
```



# notes:

## Physical Damage:
- Bludgeoning: Damage from blunt impacts, like being hit with a club or falling.
- Piercing: Damage from sharp, pointed objects, like arrows or spears.
- Slashing: Damage from sharp, cutting attacks, like a sword or axe. 

## Energy Damage:
- Fire: Damage from burning, like from a fire spell or dragon's breath.
- Cold: Damage from extreme cold, like a frost spell or ice breath.
- Lightning: Damage from electricity, like a lightning bolt or shock spell.
- Acid: Corrosive damage, like from an acid spell or the breath of an acid-based creature.
- Poison: Damage from toxins or venom. 

## Magical/Other Damage:
- Force: Pure magical energy that bypasses many resistances. 
- Necrotic: Damage that withers flesh and can harm the soul. 
- Radiant: Damage associated with positive energy, often effective against undead. 
- Psychic: Damage to the mind, often associated with psychic or psionic attacks. 
- Thunder: Damage from concussive sonic force. 
- Healing/Positive Energy: Can heal living creatures and damage undead. 
- Negative Energy/Necrotic: Damage that can heal undead and damage living creatures. 
- Healing/Positive Energy on Constructs: Some games have specific healing types that only affect constructs. 





# 
