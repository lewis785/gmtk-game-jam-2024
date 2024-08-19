extends CanvasLayer

@export var main_menu_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _input(event: InputEvent) -> void:
	if (event is InputEventKey and event.pressed) or event is InputEventMouseButton:
		launch_main_menu()
	
func launch_main_menu():
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")


func _on_video_stream_player_finished() -> void:
	launch_main_menu()
