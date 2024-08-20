extends Enemy

class_name LeviathanHead

const BEAM = preload("res://scenes/projectiles/beam.tscn")
@onready var attack_range: Area2D = $AttackRange
@onready var projectile_spawn: Node2D = %ProjectileSpawn

var movement_speed: int
var base_attack_speed: float

func _ready() -> void:
	super()
	movement_speed = speed
	base_attack_speed = attack_timer.wait_time

func _physics_process(delta):
	super(delta)

func _on_attack_range_area_entered(area: Area2D) -> void:
	if dead || area is not Hitbox:
		return
		
	speed = 0
	fire_laser(area.global_position)
	attack_timer.start()

func fire_laser(target: Vector2):
	var laser: Beam = BEAM.instantiate()
	laser.damage = damage
	laser.set_deferred("speed", 600)
	laser.speed = 600
	laser.collision_mask = 4
	laser.target = target
	projectile_spawn.call_deferred("add_child", laser)
	attack_timer.wait_time = max(attack_timer.wait_time - 0.05, 0.1)
	
func _on_attack_timer_timeout() -> void:
	if dead:
		attack_timer.stop()
		return
		
	var areas = attack_range.get_overlapping_areas()
	
	for area in areas:
		if area is Hitbox:
			fire_laser(area.global_position)
			return
			
	speed = movement_speed
	attack_timer.wait_time = base_attack_speed
	attack_timer.stop()
