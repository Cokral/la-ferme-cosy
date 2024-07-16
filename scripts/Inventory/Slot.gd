extends Panel
class_name Slot

@onready var label = $Label
var ItemInventory = preload("res://scenes/inventory/item_inventory.tscn")
var item_inv = null
var inventory_node = null

func _ready():
	inventory_node = find_parent("Inventory")

func add_new_item(item: Item):
	item_inv = ItemInventory.instantiate()
	item_inv.set_texture(item.item_texture)
	add_child(item_inv)
	
	item_inv.slot_item_quantity = item.item_quantity
	item_inv.item = item
	label.text = str(item_inv.slot_item_quantity)
	
func pick_from_slot():
	remove_child(item_inv)
	inventory_node.add_child(item_inv)
	item_inv = null
	label.text = ""
	
func put_into_slot(new_item: ItemInventory):
	item_inv = new_item
	item_inv.position = Vector2.ZERO
	inventory_node.remove_child(item_inv)
	add_child(item_inv)
	label.text = str(new_item.slot_item_quantity)


# Item Management

func update_item_quantity(new_item: Item):
	item_inv.slot_item_quantity += new_item.item_quantity
	label.text = str(item_inv.slot_item_quantity)
	
func remove_item_quantity(qty: int):
	item_inv.slot_item_quantity -= qty
	label.text = str(item_inv.slot_item_quantity)
	
	if item_inv.slot_item_quantity < 0:
		item_inv = null
