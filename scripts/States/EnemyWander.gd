extends State
class_name CowWanderState

@export var move_speed := 50.0  # Slower speed for a cow
@export var min_wander_time := 3.0
@export var max_wander_time := 8.0
@export var grass_detection_range := 100.0

var move_direction: Vector2
var wander_time: float
var grass_areas: Array

func enter():
	super.enter()
	__randomize_wander()
	#grass_areas = get_tree().get_nodes_in_group("GrassArea")
	if enemy:
		enemy.velocity = move_direction * move_speed
		enemy.get_node("AnimatorControler").walk() 

func __randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(min_wander_time, max_wander_time)

func update(delta: float):
	if wander_time > 0:
		wander_time -= delta
	else:
		transition_to("idle")
	
	#check_for_grass()

func physics_update(delta: float):
	if enemy:
		enemy.velocity = move_direction * move_speed

func check_for_grass():
	for grass in grass_areas:
		if enemy.global_position.distance_to(grass.global_position) <= grass_detection_range:
			transition_to("move_to_grass")
			return

# Remove the player following behavior
# func check_player_distance():
#     var direction = target.global_position - enemy.global_position
#     if direction.length() < 40:
#         transition_to("follow")

func exit():
	super.exit()
	enemy.velocity = Vector2.ZERO
