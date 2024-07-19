extends Node2D
class_name AnimatorControler

@export var animation_player: AnimationPlayer
@export var movement_controler: MovementComponent
@export var damage_animation: String = "Hit"
@export var idle_animation: String = "Idle"
@export var walk_animation: String = "Walk"
@export var eat_animation: String = "Eat"
@export var flee_animation: String = "Flee"

var direction: String

func damage():
	update_direction()
	animation_player.play(damage_animation + direction)
	
	var animation_length = animation_player.get_animation(damage_animation + direction).length / animation_player.speed_scale
	await get_tree().create_timer(animation_length).timeout
	
	animation_player.play(idle_animation)

func die() -> float:
	update_direction()
	animation_player.play("Die")
	var animation_length = animation_player.get_animation("Die").length / animation_player.speed_scale
	return animation_length

func walk():
	update_direction()
	animation_player.play(walk_animation + direction)

func idle():
	update_direction()
	animation_player.play(idle_animation + direction)

func eat():
	update_direction()
	animation_player.play(eat_animation + direction)

func flee():
	update_direction()
	animation_player.play(flee_animation + direction)
	
func update_direction():
	if movement_controler:
		direction = movement_controler.get_direction()
	else:
		direction = ""
		
	print(direction)

func _on_health_component_death():
	die()
