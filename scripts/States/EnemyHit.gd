extends State
class_name EnemyHit

signal HitStarted
signal HitEnded

@export var stun_time := 1.0

var stun_timer: Timer

func _ready():
	super._ready()
	stun_timer = Timer.new()
	stun_timer.one_shot = true
	stun_timer.timeout.connect(_on_stun_timer_timeout)
	add_child(stun_timer)

func enter():
	super.enter()
	enemy.velocity = Vector2.ZERO
	stun_timer.start(stun_time)
	HitStarted.emit()

func exit():
	super.exit()
	stun_timer.stop()
	HitEnded.emit()

func physics_update(_delta: float):
	enemy.velocity = Vector2.ZERO

func _on_stun_timer_timeout():
	transition_to("idle")
