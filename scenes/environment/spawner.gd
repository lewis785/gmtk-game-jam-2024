extends Node2D

class_name Spawner

@export var spawn_entities: Array[PackedScene]
@export_range(0.0, 1.0, 0.1) var spawn_rate = 0.1
@export var spawn_offset : Vector2 = Vector2(0,0)
@export var target : Node2D

var min_spacing = 5
var time_since_last = 5
var rng = RandomNumberGenerator.new()


func type_to_spawn():
	var random_number = rng.randf_range(0.0, 1.0)
	if random_number < 0.05:
		return spawn_entities[1].instantiate()
	else:
		return spawn_entities[0].instantiate()


func spawn():
	var random_number = rng.randf_range(0.0, 1.0)
	if random_number < spawn_rate:
		var entity = type_to_spawn()
		var rand_offset_x = rng.randf_range(-50.0, 50.0)
		var rand_offset_y = rng.randf_range(-50.0, 50.0)
		entity.position = entity.position + spawn_offset + Vector2(rand_offset_x, rand_offset_y)
		self.add_child(entity)
		if entity.is_in_group('enemies'):
			var enemy : Enemy = entity
			enemy.set_target(target)
