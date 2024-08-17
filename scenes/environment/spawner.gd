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
	return spawn_entities[0].instantiate()


func spawn():
	var random_number = rng.randf_range(0.0, 1.0)
	if random_number < spawn_rate:
		var entity = type_to_spawn()
		entity.position = entity.position + spawn_offset
		self.add_child(entity)
		if entity.is_in_group('enemies'):
			var enemy : Enemy = entity
			enemy.set_target(target)
