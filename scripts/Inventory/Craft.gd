extends Node2D
class_name Craft

@export var pickaxeItem: Item
@export var axeItem: Item
@export var wateringCan: Item
@export var inventory: Inventory
@export var menu: MenuButton

var availability: Dictionary

var recipes: Dictionary
var items = ["Pickaxe", "Axe", "Watering can"]


func _ready():
	menu.get_popup().id_pressed.connect(_on_submenu_button_pressed)
	recipes = {
		"Axe": { "recipe" : {"Wood": 2, "Rock": 2}, "item": axeItem },
		"Pickaxe": { "recipe" : {"Wood": 2, "Rock": 2}, "item": pickaxeItem },
		"Watering can": { "recipe" : {"Rock": 5}, "item": wateringCan },
	}

func _on_submenu_button_pressed(id):
	var recipe = recipes[items[id]]["recipe"]
	for item in recipe:
		if !availability.get(item) || availability[item] < recipe[item]:
			return
	inventory.add_item(recipes[items[id]]["item"])
	inventory.remove(recipe)
	availability = inventory.get_availability()

func _on_menu_button_pressed():
	availability = inventory.get_availability()
	print(availability)
