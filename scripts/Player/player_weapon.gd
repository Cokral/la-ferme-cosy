extends Node

@onready var player: Player = get_owner()
@export var weapon: Weapon


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("primary_fire"):
		player.attack()
		

func attack():
	set_weapon_position(player.dir.to_lower())
	weapon.set_hitbox_collision(true)


func _on_animation_player_animation_finished(anim_name):
	if "Axe" in anim_name:
		weapon.set_hitbox_collision(false)
		

func set_weapon_position(direction: String):
	match direction:
		"up":
			weapon.position = Vector2(0, -10)
			weapon.rotation = 90.0
		"down":
			weapon.position = Vector2(0, 10)
			weapon.rotation = 90.0
		"right":
			weapon.position = Vector2(10, 2)
			weapon.rotation = 0.0
		"left":
			weapon.position = Vector2(-10, 2)
			weapon.rotation = 0.0
