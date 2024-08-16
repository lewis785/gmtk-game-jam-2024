extends Area2D

var bullet = preload("res://scenes/tower/bullet.tscn")
@export var test_target : Sprite2D
@onready var collision_shape_2d: CollisionShape2D = %CollisionShape2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var collisions = get_overlapping_bodies()
	if collisions.size() >= 1:
		var new_bullet : Bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.look_at(collisions[0].position)
