class_name Enemy
extends CharacterBody2D

## Base CharacterBody2D for different enemy types.
## Assuming all enemy types will extend CharacterBody, if not, we can later instead extend Node.

## The scene containing the scene of the enemy.
@export var scene:PackedScene

# Basic enemy subnodes
@onready var animated_sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var health_component:HealthComponent = $HealthComponent
@onready var hitbox:Hitbox = $Hitbox
@onready var collisionbox:CollisionShape2D = $CollisionShape2D
@onready var attack_timer:Timer = $AttackTimer
@onready var navigation:NavigationAgent2D = $NavigationAgent2D
@onready var audio_stream_player_attack = $AudioStreamPlayerAttack
@onready var audio_stream_player_death = $AudioStreamPlayerDeath

# Basic enemy properties to be set in the implementation
@export var speed:int
@export var acceleration:float
@export var damage:int

@export var dead:bool = false

var direction:Vector2 = Vector2()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if dead:
		return

	if navigation.target_position:
		direction = navigation.get_next_path_position() - global_position
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * speed, acceleration * delta)
				
		move_and_slide()
		set_sprite_direction(direction)


func set_sprite_direction(direction: Vector2):
	 # Check if there is significant movement
	if animated_sprite.animation == "move_right" or animated_sprite.animation == "move_left" or animated_sprite.animation ==  "move_down" or animated_sprite.animation ==  "move_up":
		if direction.length() > 0.3:
			if abs(direction.x) > abs(direction.y):
				# Horizontal movement
				hitbox.set_rotation(PI/2)
				collisionbox.set_rotation(PI/2)
				
				if direction.x > 0:
					animated_sprite.play("move_right")
				else:
					animated_sprite.play("move_left")
			else:
				# Vertical movement
				hitbox.set_rotation(PI)
				collisionbox.set_rotation(PI)
				
				if direction.y > 0:
					animated_sprite.play("move_down")
				else:
					animated_sprite.play("move_up")

func set_target(target : Node2D):
	navigation.target_position = target.global_position

func _on_health_component_damaged(damage):
	pass

func _on_health_component_died():
	if !dead:
		dead = true
		animated_sprite.play("die")
		audio_stream_player_death.play()

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
	audio_stream_player_attack.play()

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "die":
		queue_free()
