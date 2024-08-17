extends Node2D

@onready var config: ConfigComponent = $ConfigComponent

signal fx_toggled(new_state:bool)
signal music_toggled(new_state:bool)

var music_muted: bool
var fx_muted: bool

func _ready() -> void:
	music_muted = config.load_value("sound", "music_muted", false)
	fx_muted = config.load_value("sound", "fx_muted", false)

func toggle_music():
	music_muted = !music_muted
	config.save_value("sound", "music_muted", music_muted)
	AudioServer.set_bus_mute(1, music_muted)
	music_toggled.emit(music_muted)

func toggle_fx():
	fx_muted = !fx_muted
	config.save_value("sound", "fx_muted", fx_muted)
	AudioServer.set_bus_mute(2, fx_muted)
	fx_toggled.emit(fx_muted)
