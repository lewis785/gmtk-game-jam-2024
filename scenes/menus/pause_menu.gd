extends Control

class_name PauseMenu

@onready var fx_volume: HSlider = $ColorRect/VBoxContainer/FxContainer/FxVolume
@onready var music_volume: HSlider = $ColorRect/VBoxContainer/MusicContainer/MusicVolume

@onready var paused : bool = false

func _ready():
	music_volume.value = AudioManager.music_volume
	fx_volume.value = AudioManager.fx_volume

func _on_music_volume_value_changed(value: float) -> void:
	AudioManager.set_music_volume(value)

func _on_fx_volume_value_changed(value: float) -> void:
	AudioManager.set_fx_volume(value)

func _input(event):
	if event.is_action_pressed("PauseToggle"):
		toggle_pause()
		
func toggle_pause():
	if paused:
		paused = false
	else:
		paused = true
	visible = paused
	get_tree().paused = paused


func _on_button_pressed():
	toggle_pause()
