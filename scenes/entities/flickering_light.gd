extends PointLight2D

class_name FlickeringLight

@export_range(0.0, 1.0, 0.01) var frequency:float = 0.3
@export_range(2.0, 10.0, 1.0) var variation:float = 4.0

@onready var noise = FastNoiseLite.new()

var time_duration: float = 0.0
var base_energy: float

func _ready() -> void:
	base_energy = energy;
	noise.frequency = frequency;
	
func _physics_process(delta: float) -> void:
	time_duration += delta
	energy = ((noise.get_noise_1d(time_duration) + 1) / variation) + base_energy
