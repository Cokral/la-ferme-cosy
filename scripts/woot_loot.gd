extends CharacterBody2D
class_name Loot

@export var item: Item
@export var loot_display: Sprite2D

func _ready():
	if item:
		loot_display.texture = item.item_texture
