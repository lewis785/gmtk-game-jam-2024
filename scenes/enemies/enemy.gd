extends Enemy

class_name Rat

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	
	# Set basic attributes
	speed = 300
	acceleration = 7
	damage = 5
	
func _physics_process(delta):
	super(delta)
