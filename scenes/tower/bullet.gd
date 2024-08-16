extends RigidBody2D

class_name Bullet

@export var speed: float = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#look_at(position.direction_to(target))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_collide(Vector2.RIGHT.rotated(rotation) * speed * delta)
