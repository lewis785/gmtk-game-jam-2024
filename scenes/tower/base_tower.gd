extends RigidBody2D

class_name BaseTower


# Things we need to scale.....
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var range_collision_shape: CollisionShape2D = $AttackRange/RangeCollisionShape
@onready var tower_collision_shape: CollisionShape2D = $TowerCollisionShape
@onready var hitbox_collision_shape: CollisionShape2D = $Hitbox/HitboxCollisionShape
@onready var health_component: HealthComponent = $HealthComponent
@onready var timer: Timer = $Timer

var damage : float

func initialize(tower : Tower, tower_scale : float):
	var speed = ZoomManager.calculate_relative_value(tower.lower_attack_speed, tower.upper_attack_speed)
	timer.wait_time = 1.0 / speed
	health_component.max_health = ZoomManager.calculate_relative_value(tower.lower_max_health, tower.upper_max_health)
	health_component.health = health_component.max_health
	damage = ZoomManager.calculate_relative_value(tower.lower_damage, tower.upper_damage)
	scale_tower(tower_scale)

func scale_tower(tower_scale: float) -> void:
		# Rigid Bodies cannot be scaled, so we need to scale everything else...
	print("Scaling everything to tower scale: " + str(tower_scale))
	sprite_2d.scale = Vector2(tower_scale, tower_scale)
	
	var new_collision_shape = RectangleShape2D.new()
	new_collision_shape.size = Vector2(tower_collision_shape.shape.get_rect().size.x, tower_collision_shape.shape.get_rect().size.y) * Vector2(tower_scale, tower_scale)
	tower_collision_shape.set_shape(new_collision_shape)
	tower_collision_shape.position *= tower_scale

	var new_hitbox_shape = RectangleShape2D.new()
	new_hitbox_shape.size = Vector2(hitbox_collision_shape.shape.get_rect().size.x, hitbox_collision_shape.shape.get_rect().size.y) * Vector2(tower_scale, tower_scale)
	hitbox_collision_shape.set_shape(new_hitbox_shape)
	hitbox_collision_shape.position *= tower_scale	
	
	print("new range collision shape starting radius is " + str(range_collision_shape.shape.radius))
	range_collision_shape.shape.radius *= tower_scale
	print("now it is is " + str(range_collision_shape.shape.radius))
	
