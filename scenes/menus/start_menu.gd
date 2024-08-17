extends ColorRect

class_name StartMenu

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/environment/game.tscn")

func _on_how_to_button_pressed() -> void:
	pass # Replace with function body.
