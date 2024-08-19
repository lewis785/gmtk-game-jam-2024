extends CanvasLayer

class_name GameOverMenu

var game_over = false:
	set(value):
		visible = value
		game_over = value
		get_tree().paused = value

func _ready():
	visible = false

func _on_main_menu_button_pressed():
	game_over = false
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")
