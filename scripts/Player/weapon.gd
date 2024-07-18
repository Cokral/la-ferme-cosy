extends Node2D
class_name Weapon

@export var hitbox_collision: CollisionShape2D

var attack_damage := 1.0
var knockback_force := 100.0


func _on_hitbox_area_entered(area):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		var attack = Attack.new()
		attack.attack_damage = attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		
		hitbox.damage(attack)

		
func set_hitbox_collision(is_collision: bool):
	hitbox_collision.disabled = !is_collision
