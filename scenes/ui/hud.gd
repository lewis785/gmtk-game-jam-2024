extends CanvasLayer

@export var selected_tower : Tower

@export var tower_types : Array[Tower]

@export var level : Level
@export var coin_manager: MoneyCoordinator

@onready var health_amount: Label = $MarginContainer/Stats/Health/HealthAmount
@onready var coin_amount: Label = $MarginContainer/Stats/Coin/CoinAmount
@onready var tower_menu: HBoxContainer = %TowerMenu

const TOWER_PREVIEW = preload("res://scenes/ui/tower_preview.tscn")

var _ghost
var target : Target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target = level.target
	
	update_health_bar(0.0)
	update_coin_amount(0.0)
	
	target.health_component.damaged.connect(update_health_bar)
	coin_manager.gold_changed.connect(update_coin_amount)

	for tower_type in tower_types: 
		var tower_preview : TowerPreview = TOWER_PREVIEW.instantiate()
		tower_preview.tower = tower_type
		tower_preview.clicked.connect(tower_click)
		tower_menu.add_child(tower_preview)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	# Mouse in viewport coordinates.
	if is_valid_to_place(event):
			var new_tower = selected_tower.scene.instantiate()
			new_tower.position = _ghost.get_global_mouse_position()
			get_parent().add_child(new_tower)
			if new_tower.has_method("initialize"):
				new_tower.initialize(selected_tower)

func is_valid_to_place(event: InputEvent) -> bool:
	return event is InputEventMouseButton \
	 and event.pressed \
	 and event.button_index == MOUSE_BUTTON_LEFT \
	 and _ghost \
	 and _ghost.is_placement_valid()

func update_health_bar(_damage: float):
	health_amount.text = str(target.health_component.health)
	
func update_coin_amount(_amount: int):
	coin_amount.text = str(coin_manager.gold)
	
func tower_click(tower : Tower):
	if _ghost != null:
		_ghost.queue_free()
	if (selected_tower == tower):
		selected_tower = null
		return
	selected_tower = tower
	_ghost = selected_tower.ghost_scene.instantiate()
	get_parent().add_child(_ghost) # Replace with function body.
