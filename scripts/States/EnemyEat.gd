extends State
class_name CowEatState

@export var eating_duration := 5.0

var eat_timer: Timer

func _ready():
	super._ready()
	eat_timer = Timer.new()
	eat_timer.one_shot = true
	eat_timer.timeout.connect(_on_eat_timer_timeout)
	add_child(eat_timer)

func enter():
	super.enter()
	enemy.velocity = Vector2.ZERO
	eat_timer.start(eating_duration)
	print("Cow starts eating grass")  # Replace with actual eating animation or effect

func _on_eat_timer_timeout():
	print("Cow finished eating grass")  # Replace with actual finish eating animation or effect
	transition_to("idle")
