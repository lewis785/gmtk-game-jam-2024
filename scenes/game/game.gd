extends Node2D

class_name Game

@onready var hud = %Hud

func change_level(level: PackedScene):
	self.add_child(level.instantiate())
	var level_select = $"LevelSelect"
	if level_select:
		level_select.queue_free()

	hud.visible = true
