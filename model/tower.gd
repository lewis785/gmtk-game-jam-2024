class_name Tower
extends Resource

## Base resource for different tower types.
## This will be handy for placement of towers, can potentially add more data to
## these too

## The name of the tower.
@export var name:String

## The icon of the tower.
@export var icon:Texture2D

## The scene containing the scene of the tower.
@export var scene:PackedScene

## The scene for the placement ghost -> might change how this is done...
@export var ghost_scene:PackedScene

## Cost to build the tower
@export var price:int = 5

@export var attack_range : float = 350.0

@export var lower_attack_speed:float = 0.5
@export var upper_attack_speed:float = 5.0

@export var lower_damage: float = 5.0
@export var upper_damage: float = 50.0

@export var lower_max_health:float = 50.0
@export var upper_max_health:float = 300.0

## Instantiates the tower and initializes it with the 
## current item -> will be handy if we want more data stored here
#func instantiate() -> Node2D:
	#var result = scene.instantiate()
	#if result.has_method("initialize"):
		#result.initialize(self)
	#return result
