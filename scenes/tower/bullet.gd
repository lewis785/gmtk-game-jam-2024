extends Area2D

class_name Bullet

@export var speed: float = 200.0
@export var damage : float = 20.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += (Vector2.RIGHT.rotated(rotation) * speed * delta)

func _on_body_entered(body: Node) -> void:
	var health = body.find_child("HealthComponent")
	if health:
		_deal_damage(health)
	queue_free()

func _deal_damage(target_health: HealthComponent):
	var attack : Attack = Attack.new()
	attack.damage = damage
	target_health.damage(attack)
