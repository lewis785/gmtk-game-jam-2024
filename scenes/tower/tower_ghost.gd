extends Area2D

@onready var sprite_2d: AnimatedSprite2D = %Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var valid_placement

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position()
	_check_valid_placement()
	
func _check_valid_placement():
	var is_current_placement_valid = is_placement_valid()
	if valid_placement != is_current_placement_valid:
		valid_placement = is_current_placement_valid
	sprite_2d.material.set_shader_parameter("IsInvalidPlacement", !valid_placement)

func is_placement_valid():
	return is_position_on_map() and get_overlapping_areas().size() == 0 and get_overlapping_bodies().size() == 0

func is_position_on_map():
	var rect = collision_shape_2d.shape.get_rect()
	var pos = collision_shape_2d.global_position
	var offset_x = rect.size.x / 2
	var offset_y = rect.size.y / 2
	
	if pos.x - offset_x < 0 or pos.y - offset_y < 0:
		return false
	
	# Map grid is 31 x 18, each square is 64px 
	if pos.x + offset_x > (31 * 64) or pos.y + offset_y > (18 * 64):
		return false
	
	return true
