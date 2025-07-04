# notes:
- using AI google search for refs.

```
var behaviour_mode:String = "" # current set
var current_behaviour:String = "" # current mood
var combat_type:String = "physical" # weapon
var fallback_combat_type:String = "physical" # no weapon
```






# Passive Mobs: 
  These mobs generally avoid conflict with players and may even flee if attacked. They are often designed to be harmless or provide resources. Examples include cows, sheep, or chickens in many games. 

# Hostile Mobs: 
These mobs actively seek out and attack players, often with the goal of killing them. Examples include zombies, skeletons, or spiders. 

# Neutral Mobs: 
These mobs are neither inherently hostile nor passive. They may attack players if provoked (e.g., attacked first) or if they perceive a threat. 

Beyond these core behaviors, some games introduce more complex mob AI, including:
 - Following: Some mobs might follow the player, attempting to stay within a certain distance or pursue them across the map. 
- Chasing: Hostile mobs often chase the player when they come within a certain range. 
- Attacking: Hostile mobs will attempt to damage the player, using various attacks depending on their type. 
- Fleeing: Passive or even some neutral mobs might flee from the player or other threats. 
- Defending: Some mobs might defend their territory or other friendly mobs. 
- Cooperating: In some games, mobs might work together to attack the player or defend their territory. 
- Breeding: Certain mobs, like those in Minecraft, can be bred to produce offspring. 

Role-Based Behaviors: Creatures can be categorized based on their role in the game, which dictates their behavior: 
 - Defenders:
Creatures designed to protect something or someone, often exhibiting defensive stances and abilities.
- Attackers:
Creatures focused on attacking the player or other targets, often with aggressive movement and attack patterns.
- Support:
Creatures that provide assistance to other creatures, such as healing, buffing, or crowd control.
- Scouts:
Creatures designed to explore and gather information, often with high mobility and stealth abilities.
- Tanks:
Creatures designed to absorb damage and protect allies, often with high health and defense.


Social Behaviors: Many creatures exhibit social interactions, which can be modeled with different relationships: 
 - Aggression: How likely a creature is to attack another.
 - Fear: How likely a creature is to flee from another.
Social Dependence: How much a creature relies on others for survival or combat.
 - Pack Behavior: Creatures that operate together, often staying close and assisting each other in combat.
 - Dominance Hierarchies: Some creatures might exhibit dominance behaviors, such as fighting for leadership or territory.