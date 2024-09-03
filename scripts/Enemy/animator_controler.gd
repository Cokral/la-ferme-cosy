extends Node2D
class_name AnimatorControler

@export var animation_player: AnimationPlayer
@export var movement_controler: MovementComponent
@export var damage_animation: String = "Hit"
@export var idle_animation: String = "Idle"
@export var walk_animation: String = "Walk"
@export var eat_animation: String = "Eat"
@export var flee_animation: String = "Flee"
@export var die_animation: String = "Die"

var current_animation: String = ""
var direction: String

func damage():
	play_animation(damage_animation)

func walk():
	play_animation(walk_animation)

func idle():
	play_animation(idle_animation)

func eat():
	play_animation(eat_animation)

func flee():
	play_animation(flee_animation)
	
func die():
	animation_player.play(die_animation)
	var animation_length = animation_player.get_animation("Die").length / animation_player.speed_scale
	return animation_length

func play_animation(anim_name: String):
	update_direction()
	var full_anim_name = anim_name + direction
	if current_animation != full_anim_name:
		animation_player.play(full_anim_name)
		current_animation = full_anim_name
		print("Playing animation: ", full_anim_name)

func update_animation(velocity: Vector2):
	if velocity.length() > 0:
		if current_animation.begins_with(idle_animation):
			walk()
	else:
		if not current_animation.begins_with(idle_animation):
			idle()

func update_direction():
	if movement_controler:
		direction = movement_controler.get_direction()
	else:
		direction = ""
	print("Current direction: ", direction)
