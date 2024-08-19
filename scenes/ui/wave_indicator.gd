class_name WaveIndicator
extends PanelContainer


@onready var label: Label = $MarginContainer/Label

@onready var spawner : Spawner = %Spawner:
	set(value):
		spawner = value
		spawner.wave_start.connect(_on_wave_start)
		spawner.wave_end.connect(_on_wave_end)
		spawner.all_waves_complete.connect(_on_all_waves_complete)

func _ready():
	pass

func _on_wave_start(wave : int):
	label.text = "Wave " + str(wave + 1)

func _on_wave_end(wave : int):
	label.text = "Wave " + str(wave + 1) + " complete!"
	
func _on_all_waves_complete():
	label.text = "All waves complete!"
