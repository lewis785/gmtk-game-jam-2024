extends CharacterBody2D

class_name Enemy

@onready var health_component : HealthComponent = $HealthComponent
@onready var nav : NavigationAgent2D = $NavigationAgent2D
@onready var attack_timer: Timer = %AttackTimer
@onready var hitbox: Hitbox = %Hitbox

@export var speed = 300
@export var accel = 7
@export var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	
	if nav.target_position:
		var direction = Vector3()
		direction = nav.get_next_path_position() - global_position
		direction = direction.normalized()
		
		velocity = velocity.lerp(direction * speed, accel * delta)
		
		move_and_slide()

func set_target(target : Node2D):
	nav.target_position = target.global_position
	
func _on_health_component_damaged(damage):
	pass

func _on_health_component_died():
	queue_free()


func _on_hitbox_area_entered(body: Node2D) -> void:
	if body is Hitbox:
		attack_timer.start()


func _on_attack_timer_timeout() -> void:
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
