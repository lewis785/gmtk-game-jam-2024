extends RigidBody2D

var bullet = preload("res://scenes/tower/bullet.tscn")
@export var test_target : Sprite2D
@onready var range_collision_shape = %RangeCollisionShape
@onready var attack_range = $AttackRange
@onready var health_component: HealthComponent = %HealthComponent
@onready var timer: Timer = %Timer

var bullet_damage : float


func initialize(tower : Tower):
	timer.wait_time = tower.shoot_frequency
	
	# Initialise health component variables
	health_component.max_health = tower.max_health
	health_component.health = tower.max_health

	bullet_damage = tower.damage

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var collisions: Array[Area2D] = attack_range.get_overlapping_areas()
	if collisions.size() >= 1:
		var new_bullet : Bullet = bullet.instantiate()
		add_child(new_bullet)
		new_bullet.look_at(collisions[0].global_position)
		new_bullet.damage = bullet_damage


func _on_health_component_damaged(damage: int) -> void:
	pass

func _on_health_component_died() -> void:
	queue_free() # Replace with function body.
