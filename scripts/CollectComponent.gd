extends Node2D
class_name CollectComponent

@export var AttractionRange: CollisionShape2D
@export var CollectRange: CollisionShape2D
@export var loot: Loot # to be fixed to be item

@export var MAX_SPEED = 50.0
@export var MIN_SPEED = 25.0
@export var collect_distance := 15.0

var speed: float
var distance_with_player: float
var _target

func _ready():
	speed = MIN_SPEED

func _process(delta):
	if _target:
		if speed < MAX_SPEED:
			speed = speed + 1
		loot.velocity = (_target.global_position - global_position).normalized() * speed
		
		var distance = _target.global_position.distance_to(global_position)
		if distance < collect_distance:
			_target.collect(loot.item)	
			loot.queue_free()
	else:
		loot.velocity = Vector2.ZERO

	loot.move_and_slide()

func follow(new_target):
	_target = new_target
	

func unfollow():
	_target = null
	speed = MIN_SPEED
	loot.velocity = Vector2.ZERO


func _on_body_entered(body):
	if body.name == "Player":
		follow(body)


func _on_body_exited(body):
	if body.name == "Player":
		unfollow()
