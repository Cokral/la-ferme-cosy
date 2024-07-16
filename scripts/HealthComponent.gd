extends Node2D
class_name HealthComponent

@export var MAX_HEALTH := 10.0
@export var animator_controler: AnimatorControler
@export var loot_component: LootComponent

var health: float

func _ready():
	health = MAX_HEALTH

func damage(attack: Attack):
	health -= attack.attack_damage
	
	if health <= 0:
		die()

func die():
	if animator_controler:
		var animation_length = animator_controler.die()
		await get_tree().create_timer(animation_length).timeout
		
	if loot_component:
		loot_component.drop(global_position)

	get_parent().queue_free()
