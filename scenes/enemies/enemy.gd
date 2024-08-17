extends RigidBody2D

class_name Enemy


@onready var health_component : HealthComponent = $HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Set position, direction and velocity of Enemy movement
func _set_movement(spawn_location : PathFollow2D):
	# Choose a random location to spawn.
	var enemy_spawn_location = spawn_location
	#enemy_spawn_location.progress_ratio = randf()
	
	# Set the enemy's direction perpendicular to the path direction.
	var direction = enemy_spawn_location.rotation 

	# Set the enemy's position to a random location
	position = enemy_spawn_location.position
	
	# Choose the velocity for the enemy.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	linear_velocity = velocity.rotated(direction)
	
func _on_health_component_damaged(damage):
	print("Enemy hit")
	health_component.damaged.emit()

func _on_health_component_died():
	print("Enemy died")
	health_component.died.emit()
