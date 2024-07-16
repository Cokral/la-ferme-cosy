extends Node2D
class_name ItemInventory

var slot_item_quantity: int
var item: Item

func set_texture(texture: Texture2D):
	if texture:
		$TextureRect.texture = texture
