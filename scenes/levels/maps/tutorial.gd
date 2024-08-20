extends CanvasLayer


@export var tips : Array[String]
var tip_index = 0

@onready var tutorial_tip: Label = %TutorialTip
@onready var skip_button: Button = %SkipButton
@onready var ok_button: Button = %OkButton
@onready var tutorial: CanvasLayer = %Tutorial
@onready var spawner: Spawner = %Spawner

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner.rest_timer.paused = true
	if tips.size() >= 1:
		show_tip()
	else:
		end_tutorial()

func end_tutorial():
	tutorial.hide()
	spawner.rest_timer.paused = false

func _on_skip_button_pressed() -> void:
	end_tutorial()

func _on_ok_button_pressed() -> void:
	tip_index += 1
	show_tip()

func show_tip():
	if tip_index >= tips.size():
		end_tutorial()
		return
	tutorial_tip.text = tips[tip_index]
