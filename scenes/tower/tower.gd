extends BaseTower

var bullet = preload("res://scenes/tower/bullet.tscn")
@export var test_target : Sprite2D
@onready var attack_range = $AttackRange
@export var number_of_simultanious_shots = 4

func _on_timer_timeout() -> void:
	var collisions: Array[Area2D] = attack_range.get_overlapping_areas()
	for i in range(0, min(collisions.size(), number_of_simultanious_shots)):
		var new_bullet : Bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.look_at(collisions[i].global_position)
		new_bullet.scale = Vector2(tower_scale, tower_scale)
		new_bullet.damage = damage

func _on_health_component_died() -> void:
	queue_free() # Replace with function body.
