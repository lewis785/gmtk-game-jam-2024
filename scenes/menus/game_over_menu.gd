extends CanvasLayer

class_name GameOverMenu

func _ready():
	visible = false

func game_over():
	visible = true
	get_tree().paused = true
	

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")
