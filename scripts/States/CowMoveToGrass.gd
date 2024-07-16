extends State
class_name CowMoveToGrassState

@export var move_speed := 50.0
@export var eating_range := 10.0

var target_grass: Node2D

func enter():
	super.enter()
	target_grass = find_nearest_grass()

func physics_update(delta: float):
	if target_grass:
		var direction = target_grass.global_position - enemy.global_position
		if direction.length() > eating_range:
			enemy.velocity = direction.normalized() * move_speed
		else:
			transition_to("eat")
	else:
		transition_to("idle")

func find_nearest_grass() -> Node2D:
	var grass_areas = get_tree().get_nodes_in_group("GrassArea")
	var nearest_grass = null
	var nearest_distance = INF
	for grass in grass_areas:
		var distance = enemy.global_position.distance_to(grass.global_position)
		if distance < nearest_distance:
			nearest_grass = grass
			nearest_distance = distance
	return nearest_grass
