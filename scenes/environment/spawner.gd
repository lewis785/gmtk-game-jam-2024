extends Node2D

class_name Spawner

@export var spawn_entities: Array[PackedScene]
@export_range(0.0, 1.0, 0.1) var spawn_rate = 0.1
@export var spawn_offset : Vector2 = Vector2(0,0)
@export var target : Node2D

var wave: int = 1;
#@export var wave_size: int = 30;
var intro_period: float = 5.0
var rest_period: float = 10.0
@export_range(0.0, 10.0, 0.1) var spawn_period: float = 0.5

@export var spawner_resource: SpawnModel

@onready var rest_timer: Timer = $RestTimer
@onready var spawn_timer: Timer = $SpawnTimer

var min_spacing = 5
var time_since_last = 5
var rng = RandomNumberGenerator.new()
var wave_amt: int  = 0
var wave_index: int = 0

func _ready():
	intro_period = spawner_resource.intro_time
	rest_period = spawner_resource.wave_delay
	#rest_timer.wait_time = intro_period
	#spawn_timer.wait_time = spawn_period
	rest_timer.start(intro_period)
	

func type_to_spawn():
	return spawner_resource.wave[wave_index].instantiate()


func spawn():
	var random_number = rng.randf_range(0.0, 1.0)
	if random_number < spawn_rate:
		var entity = type_to_spawn()
		wave_index += 1
		var rand_offset_x = rng.randf_range(-50.0, 50.0)
		var rand_offset_y = rng.randf_range(-50.0, 50.0)
		entity.position = entity.position + spawn_offset + Vector2(rand_offset_x, rand_offset_y)
		self.add_child(entity)
		if entity.is_in_group('enemies'):
			var enemy : Enemy = entity
			enemy.set_target(target)

func wave_started() -> void:
	wave += 1
	wave_index = 0
	spawn_timer.start()

func wave_ended() -> void:
	spawn_timer.stop()
	rest_timer.start(rest_period)
	
func _on_rest_timer_timeout() -> void:
	rest_timer.stop()
	wave_started()

func _on_spawn_timer_timeout() -> void:
	spawn()
	if wave_index >= spawner_resource.wave.size():
		wave_ended()
	#if wave_amt >= wave_size:
