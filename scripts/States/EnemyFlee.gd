extends State
class_name CowFleeState

@export var flee_speed := 150.0
@export var flee_duration := 3.0

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
	flee_direction = (enemy.global_position - target.global_position).normalized()
	flee_timer.start(flee_duration)

func physics_update(delta: float):
	enemy.velocity = flee_direction * flee_speed

func _on_flee_timer_timeout():
	transition_to("idle")

func exit():
	super.exit()
	enemy.velocity = Vector2.ZERO
