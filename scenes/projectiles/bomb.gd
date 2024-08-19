extends Path2D

class_name Bomb

@export var blast_radius: int = 64
@export var damage: int = 50
@export var speed: int = 200
@export var target: Vector2

var exploding = false

@onready var path_follow_2d: PathFollow2D = $PathFollow2D
@onready var blast_area: Area2D = $PathFollow2D/Area2D/BlastRadius
@onready var sprite_2d: AnimatedSprite2D = %Sprite2D

func _ready() -> void:
	curve.set_point_out(0, Vector2(target.x / 2, -500))
	curve.set_point_position(1, target)
	
func _process(delta: float) -> void:
	if not target: return
	if exploding: 
		return
	if path_follow_2d.progress_ratio >= 0.98:
		detonate()
	path_follow_2d.progress += speed * delta

func detonate():
	var all_targets = blast_area.get_overlapping_areas()
	var attack = Attack.new()
	attack.damage = damage

	for target in all_targets:
		if target is Hitbox && target.get_parent().is_in_group("enemies"):
			target.damage(attack)
		
	exploding = true
	sprite_2d.play("explode")
	var tree = get_tree()
	if tree:
		await tree.create_timer(1.0).timeout
	queue_free()
