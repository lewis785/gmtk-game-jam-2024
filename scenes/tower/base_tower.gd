extends RigidBody2D

class_name BaseTower


# Things we need to scale.....
@onready var sprite_2d: AnimatedSprite2D = %Sprite
@onready var range_collision_shape: CollisionShape2D = %AttackRangeCollisionShape
@onready var tower_collision_shape: CollisionShape2D = %TowerCollisionShape
@onready var hitbox_collision_shape: CollisionShape2D = %HitboxCollisionShape
@onready var health_component: HealthComponent = %HealthComponent
@onready var timer: Timer = $Timer

var tower_scale : float

var damage : float

func initialize(tower : Tower, tower_scale : float):
	self.tower_scale = tower_scale
	var speed = ZoomManager.calculate_relative_value(tower.lower_attack_speed, tower.upper_attack_speed)
	timer.wait_time = 1.0 / speed
	health_component.max_health = ZoomManager.calculate_relative_value(tower.lower_max_health, tower.upper_max_health)
	health_component.health = health_component.max_health
	damage = ZoomManager.calculate_relative_value(tower.lower_damage, tower.upper_damage)
	scale_tower(tower_scale, tower)

func scale_tower(tower_scale: float, tower : Tower) -> void:
	# Rigid Bodies cannot be scaled, so we need to scale everything else...
	sprite_2d.scale = Vector2(tower_scale, tower_scale)
	_scale_rect_collision_shape(tower_collision_shape, tower_scale)
	_scale_rect_collision_shape(hitbox_collision_shape, tower_scale)
	range_collision_shape.shape.radius = tower.attack_range * tower_scale

func _scale_rect_collision_shape(collision : CollisionShape2D, tower_scale : float):
	var new_collision_shape = RectangleShape2D.new()
	new_collision_shape.size = Vector2(collision.shape.get_rect().size.x, collision.shape.get_rect().size.y) * Vector2(tower_scale, tower_scale)
	collision.set_shape(new_collision_shape)
	collision.position *= tower_scale
