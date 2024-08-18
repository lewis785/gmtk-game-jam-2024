extends Node2D

@onready var config: ConfigComponent = $ConfigComponent
var music = AudioServer.get_bus_index("Music")
var fx = AudioServer.get_bus_index("Fx")

signal fx_toggled(new_state:bool)
signal music_toggled(new_state:bool)

var music_muted: bool
var fx_muted: bool
var music_volume: float = 100.0
var fx_volume: float = 100.0

func _ready() -> void:
	music_muted = config.load_value("sound", "music_muted", false)
	fx_muted = config.load_value("sound", "fx_muted", false)
	set_music_volume(config.load_value("sound", "music_volume", 100.0))
	set_fx_volume(config.load_value("sound", "fx_volume", 100.0))
	
func set_music_volume(value: float):
	music_volume = value
	config.save_value("sound", "music_volume", value)
	AudioServer.set_bus_volume_db(music, linear_to_db(clamp(value, 0.0, 1.0)))

func set_fx_volume(value: float):
	fx_volume = value
	config.save_value("sound", "fx_volume", value)
	AudioServer.set_bus_volume_db(fx, linear_to_db(clamp(value, 0.0, 1.0)))

func toggle_music():
	music_muted = !music_muted
	config.save_value("sound", "music_muted", music_muted)
	AudioServer.set_bus_mute(music, music_muted)
	music_toggled.emit(music_muted)

func toggle_fx():
	fx_muted = !fx_muted
	config.save_value("sound", "fx_muted", fx_muted)
	AudioServer.set_bus_mute(fx, fx_muted)
	fx_toggled.emit(fx_muted)
