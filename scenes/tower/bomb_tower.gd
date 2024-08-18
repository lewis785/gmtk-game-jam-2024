extends BaseTower

const bomb = preload("res://scenes/tower/bomb.tscn")

@export var test_target : Sprite2D
@onready var attack_range = $AttackRange
func _on_timer_timeout() -> void:
	var collisions: Array[Area2D] = attack_range.get_overlapping_areas()
	if collisions.size() >= 1:
		var new_bomb : Bomb = bomb.instantiate()
		new_bomb.target = collisions[0].global_position - global_position
		new_bomb.damage = damage
		add_child(new_bomb)

func _on_health_component_died() -> void:
	queue_free() # Replace with function body
