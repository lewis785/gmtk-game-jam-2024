extends ColorRect

class_name StartMenu

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
