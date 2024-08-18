extends Area2D

class_name Level

@onready var target : Target = $Target
@onready var base_tile_map_layer : TileMapLayer = $BaseTileMapLayer

@export var level_size : Vector2 = Vector2()

func _on_area_exited(area: Area2D) -> void:
	area.queue_free()
	
