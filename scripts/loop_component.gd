extends Node2D
class_name LootComponent

@export var max_quantity: int
@export var item: PackedScene
var rng = RandomNumberGenerator.new()
var quantity := 1
var rand_noise_spawn := 7

func _ready():
	quantity = rng.randi_range(1, max_quantity)

func drop(spawn_global_position):
	for i in quantity:
		var spawned_item := item.instantiate()
		var spawn_position_noise = Vector2(rng.randf_range(-rand_noise_spawn, rand_noise_spawn), rng.randf_range(-rand_noise_spawn, rand_noise_spawn))
		spawned_item.global_position = spawn_global_position + spawn_position_noise
		get_tree().root.add_child(spawned_item)
