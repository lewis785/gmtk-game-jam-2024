extends Node2D

@export var spawn_entities: Array[PackedScene]
@export_range(0.0, 1.0, 0.1) var spawn_rate = 0.2
@export var spawn_offset : Vector2

var min_spacing = 5
var time_since_last = 5
var rng = RandomNumberGenerator.new()


func type_to_spawn():
	var random_number = rng.randf_range(0.0, 1.0)
	if random_number < spawn_rate:
		return spawn_entities[1].instantiate()


func spawn():
	var entity = type_to_spawn()
	entity.position = entity.position + spawn_offset
	self.add_child(entity)
