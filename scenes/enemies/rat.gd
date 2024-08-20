extends Enemy

class_name Rat
	
	
func _ready():
	rotate_collision = true

func _physics_process(delta):
	super(delta)
