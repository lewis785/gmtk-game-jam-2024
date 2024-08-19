extends BaseTower

const bomb = preload("res://scenes/tower/bomb.tscn")

@export var test_target : Sprite2D
@onready var attack_range = $AttackRange
@onready var sprite: AnimatedSprite2D = %Sprite
@onready var audio_stream_player_2d_attack = $AudioStreamPlayer2DAttack
@onready var projectile_spawn_point: Node2D = $ProjectileSpawn

var open: bool = false

func _on_timer_timeout() -> void:
	var collisions: Array[Area2D] = attack_range.get_overlapping_areas()
	if collisions.size() >= 1:
		if !open:
			open = true
			sprite.play("open")
			await get_tree().create_timer(0.5).timeout
			return

		var new_bomb : Bomb = bomb.instantiate()
		#print("Global: ", global_position, " Spawn: ", projectile_spawn_point.global_position )
		new_bomb.position = projectile_spawn_point.position
		new_bomb.target = collisions[0].global_position - projectile_spawn_point.global_position
		new_bomb.damage = damage
		new_bomb.find_child("Area2D").scale = Vector2(tower_scale, tower_scale)
		audio_stream_player_2d_attack.play()
		add_child(new_bomb)
	else:
		if open:
			open = false
			sprite.play("close")
			await get_tree().create_timer(0.5).timeout

func _on_health_component_died() -> void:
	queue_free() # Replace with function body
