extends Node2D

@export var level_1 : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():

	var level : Level = level_1.instantiate()
	self.add_child(level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
