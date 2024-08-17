extends Area2D

@onready var sprite_2d: AnimatedSprite2D = %Sprite2D

var _valid_placement

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_viewport().get_mouse_position()
	_check_valid_placement()
	
func _check_valid_placement():
	var is_current_placement_valid = get_overlapping_areas().size() != 0
	if _valid_placement != is_current_placement_valid:
		_valid_placement = is_current_placement_valid
		sprite_2d.material.set_shader_parameter("IsInvalidPlacement", _valid_placement)
