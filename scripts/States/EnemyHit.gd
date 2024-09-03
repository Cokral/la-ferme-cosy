extends State
class_name HitState

signal HitStarted
signal HitEnded

@export var stun_time := 0.5
	
var flee_direction: Vector2 = Vector2.ZERO
var stun_timer: Timer

func _ready():
	super._ready()
	stun_timer = Timer.new()
	stun_timer.one_shot = true
	stun_timer.timeout.connect(_on_stun_timer_timeout)
	add_child(stun_timer)

func enter():
	super.enter()
	print("Entering Hit State")
	take_damage()
	enemy.velocity = Vector2.ZERO
	stun_timer.start(stun_time)
	HitStarted.emit()
	if enemy and enemy.has_node("AnimatorControler"):
		enemy.get_node("AnimatorControler").damage()

func exit():
	super.exit()
	print("Exiting Hit State")
	stun_timer.stop()
	HitEnded.emit()

func physics_update(_delta: float):
	enemy.velocity = Vector2.ZERO

func _on_stun_timer_timeout():
	transition_to("flee")

func take_damage():
	flee_direction = (enemy.global_position - target.global_position).normalized()

func get_flee_direction() -> Vector2:
	return flee_direction
