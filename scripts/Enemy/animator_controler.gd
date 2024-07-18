extends Node2D
class_name AnimatorControler

@export var animation_player: AnimationPlayer
@export var damage_animation: String = "Hit"
@export var idle_animation: String = "Idle"
@export var walk_animation: String = "Walk"
@export var eat_animation: String = "Eat"
@export var flee_animation: String = "Flee"

var direction: String

func damage():
	animation_player.play(damage_animation)
	
	var animation_length = animation_player.get_animation(damage_animation).length / animation_player.speed_scale
	await get_tree().create_timer(animation_length).timeout

	animation_player.play(idle_animation)

func die() -> float:
	animation_player.play("Die")
	var animation_length = animation_player.get_animation("Die").length / animation_player.speed_scale
	return animation_length

func walk():
	animation_player.play(walk_animation + direction)

func idle():
	animation_player.play(idle_animation + direction)

func eat():
	animation_player.play(eat_animation + direction)

func flee():
	animation_player.play(flee_animation + direction)
	
func set_direction(new_direction: String):
	direction = new_direction

func _on_health_component_death():
	die()
