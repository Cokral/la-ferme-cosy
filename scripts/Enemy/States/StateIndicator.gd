extends Node2D

var label: Label

func _ready():
	label = Label.new()
	label.set("theme_override_font_sizes/font_size", 8)
	label.set("theme_override_colors/font_color", Color.WHITE)
	label.set("theme_override_colors/font_outline_color", Color.BLACK)
	label.set("theme_override_constants/outline_size", 1)
	
	# Set the label to not use filter (prevents blurring)
	label.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
	
	# Create a container for the label
	var container = Control.new()
	container.set_anchors_preset(Control.PRESET_CENTER)
	container.add_child(label)
	
	# Add the container to the scene
	add_child(container)

func update_state(state_name: String):
	label.text = state_name

func _process(delta):
	# Position the label above the enemy
	label.position = Vector2(-label.size.x / 2, -25)  # Adjust Y value as needed


func _on_state_machine_transitioned(state):
	update_state(state.name)
