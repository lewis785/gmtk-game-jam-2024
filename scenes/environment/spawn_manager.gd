extends Node2D

@export var spawner : Spawner

@export var wave: int = 1;
@export_range(0.0, 30.0, 1.0) var rest_period: float = 20.0
@export_range(0.0, 10.0, 0.5) var spawn_period: float = 1.0

@onready var rest_timer: Timer = $RestTimer
@onready var spawn_timer: Timer = $SpawnTimer

signal wave_started

func _ready():
	rest_timer.wait_time = rest_period
	spawn_timer.wait_time = spawn_period

func wave_ended() -> void:
	rest_timer.start(rest_period)
	
func _on_rest_timer_timeout() -> void:
	rest_timer.stop()
	wave_started.emit();

func _on_spawn_timer_timeout() -> void:
	spawner.spawn()
