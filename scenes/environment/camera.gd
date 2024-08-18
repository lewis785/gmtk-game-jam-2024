extends Camera2D

class_name Camera

# Lower cap for the `_zoom_level`.
@export var min_zoom : float = 0.5
# Upper cap for the `_zoom_level`.
@export var max_zoom : float = 4.0
# Controls how much we increase or decrease the `_zoom_level` on every turn of the scroll wheel.
@export var zoom_factor : float = 0.1
# Duration of the zoom's tween animation.
@export var zoom_duration : float = 0.2

# The camera's target zoom level.
var _zoom_level : float = 1.0:
	set(value):
		_zoom_level = clamp(value, min_zoom, max_zoom)
		tween_zoom()

# We store a reference to the scene's tween node.
var tween: Tween = create_tween()

@export var speed: int = 10
@export var zoom_speed: int = 1

@export var level : Level

var resolution

# Called when the node enters the scene tree for the first time.
func _ready():
	resolution = level.level_size * 64
	position = resolution/2

func _input(event):
	if event.is_action_pressed("ZoomCamIn"):
		_zoom_level += zoom_factor
	if event.is_action_pressed("ZoomCamOut"):
		_zoom_level -= zoom_factor
	print("zoom level: " + str(_zoom_level))

func _process(_delta):
	var movement = Vector2(0,0)
	if Input.is_action_pressed("MoveCamLeft"):
		movement.x -= speed
	if Input.is_action_pressed("MoveCamRight"):
		movement.x += speed
	if Input.is_action_pressed("MoveCamUp"):
		movement.y -= speed
	if Input.is_action_pressed("MoveCamDown"):
		movement.y += speed
	if (position.x < 0 and movement.x < 0) or (position.x > resolution.x and movement.x > 0):
		movement.x = 0
	if (position.y < 0 and movement.y < 0) or (position.y > resolution.y and movement.y > 0):
		movement.y = 0
	position = position + movement

func tween_zoom():
	zoom = Vector2(_zoom_level, _zoom_level)
	#tween.tween_property(
		#self,
		#"zoom",
		#Vector2(_zoom_level, _zoom_level),
		#zoom_duration
	#)
