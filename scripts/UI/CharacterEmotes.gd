extends TextureRect

@export var idle_textures: Array[Texture]
@export var sleep_textures: Array[Texture]
@export var animation_speed: float = 0.2  # Time in seconds between texture changes
@export var sleep_timeout: float = 10.0  # Time in seconds before switching to sleep state

var current_texture_index: int = 0
var animation_timer: float = 0.0
var inactivity_timer: float = 0.0
var state: String

func _ready():
	# Ensure we have at least one texture to display
	if idle_textures.size() > 0:
		texture = idle_textures[0]

func _process(delta):
	# Update the animation_timer
	animation_timer += delta
	# Update the inactivity timer
	inactivity_timer += delta
	
	if Input.is_anything_pressed():
		handle_input()
	
	# Check if it's time to change the texture
	if animation_timer >= animation_speed:
		# Reset the animation_timer
		animation_timer = 0.0
		
		# Move to the next texture
		current_texture_index = (current_texture_index + 1) % idle_textures.size()
		
		# Update the displayed texture
		if state == "sleep":
			current_texture_index = (current_texture_index + 1) % sleep_textures.size()
			texture = sleep_textures[current_texture_index]
		else:
			current_texture_index = (current_texture_index + 1) % idle_textures.size()
			texture = idle_textures[current_texture_index]
	
	if inactivity_timer >= sleep_timeout and state != "sleep":
		switch_animation("sleep")

func switch_animation(status: String):
	current_texture_index = 0
	if status == "sleep":
		state = "sleep"
	else:
		state = "idle"

func handle_input():
	# Reset the inactivity timer
	inactivity_timer = 0.0
	
	# If we were in sleep state, switch back to idle
	if state == "sleep":
		switch_animation("idle")
