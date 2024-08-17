extends Node

@export var enemy_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _on_start_timer_timeout():
	print("Game started")
	$EnemySpawnTimer.start()

func _on_enemy_spawn_timer_timeout():
	print("Enemy spawned")
	_spawn_enemy()

# Spawn enemy and set position and direction
func _spawn_enemy():
		# Create a new instance of the Enemy.
	var enemy = enemy_scene.instantiate()
	
	enemy._set_movement($EnemyPath/EnemySpawnLocation)
	
	# Add enemy to scene
	add_child(enemy)
