extends GPUParticles2D

@export var health_component : HealthComponent
@export var collider : CollisionShape2D

var length : float = 0
var height : float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_component.damaged.connect(damaged)
	if collider:
		var rect = collider.shape.get_rect()
		if rect:
			length = collider.shape.get_rect().size.x
			height = collider.shape.get_rect().size.y
		else:
			length = collider.radius
			height = collider.radius


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func damaged(_damage_amount):
	position = Vector2(randf_range(-length/2, length/2), randf_range(-height/2, height/2))
	restart()
	emitting = true
	
