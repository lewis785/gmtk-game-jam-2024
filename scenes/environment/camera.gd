extends Camera2D

class_name Camera

@export var speed: int = 10
@export var zoom_speed: int = 1

@export var level : Level

var resolution

# Called when the node enters the scene tree for the first time.
func _ready():
	resolution = level.level_size * 64
	position = resolution/2

func _input(event):
	var movement = Vector2(0,0)
	if event.is_action_pressed("ZoomCamIn"):
		movement += Vector2(zoom_speed,zoom_speed)
	if event.is_action_pressed("ZoomCamOut"):
		if zoom > Vector2(1,1):
			movement -= Vector2(zoom_speed,zoom_speed)
	zoom = zoom + movement


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
