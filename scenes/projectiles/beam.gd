extends Area2D

class_name Beam

@export var speed: float = 200.0
@export var damage : float = 20.0
@export var target : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	look_at(target)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += (Vector2.RIGHT.rotated(rotation) * speed * delta)

func _on_area_entered(body: Area2D) -> void:
	if body is Hitbox:
		var attack : Attack = Attack.new()
		attack.damage = damage
		body.damage(attack)
		queue_free()
