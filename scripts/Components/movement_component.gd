extends Node2D
class_name MovementComponent

@export var character: CharacterBody2D
#@export var animator: AnimatorControler
var status: String = "idle"
var direction: String
var prev_direction: String

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if character:
		if character.velocity.x > 0:
			direction = "Right"
		else:
			direction = "Left"

		if direction != prev_direction:
			prev_direction = direction
			character.get_node("AnimatorControler").update_direction()

		character.move_and_slide()
	
	if status == "idle":
		character.velocity = lerp(character.velocity, Vector2.ZERO, 0.1)
		

func knockback(attack: Attack):
	if character:
		print("knockback")
		character.velocity = (global_position - attack.attack_position).normalized() * attack.knockback_force
		
func get_direction():
	if character.velocity.x > 0: # moving to the right
		direction = "Right"
	else:
		direction = "Left"

	return direction
