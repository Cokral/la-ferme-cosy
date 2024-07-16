extends Node2D
class_name Inventory

@onready var inventory_slots = $GridContainer
var holding_item = null
var is_open = false
signal inventory_status(status: bool)
signal equip(item: Item)

# Inventory Management

func add_item(new_item: Item):
	var first_open_slot: Slot
	for inv_slot in inventory_slots.get_children():
		inv_slot as Slot
		if inv_slot.item_inv:
			if inv_slot.item_inv.item.item_name:
				if inv_slot.item_inv.item.item_name == new_item.item_name:
					inv_slot.update_item_quantity(new_item)
					return
		
		if !inv_slot.item_inv && !first_open_slot:
			first_open_slot = inv_slot
	
	if first_open_slot:
		first_open_slot.add_new_item(new_item)
		
func remove(items: Dictionary):
	for key in items:
		var qty_to_remove = items[key]
		for inv_slot in inventory_slots.get_children():
			inv_slot as Slot
			var item_inv = inv_slot.item_inv
			if item_inv != null:
				var item_name = item_inv.item.item_name
				if item_name == key:
					inv_slot.remove_item_quantity(qty_to_remove)
					qty_to_remove = max(0, qty_to_remove - item_inv.slot_item_quantity)
					if items[key] == 0:
						continue

# UI

func _ready():
	for inv_slot in inventory_slots.get_children():
		inv_slot.gui_input.connect(slot_guid_input.bind(inv_slot))

	
func slot_guid_input(event: InputEvent, slot: Slot):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
			if holding_item != null:
				if !slot.item_inv:
					slot.put_into_slot(holding_item)
					holding_item = null
				else:
					var temp_item = slot.item_inv
					slot.pick_from_slot()
					temp_item.global_position = event.global_position
					slot.put_into_slot(holding_item)
					holding_item = temp_item
			elif slot.item_inv:
				holding_item = slot.item_inv
				slot.pick_from_slot()
				holding_item.global_position = get_global_mouse_position()
		if event.button_index == MOUSE_BUTTON_RIGHT && event.pressed:
			if slot.item_inv:
				if slot.item_inv.item.equipable:
					print("Equipping item ", slot.item_inv.item.item_name)
					equip.emit(slot.item_inv.item)

func _input(event: InputEvent) -> void:
	# Open / close inventory
	if event.is_action_pressed("tab"):
		if is_open:
			is_open = false
			self.visible = false
			inventory_status.emit(false)
		else:
			is_open = true
			self.visible = true
			inventory_status.emit(true)
	if is_open:
		# Move holding item position
		if holding_item:
			holding_item.global_position = get_global_mouse_position()

func get_availability() -> Dictionary:
	var availability = {}
	for inv_slot in inventory_slots.get_children():
		inv_slot as Slot
		var item_inv = inv_slot.item_inv
		if item_inv != null:
			var item_name = item_inv.item.item_name
			var item_quantity = item_inv.slot_item_quantity
			
			if availability.has(item_name):
				availability[item_name] += item_quantity
			else:
				availability[item_name] = item_quantity
	return availability
