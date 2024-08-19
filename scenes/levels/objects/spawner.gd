extends Node2D

class_name Spawner

signal wave_start(wave : int)
signal wave_end(wave : int)
signal all_waves_complete()

@onready var rat : PackedScene = preload("res://scenes/enemies/rat.tscn")
@onready var leviathan : PackedScene = preload("res://scenes/enemies/leviathan.tscn")

## TODO: move spawn_rates etc. into Wave resource

@export_range(0.0, 1.0, 0.1) var spawn_rate = 0.1
@export var spawn_offset : Vector2 = Vector2(0,0)
@export var target : Node2D

var intro_period: float = 5.0
var rest_period: float = 10.0
@export_range(0.0, 10.0, 0.1) var spawn_period: float = 0.5

@export var spawner_resource: SpawnModel

@onready var rest_timer: Timer = $RestTimer
@onready var spawn_timer: Timer = $SpawnTimer

var min_spacing = 5
var time_since_last = 5
var rng = RandomNumberGenerator.new()

# Data for the enemy needed for each wave
var waves : Array[WaveModel]
# The current wave
var wave_index: int = 0

# Enemies to be spawned in the current wave
var wave_entites : Array[Enemy]
# Enemies left that need to be killed for the wave to be complete
var enemies_left_in_wave : int = 0

func _ready():
	intro_period = spawner_resource.intro_time
	rest_period = spawner_resource.wave_delay
	waves = spawner_resource.waves
	rest_timer.start(intro_period)

func _setup_wave(wave_index : int):
	# Instantiate everything in the wave up front, then we just pick them from 
	# the array when needed
	var wave = waves[wave_index]
	for i in range(0, wave.leviathan_count): _add_enemy(leviathan)
	for i in range(0, wave.rat_count): _add_enemy(rat)
	enemies_left_in_wave = wave_entites.size()

func _add_enemy(enemy_scene : PackedScene):
	var enemy = enemy_scene.instantiate()
	wave_entites.append(enemy)
	enemy.find_child("HealthComponent").died.connect(enemy_died)

func select_spawn_entity():
	var enemy : Enemy = wave_entites.pick_random()
	wave_entites.erase(enemy)
	return enemy

func spawn():
	var random_number = rng.randf_range(0.0, 1.0)
	if random_number < spawn_rate:
		var entity = select_spawn_entity()
		var rand_offset_x = rng.randf_range(-50.0, 50.0)
		var rand_offset_y = rng.randf_range(-50.0, 50.0)
		entity.position = entity.position + spawn_offset + Vector2(rand_offset_x, rand_offset_y)
		self.add_child(entity)
		if entity.is_in_group('enemies'):
			var enemy : Enemy = entity
			enemy.set_target(target)

func wave_started() -> void:
	wave_start.emit(wave_index)
	_setup_wave(wave_index)
	spawn_timer.start()

func wave_ended() -> void:
	spawn_timer.stop()
	rest_timer.start(rest_period)
	wave_end.emit(wave_index)
	wave_index += 1
	if wave_index >= waves.size():
		print("You Win")
		all_waves_complete.emit()
		## TODO: trigger next level.
		#get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")
		wave_index -= 1 # For now we just repeat the last wave....

func _on_rest_timer_timeout() -> void:
	rest_timer.stop()
	wave_started()

func _on_spawn_timer_timeout() -> void:
	if !wave_entites.is_empty():
		spawn()
	
func enemy_died() -> void:
	enemies_left_in_wave -= 1
	if enemies_left_in_wave == 0:
		wave_ended()
