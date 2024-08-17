extends CanvasLayer

@onready var build_button: Button = %BuildButton

@export var tower : Tower

var _ghost

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass	

func _unhandled_input(event: InputEvent) -> void:
	# Mouse in viewport coordinates.
	if is_valid_to_place(event):
			var new_tower = tower.scene.instantiate()
			new_tower.position = _ghost.get_global_mouse_position()
			get_parent().add_child(new_tower)

func _on_build_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		_ghost = tower.ghost_scene.instantiate()
		get_parent().add_child(_ghost) # Replace with function body.
	else:
		if _ghost:
			_ghost.queue_free()

func is_valid_to_place(event: InputEvent) -> bool:
	return event is InputEventMouseButton \
	 and event.pressed \
	 and event.button_index == MOUSE_BUTTON_LEFT \
	 and build_button.button_pressed \
	 and _ghost \
	 and _ghost.get_overlapping_areas().size() == 0 
