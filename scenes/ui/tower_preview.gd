extends Control

@onready var attack_label: Label = %AttackLabel
@onready var speed_label: Label = %SpeedLabel
@onready var cost_label: Label = %CostLabel
@onready var health_label: Label = %HealthLabel
@onready var tower_sprite: TextureRect = %TowerSprite
@onready var tower_label: Label = %TowerLabel

@export var tower : Tower

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	attack_label.text = str(tower.damage)
	speed_label.text = str(tower.shoot_frequency) #TODO: how do we present this?
	cost_label.text = str(tower.price)
	health_label.text = str(tower.max_health)
	tower_sprite.texture = tower.icon
	tower_label.text = tower.name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# TODO: scale values with size
	pass
