extends BaseTower

var beam = preload("res://scenes/projectiles/beam.tscn")

@export var test_target : Sprite2D
@export var number_of_simultanious_shots = 4

@onready var attack_range = $AttackRange
@onready var audio_stream_player_2d_attack = $AudioStreamPlayer2DAttack

@onready var died = false

func _on_timer_timeout() -> void:
	if !died:
		var collisions: Array[Area2D] = attack_range.get_overlapping_areas()
		if collisions.size() > 0:
			audio_stream_player_2d_attack.play()
		for i in range(0, min(collisions.size(), number_of_simultanious_shots)):
			var new_beam : Beam = beam.instantiate()
			add_child(new_beam)
			new_beam.look_at(collisions[i].global_position)
			new_beam.scale = Vector2(tower_scale, tower_scale)
			new_beam.damage = damage

func _on_health_component_died() -> void:
	died = true
	queue_free()
