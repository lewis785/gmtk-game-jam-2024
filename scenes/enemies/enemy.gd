extends CharacterBody2D

class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent
@onready var nav : NavigationAgent2D = $NavigationAgent2D
@onready var attack_timer: Timer = %AttackTimer
@onready var hitbox: Hitbox = %Hitbox
@onready var animated_sprite_2d = $AnimatedSprite2D

@export var speed = 300
@export var accel = 7
@export var damage = 5

var dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if dead:
		return
	
	if nav.target_position:
		var direction = Vector3()
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		
		# Change sprite depending on direction of travel
		if direction.y >= 0:
			animated_sprite_2d.play("move_down")
		elif direction.y <= 0:
			animated_sprite_2d.play("move_up")
		
		velocity = velocity.lerp(direction * speed, accel * delta)
		
		move_and_slide()
		set_sprite_direction(direction)

func set_target(target : Node2D):
	nav.target_position = target.global_position
	
func set_sprite_direction(direction: Vector2):
	 # Check if there is significant movement
	if direction.length() > 0.1:
		if abs(direction.x) > abs(direction.y):
			# Horizontal movement
			if direction.x > 0:
				animated_sprite_2d.play("move_right")
			else:
				animated_sprite_2d.play("move_left")
		else:
			# Vertical movement
			if direction.y > 0:
				animated_sprite_2d.play("move_down")
			else:
				animated_sprite_2d.play("move_up")

func _on_health_component_damaged(damage):
	pass

func _on_health_component_died():
	if !dead:
		dead = true
		animated_sprite_2d.play("die")


func _on_hitbox_area_entered(body: Node2D) -> void:
	if !dead:
		if body is Hitbox:
			attack_timer.start()


func _on_attack_timer_timeout() -> void:
	if !dead:
		var bodies = hitbox.get_overlapping_areas()
		for body in bodies:
			if body is Hitbox:
				_deal_attack_damage(body)
				return
	attack_timer.stop()
	
func _deal_attack_damage(body: Hitbox):
	var attack = Attack.new()
	attack.damage = damage
	body.damage(attack)

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "die":
		queue_free()
