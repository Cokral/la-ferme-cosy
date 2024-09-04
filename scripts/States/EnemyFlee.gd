extends State
class_name CowFleeState

@export var flee_speed := 75.0
@export var flee_duration := 3.0
@export var hit: HitState

var flee_timer: Timer
var flee_direction: Vector2

func _ready():
	super._ready()
	flee_timer = Timer.new()
	flee_timer.one_shot = true
	flee_timer.timeout.connect(_on_flee_timer_timeout)
	add_child(flee_timer)

func enter():
	super.enter()
	# Calculate flee direction away from the last known player position
	if hit and hit.has_method("get_flee_direction"):
		flee_direction = hit.get_flee_direction()
	else:
		# Fallback to a random direction if we can't get the hit direction
		flee_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	
	flee_timer.start(flee_duration)
	enemy.velocity = flee_direction * flee_speed
	if enemy and enemy.has_node("AnimatorControler"):
		enemy.get_node("AnimatorControler").flee()

func physics_update(delta: float):
	enemy.velocity = flee_direction * flee_speed

	if enemy and enemy.has_node("AnimatorControler"):
		enemy.get_node("AnimatorControler").update_animation(enemy.velocity)

func _on_flee_timer_timeout():
	transition_to("idle")

func exit():
	super.exit()
	enemy.velocity = Vector2.ZERO
	if enemy and enemy.has_node("AnimatorControler"):
		enemy.get_node("AnimatorControler").idle()  # Reset to idle animation when exiting
