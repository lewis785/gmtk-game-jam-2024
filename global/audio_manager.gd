extends Node2D

@onready var save_path = "res://save-config.cfg"
@onready var config = ConfigFile.new()
@onready var load_response = config.load(save_path)

signal fx_toggled(new_state:bool)
signal music_toggled(new_state:bool)

var music_muted: bool
var fx_muted: bool

func _ready() -> void:
	music_muted = config.get_value("sound", "music_muted", false)
	fx_muted = config.get_value("sound", "fx_muted", false)
	
func _save_value(section, key, value):
	config.set_value(section, key, value)
	config.save(save_path)

func _load_value(section, key, default=null):
	return config.get_value(section, key, default)

func toggle_music():
	music_muted = !music_muted
	_save_value("sound", "music_muted", music_muted)
	AudioServer.set_bus_mute(1, music_muted)
	music_toggled.emit(music_muted)

func toggle_fx():
	fx_muted = !fx_muted
	_save_value("sound", "fx_muted", fx_muted)
	AudioServer.set_bus_mute(2, fx_muted)
	fx_toggled.emit(fx_toggled)
