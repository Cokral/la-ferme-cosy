extends Node2D
class_name ItemInventory

var slot_item_quantity: int
var item: Item
var default_color = Color(1, 1, 1, 1)  # White
var selected_color = Color(1, 0.5, 0.5, 1)  # Light red

func set_texture(texture: Texture2D):
	if texture:
		$TextureRect.texture = texture
		
func select():
	print("Selecting.")
	$TextureRect.self_modulate = selected_color
		
func deselect():
	print("Deselecting.")
	$TextureRect.self_modulate = default_color
	
	
	
