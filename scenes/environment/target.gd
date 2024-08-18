extends Node2D

class_name Target

@onready var health_component: HealthComponent = $HealthComponent
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player_hit = $AudioStreamPlayerHit
@onready var audio_stream_player_death = $AudioStreamPlayerDeath

signal end_game

func _on_health_component_damaged(damage):
	audio_stream_player_hit.play()

func _on_health_component_died():
	audio_stream_player_death.play()
	animated_sprite_2d.play("die")

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "die":
		end_game.emit()
