extends Node2D

class_name Target

@onready var health_component: HealthComponent = $HealthComponent
@onready var animated_sprite_2d = $AnimatedSprite2D


func _on_health_component_damaged(damage):
	# Play damage sound
	pass

func _on_health_component_died():
	animated_sprite_2d.play("die")
	# Play Game Over sound
	# End Game


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "die":
		get_tree().quit() 
