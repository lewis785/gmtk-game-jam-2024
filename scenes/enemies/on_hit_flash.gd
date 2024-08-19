extends Node2D

@export var animated_sprite : AnimatedSprite2D
@export var health_component : HealthComponent
@export var hit_flash_time : float = 0.1
@export var flash_delay_time : float = 0.2
@export var flash_brightness : float = 0.2

var hit_flash_timer : float = hit_flash_time
var ongoing_hit_flash : bool = false
var flash_delay_timer : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material.set_shader_parameter("FlashBrightness", flash_brightness)
	animated_sprite.material = material
	health_component.damaged.connect(_on_health_component_damaged)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animated_sprite and animated_sprite.material:
		if flash_delay_timer >= 0.0:
			flash_delay_timer -= delta
		if ongoing_hit_flash:
			hit_flash_timer -= delta
			if hit_flash_timer <= 0.0:
				animated_sprite.material.set_shader_parameter("Hit", false)
				hit_flash_timer = hit_flash_time
				ongoing_hit_flash = false

func _on_health_component_damaged(damage: int) -> void:
	if animated_sprite and animated_sprite.material:
		if flash_delay_timer <= 0.0:
			flash_delay_timer = flash_delay_time
			ongoing_hit_flash = true
			animated_sprite.material.set_shader_parameter("Hit", true)
