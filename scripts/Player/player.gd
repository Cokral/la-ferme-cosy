extends CharacterBody2D
class_name Player

@onready var animated_sprite = $AnimationPlayer
@onready var weapon = $Weapon
@export var inventory: Inventory

const SPEED: float = 75.0
const MAX_SPEED_SCALE = 3
const MIN_SPEED_SCALE = 2

var input_buffer = [Vector2.ZERO]
var input_buffer_str = []
var input_buffer_readout = Vector2()
var action_vector = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN,
}
var dir: String = "right"
var attacking: bool = false
var inventory_open: bool = false
var item_equipped: Item = null
var item_held: Item = null
signal collected(item: Item)


func _physics_process(_delta):
	########
	# MOVE #
	########
	if !inventory_open:
		# Prevent issues with the list not emptying properly
		if !Input.is_anything_pressed():
			input_buffer = [Vector2.ZERO]
			input_buffer_str = []
		else:
			for action in action_vector:
				var vector = action_vector[action]
				
				# Add new keys in the list
				if Input.is_action_just_pressed(action):
					input_buffer.append(vector)
					input_buffer_str.append(action)
				
			for action in action_vector:
				var vector = action_vector[action]
				# Remove no longer pressed keys
				if Input.is_action_just_released(action):
					input_buffer.erase(vector)
					input_buffer_str.erase(action)
		
		if !attacking:
			# Update movement	
			input_buffer_readout = input_buffer[-1]
			velocity = input_buffer_readout * SPEED
			move_and_slide()
			
			# Update animation
			if input_buffer_readout == Vector2.ZERO:
				animated_sprite.play("Idle" + dir.capitalize())
				if animated_sprite.speed_scale >= MIN_SPEED_SCALE:
					animated_sprite.speed_scale -= 0.1
			else:
				animated_sprite.speed_scale = MAX_SPEED_SCALE
				if input_buffer_str.size() > 0:
					dir = input_buffer_str[-1].capitalize()
				animated_sprite.play("Walk" + dir)
		

func attack():
	if item_equipped:
		# todo: move this to Weapon directly
		animated_sprite.play("Axe" + dir)
		attacking = true
		animated_sprite.speed_scale = MAX_SPEED_SCALE

func collect(item):
	collected.emit(item)

func _on_animation_player_animation_finished(anim_name):
	if "Axe" in anim_name:
		attacking = false

func _on_ui_inventory_status(status):
	inventory_open = status

func _on_ui_equip(item):
	if item.equipable:
		item_equipped = item
		item_held = null
		print("player equiped " + item_equipped.item_name)
		$ItemHeld.visible = false
	elif item.holdable:
		item_held = item
		item_equipped = null
		print("player holds " + item_held.item_name)
		$ItemHeld.texture = item.item_texture
		$ItemHeld.visible = true
