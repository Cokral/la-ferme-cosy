extends TextureRect

@export var idle_textures: Array[Texture]
@export var animation_speed: float = 0.2  # Time in seconds between texture changes

var current_texture_index: int = 0
var timer: float = 0.0

func _ready():
	# Ensure we have at least one texture to display
	if idle_textures.size() > 0:
		texture = idle_textures[0]

func _process(delta):
	# Update the timer
	timer += delta
	
	# Check if it's time to change the texture
	if timer >= animation_speed:
		# Reset the timer
		timer = 0.0
		
		# Move to the next texture
		current_texture_index = (current_texture_index + 1) % idle_textures.size()
		
		# Update the displayed texture
		texture = idle_textures[current_texture_index]
