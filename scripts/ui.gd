extends CanvasLayer
class_name UI

@export var inventoryUI: Inventory
signal inventory_status(status: bool)
signal equip(item: Item)


func _on_player_collected(item):
	inventoryUI.add_item(item)


func _on_inventory_inventory_status(status):
	inventory_status.emit(status)


func _on_inventory_equip(item):
	equip.emit(item)
