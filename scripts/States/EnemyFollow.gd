extends State
class_name EnemyFollow

@export var move_speed := 100.0
@export var min_follow_distance := 25.0
@export var max_follow_distance := 50.0
@export var transition_distance := 75.0

func enter():
	if enemy:
		enemy.get_node("AnimatorControler").walk() 

func physics_update(delta: float):
	var direction = target.global_position - enemy.global_position
	
	if direction.length() > min_follow_distance:
		var new_velocity = direction.normalized() * move_speed
		enemy.velocity = new_velocity
	else:
		enemy.velocity = Vector2.ZERO
		
	if direction.length() > transition_distance:
		transition_to("wander")
