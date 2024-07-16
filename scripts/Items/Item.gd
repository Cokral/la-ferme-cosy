extends Resource
class_name Item

@export var item_id: String
@export var item_name: String = ""
@export var item_quantity: int = 1
@export var item_description: String = ""
@export var item_texture: Texture2D
@export var equipable: bool = false
@export var attack_damage := 0.0
@export var knockback_force := 0.0
