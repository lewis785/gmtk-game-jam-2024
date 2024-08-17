extends Node2D

class_name HealthComponent

signal damaged(damage: int)
signal died()
signal healed(heal: int)

@export var max_health: float = 0.0;

var health: float = 0.0

func _ready():
	health = max_health

func damage(value: Attack):
	print(health)
	var damage = _calculate_damage(value)
	health -= damage
	damaged.emit(damage)
	print(health)

	if health <= 0:
		died.emit()

func heal(amount: int):
	healed.emit(amount)
	health = min(health + amount, max_health)	

func full_heal():
	heal(max_health - health)

func _calculate_damage(attack: Attack):
	var damage = attack.damage
	return damage
