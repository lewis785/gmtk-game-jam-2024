extends Control

@export var level_data: LevelModel
@onready var label = $ColorRect/Label
@onready var texture_rect = $ColorRect/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	if level_data:
		label.text = level_data.name
		texture_rect.texture = level_data.img

func _on_button_pressed():
	var game: Game = $"../.."
	if game and level_data:
		game.change_level(level_data.scene)
