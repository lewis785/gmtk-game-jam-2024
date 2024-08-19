extends Area2D

class_name TowerGhost

@onready var sprite_2d: AnimatedSprite2D = %Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

@export var affordable: bool = true
@export var tower : Tower

var map_resolution : Vector2

var valid_placement: bool

@onready var camera: Camera

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_global_mouse_position()
	_check_valid_placement()
	#if camera:
	scale = Vector2(1, 1) / camera.zoom
	
func _check_valid_placement():
	sprite_2d.material.set_shader_parameter("IsUnaffordable", !affordable)
	# Affordable has highest precedent so will return early if that is the case
	if !affordable:
		return
		
	var is_current_placement_valid = is_placement_valid()
	if valid_placement != is_current_placement_valid:
		valid_placement = is_current_placement_valid
	sprite_2d.material.set_shader_parameter("IsInvalidPlacement", !valid_placement)

func is_placement_valid():
	return is_position_on_map() and get_overlapping_areas().size() == 0 and get_overlapping_bodies().size() == 0

func is_position_on_map():
	var rect = collision_shape_2d.shape.get_rect()
	var pos = collision_shape_2d.global_position
	var scaler = 1 / ZoomManager.zoom_level
	var offset_x = (rect.size.x / 2) * scaler
	var offset_y = (rect.size.y / 2) * scaler
	
	if (pos.x - offset_x) < 0 or (pos.y - offset_y) < 0:
		return false
	
	# Map grid is 31 x 18, each square is 64px 
	if (pos.x + offset_x) > map_resolution.x or (pos.y + offset_y) > map_resolution.y:
		return false
	
	return true

func _draw():
	if tower:
		draw_circle(position, tower.attack_range, Color.RED, false, 1.0, true)
