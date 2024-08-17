extends RigidBody2D

var bullet = preload("res://scenes/tower/bullet.tscn")
@export var test_target : Sprite2D
@onready var range_collision_shape = %RangeCollisionShape
@onready var attack_range = $AttackRange

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var collisions: Array[Area2D] = attack_range.get_overlapping_areas()
	if collisions.size() >= 1:
		var new_bullet : Bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.look_at(collisions[0].global_position)


func _on_health_component_damaged(damage: int) -> void:
	print("Tower taking damage")


func _on_health_component_died() -> void:
	print("Tower died...")
	queue_free() # Replace with function body.
