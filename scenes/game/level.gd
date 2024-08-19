extends Area2D

class_name Level

@onready var target : Target = $Target
@onready var base_tile_map_layer : TileMapLayer = $BaseTileMapLayer

@onready var camera : Camera = $"../Camera"
@onready var hud = $"../Hud"
@onready var spawner: Spawner = %Spawner

@export var level_size : Vector2 = Vector2()
@export var health: int = 200
@export var start_gold: int = 100

signal win
signal lose

# Called when the node enters the scene tree for the first time.
func _ready():
	camera.level = self
	hud.level = self
	
	target.set_health(health) 
	MoneyCoordinator.gold = start_gold
	
func _on_area_exited(area: Area2D) -> void:
	area.queue_free()
	
func game_end_win():
	win.emit()
	
func game_end_lose():
	lose.emit()
