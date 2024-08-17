extends Area2D

class_name Level

@onready var target : Target = $Target

func _on_area_exited(area: Area2D) -> void:
	area.queue_free()
