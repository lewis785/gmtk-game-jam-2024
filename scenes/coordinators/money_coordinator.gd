extends Node2D

class_name MoneyCoordinator

@export var gold: int = 0;
@export var income: int = 0;
@export var income_period: float = 1.0;

@onready var income_timer: Timer = $IncomeTimer

signal gold_changed(new_amount: int)

func _ready() -> void:
	income_timer.wait_time = income_period

func can_afford(cost: int):
	return cost <= gold
	
func add_gold(amount: int):
	gold += amount
	gold_changed.emit(gold)

func remove_gold(amount: int):
	gold = max(gold - amount, 0)
	gold_changed.emit(gold)

func _on_income_timer_timeout() -> void:
	add_gold(income)
