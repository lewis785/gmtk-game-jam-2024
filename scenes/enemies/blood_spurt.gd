extends GPUParticles2D

@export var health_component : HealthComponent
@export var collider : CollisionShape2D

@export var lower_damage_blood : float = 1
@export var upper_damage_blood : float = 10

@export var lower_particle_amount : float = 10
@export var upper_particle_amount : float = 80

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

func damaged(damage_amount):
	if damage_amount >= lower_damage_blood:
		if damage_amount >= upper_damage_blood:
			amount = upper_particle_amount
		else:
			amount = remap(damage_amount, lower_damage_blood, upper_damage_blood, lower_particle_amount, upper_particle_amount)
		position = Vector2(randf_range(-length/2, length/2), randf_range(-height/2, height/2))
		restart()
		emitting = true
	
