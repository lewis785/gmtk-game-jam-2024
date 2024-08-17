extends Node2D

@export var health_component : HealthComponent
@onready var progress_bar: ProgressBar = %ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.damaged.connect(damaged)
	health_component.healed.connect(healed)
	progress_bar.max_value = health_component.max_health
	set_bar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func damaged(_damage):
	set_bar()

func healed(_heal):
	set_bar()

func set_bar():
	progress_bar.value = health_component.health
