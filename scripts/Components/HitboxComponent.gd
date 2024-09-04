extends Area2D
class_name HitboxComponent

@export var health_component: HealthComponent
@export var movement_component: MovementComponent
@export var animator_controler: AnimatorControler
@export var state_controler: StateMachine

func damage(attack: Attack):
	if animator_controler:
		animator_controler.damage()

	if health_component:
		health_component.damage(attack)
		
	if state_controler:
		state_controler.damage(attack)
		
	if movement_component:
		movement_component.knockback(attack)
