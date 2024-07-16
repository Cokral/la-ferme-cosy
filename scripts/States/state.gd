extends Node
class_name State

signal Transitioned(state, new_state_name)
signal StateEntered
signal StateExited

@export var enemy: CharacterBody2D
var target: CharacterBody2D

func _ready():
	target = get_tree().get_first_node_in_group("Player")

func enter():
	StateEntered.emit()

func exit():
	StateExited.emit()

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass

func transition_to(new_state_name: String):
	Transitioned.emit(self, new_state_name)
