extends Camera2D

class_name Camera


@export var zoom_factor : float = 0.1
@export var zoom_duration : float = 0.2
@export var speed: int = 10

@export var level : Level

var resolution

# Called when the node enters the scene tree for the first time.
func _ready():
	resolution = level.level_size * 64
	position = resolution/2
	ZoomManager.zoom_changed.connect(set_camera_zoom)

func _input(event):
	if event.is_action_pressed("ZoomCamIn"):
		ZoomManager.zoom_level += zoom_factor
	if event.is_action_pressed("ZoomCamOut"):
		ZoomManager.zoom_level -= zoom_factor 
	print("zoom level: " + str(ZoomManager.zoom_level))

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

func set_camera_zoom(zoom_level : float):
	zoom = Vector2(zoom_level, zoom_level)
