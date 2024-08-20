extends BaseTower

var bullet = preload("res://scenes/projectiles/bullet.tscn")
@export var test_target : Sprite2D
@export var number_of_simultanious_shots = 1

@onready var attack_range = $AttackRange
@onready var audio_stream_player_2d_attack = $AudioStreamPlayer2DAttack
@onready var sprite : AnimatedSprite2D = %Sprite

@onready var died = false

func _on_timer_timeout() -> void:
	if !died:
		var collisions: Array[Area2D] = attack_range.get_overlapping_areas()
		if collisions.size() > 0:
			audio_stream_player_2d_attack.play()
			sprite.play("attack")
		else:
			sprite.play("idle")
		for i in range(0, min(collisions.size(), number_of_simultanious_shots)):
			var new_bullet : Bullet = bullet.instantiate()
			add_child(new_bullet)
			new_bullet.look_at(collisions[i].global_position)
			new_bullet.scale = Vector2(tower_scale, tower_scale)
			new_bullet.damage = damage

func _on_health_component_died() -> void:
	died = true
	queue_free()
