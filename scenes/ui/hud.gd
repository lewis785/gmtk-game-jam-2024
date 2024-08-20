extends CanvasLayer

@export var selected_tower : Tower

@export var tower_types : Array[Tower]

@onready var health_amount: Label = $MarginContainer/Stats/Health/HealthAmount
@onready var coin_amount: Label = $MarginContainer/Stats/Coin/CoinAmount
@onready var tower_menu: HBoxContainer = %TowerMenu
@onready var game_over_node: GameOverMenu = $GameOver
@onready var camera = $"../Camera"
@onready var zoom_label: Label = %ZoomLabel
@onready var wave_indicator: WaveIndicator = %WaveIndicator

const TOWER_PREVIEW = preload("res://scenes/ui/tower_preview.tscn")

var level : Level
var _ghost: TowerGhost
var target : Target

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if level:
		setup()

func _process(_delta):
	if !target and level:
		setup()

func setup():
	target = level.target
	wave_indicator.spawner = level.spawner
	
	target.health_component.damaged.connect(update_health_bar)
	level.lose.connect(game_over)
	level.win.connect(win_level)
	MoneyCoordinator.gold_changed.connect(update_coin_amount)
	
	update_health_bar(0.0)
	update_coin_amount(0.0)

	for tower_type in tower_types: 
		var tower_preview : TowerPreview = TOWER_PREVIEW.instantiate()
		tower_preview.tower = tower_type
		tower_preview.clicked.connect(tower_click)
		tower_menu.add_child(tower_preview)

func _unhandled_input(event: InputEvent) -> void:
	#zoom_label.text = str(camera.zoom)
	
	if !is_valid_to_place(event):
		return

	MoneyCoordinator.remove_gold(selected_tower.price)
	var new_tower = selected_tower.scene.instantiate()
	new_tower.position = _ghost.get_global_mouse_position()
	get_parent().add_child(new_tower)
	if new_tower.has_method("initialize"):
		new_tower.initialize(selected_tower, 1 / camera.zoom.x)

func is_valid_to_place(event: InputEvent) -> bool:
	if !(event is InputEventMouseButton) || !event.pressed || event.button_index != MOUSE_BUTTON_LEFT:
		return false
		
	if !_ghost || !_ghost.is_placement_valid():
		return false
		
	return MoneyCoordinator.can_afford(selected_tower.price)

func update_health_bar(_damage: float):
	health_amount.text = str(max(target.health_component.health, 0))
	
func update_coin_amount(_amount: int):
	coin_amount.text = str(MoneyCoordinator.gold)
	if _ghost != null:
		_ghost.affordable = MoneyCoordinator.can_afford(selected_tower.price)
	
func tower_click(tower : Tower):
	if _ghost != null:
		_ghost.queue_free()
	if (selected_tower == tower):
		selected_tower = null
		return
	selected_tower = tower
	_ghost = selected_tower.ghost_scene.instantiate()
	_ghost.affordable = MoneyCoordinator.can_afford(selected_tower.price)
	_ghost.map_resolution = level.level_size * 64
	_ghost.camera = camera
	_ghost.tower = tower
	get_parent().add_child(_ghost)
	
func game_over():
	game_over_node.game_over = true
	game_over_node.text = 'GAME OVER'
	
func win_level():
	game_over_node.game_over = true
	game_over_node.text = 'YOU WIN'
	
func _input(event):
	if event.is_action_pressed("CancelTowerPlace"):
		if _ghost != null:
			_ghost.queue_free()
		if selected_tower != null:
			selected_tower = null
		
