extends BaseTower

var bullet = preload("res://scenes/tower/bullet.tscn")
@export var test_target : Sprite2D
@onready var attack_range = $AttackRange

func _on_timer_timeout() -> void:
	var collisions: Array[Area2D] = attack_range.get_overlapping_areas()
	if collisions.size() >= 1:
		var new_bullet : Bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.look_at(collisions[0].global_position)
		new_bullet.damage = damage

func _on_health_component_died() -> void:
	queue_free() # Replace with function body
