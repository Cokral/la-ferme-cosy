extends State
class_name CowIdleState

@export var idle_duration := 3.0
@export var grass_detection_range := 100.0

var idle_timer: Timer
var grass_areas: Array

func _ready():
	super._ready()
	idle_timer = Timer.new()
	idle_timer.one_shot = true
	idle_timer.timeout.connect(_on_idle_timer_timeout)
	add_child(idle_timer)

func enter():
	super.enter()
	if enemy:
		enemy.velocity = Vector2.ZERO
		enemy.get_node("AnimatorControler").idle()  # Play idle animation
	idle_timer.start(idle_duration)
	grass_areas = get_tree().get_nodes_in_group("GrassArea")

func update(delta: float):
	super.update(delta)
	check_for_grass()

func check_for_grass():
	for grass in grass_areas:
		if enemy.global_position.distance_to(grass.global_position) <= grass_detection_range:
			transition_to("move_to_grass")
			return
			
func physics_update(delta: float):
	if enemy:
		enemy.velocity = Vector2(0, 0)

func _on_idle_timer_timeout():
	transition_to("wander")
