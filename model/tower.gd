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

## Cost to build the tower
@export var price:int = 5

# TODO: maybe a "placement type" or something -> small towers free form, 
#       big towers on specific locations?

# These things could be here to keep things together? 
# But maybe restricts us on how different towers can work, so would be better
# just on the tower scripts with default values there
#@export var shoot_frequency:float = 1.0
#@export var damage: float = 1.0
#@export var bullet:PackedScene
#@export var max_health:float = 100.0



## Instantiates the tower and initializes it with the 
## current item -> will be handy if we want more data stored here
#func instantiate() -> Node2D:
	#var result = scene.instantiate()
	#if result.has_method("initialize"):
		#result.initialize(self)
	#return result
