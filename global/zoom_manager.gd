extends Node2D

# Lower cap for the `_zoom_level`.
@export var min_zoom : float = 0.5
# Upper cap for the `_zoom_level`.
@export var max_zoom : float = 2.0

signal zoom_changed(new_zoom_level : float)

var zoom_level : float = 1.0:
	set(value):
		zoom_level = clamp(value, min_zoom, max_zoom)
		zoom_changed.emit(zoom_level)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func calculate_relative_value(lower : float, upper : float) -> float:
	var slope = (upper - lower) / (min_zoom - max_zoom)
	return lower + slope * (zoom_level - max_zoom)
	
