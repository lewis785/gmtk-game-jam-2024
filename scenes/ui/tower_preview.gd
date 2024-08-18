extends Control

class_name TowerPreview

signal clicked(tower: Tower)

@onready var attack_label: Label = %AttackLabel
@onready var speed_label: Label = %SpeedLabel
@onready var cost_label: Label = %CostLabel
@onready var health_label: Label = %HealthLabel
@onready var tower_sprite: TextureRect = %TowerSprite
@onready var tower_label: Label = %TowerLabel

@export var tower : Tower

var camera : Camera

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ZoomManager.zoom_changed.connect(zoom_changed)
	tower_sprite.texture = tower.icon
	tower_label.text = tower.name
	zoom_changed(ZoomManager.zoom_level)

func zoom_changed(zoom_level : float):
	attack_label.text = str(round(ZoomManager.calculate_relative_value(tower.lower_damage, tower.upper_damage)))
	speed_label.text = str(round(ZoomManager.calculate_relative_value(tower.lower_attack_speed, tower.upper_attack_speed)))
	cost_label.text = str(tower.price)
	health_label.text = str(round(ZoomManager.calculate_relative_value(tower.lower_max_health, tower.upper_max_health)))

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
	 and event.pressed \
	 and event.button_index == MOUSE_BUTTON_LEFT:
		clicked.emit(tower)
