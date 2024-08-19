extends Node2D

class_name Game

@export var level_1 : PackedScene
@onready var money_coordinator = $MoneyCoordinator
@onready var hud = %Hud

# Called when the node enters the scene tree for the first time.
#func _ready():
	#var level : Level = level_1.instantiate()
	#self.add_child(level)

func change_level(level: PackedScene):
	self.add_child(level.instantiate())
	var level_select = $"LevelSelect"
	if level_select:
		level_select.queue_free()
	
	money_coordinator.visible = true
	hud.visible = true
