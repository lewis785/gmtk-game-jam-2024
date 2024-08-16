extends Node2D

@export var spawner : Spawner

func _on_timer_timeout():
	spawner.spawn()
