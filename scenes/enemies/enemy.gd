extends CharacterBody2D

class_name Enemy


@onready var health_component : HealthComponent = $HealthComponent
@onready var nav : NavigationAgent2D = $NavigationAgent2D

@export var speed = 300
@export var accel = 7

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var direction = Vector3()
	
	nav.target_position = get_global_mouse_position()
	
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()

## Set position, direction and velocity of Enemy movement
#func _set_movement(spawn_location : PathFollow2D):
	## Choose a random location to spawn.
	#var enemy_spawn_location = spawn_location
	##enemy_spawn_location.progress_ratio = randf()
	#
	## Set the enemy's direction perpendicular to the path direction.
	#var direction = enemy_spawn_location.rotation 
#
	## Set the enemy's position to a random location
	#position = enemy_spawn_location.position
	#
	## Choose the velocity for the enemy.
	#var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	#linear_velocity = velocity.rotated(direction)
	
func _on_health_component_damaged(damage):
	print("Enemy hit")

func _on_health_component_died():
	print("Enemy died")
