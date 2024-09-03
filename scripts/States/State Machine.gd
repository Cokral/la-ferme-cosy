extends Node
class_name StateMachine

@export var initial_state: State

var states: Dictionary = {}
var current_state: State
var player: CharacterBody2D
@export var enemy: CharacterBody2D

signal transitioned(state)


func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
			
	if initial_state:
		initial_state.enter()
		current_state = initial_state

	player = get_tree().get_first_node_in_group("Player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_state:
		current_state.update(delta)
	check_for_follow_state()

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func check_for_follow_state():
	if current_state.name.to_lower() != "follow":
		if player and player.is_holding_item("Carrot"):
			var distance = player.global_position.distance_to(enemy.global_position)
			if distance <= 200:  # Max follow distance
				print("Player has carrot, transitioning to follow state")
				on_child_transition(current_state, "follow")
		
func damage(attack: Attack):
	on_child_transition(current_state, "hit")

func on_child_transition(state: State, new_state_name: String):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
	
	emit_signal("transitioned", new_state)  # Emit the signal with the new state
