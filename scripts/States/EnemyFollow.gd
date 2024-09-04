extends State
class_name FollowState

@export var follow_speed := 50.0
@export var min_distance := 50.0
@export var max_distance := 150.0

func enter():
	if enemy and enemy.has_node("AnimatorControler"):
		enemy.get_node("AnimatorControler").walk()

func physics_update(delta: float):
	if not is_instance_valid(target):
		transition_to("idle")
		return
		
	if not target.is_holding_item("Carrot"):
		transition_to("idle")
		
	var direction = target.global_position - enemy.global_position
	var distance = direction.length()

	if distance > max_distance:
		transition_to("idle")
	elif distance > min_distance:
		enemy.velocity = direction.normalized() * follow_speed
		if enemy and enemy.has_node("AnimatorControler"):
			enemy.get_node("AnimatorControler").update_animation(enemy.velocity)
	else:
		enemy.velocity = Vector2.ZERO
		if enemy and enemy.has_node("AnimatorControler"):
			enemy.get_node("AnimatorControler").idle()
