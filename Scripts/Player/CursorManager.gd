extends Node

@export var isPaused : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pass

func togglePause():
	isPaused = !isPaused
	print(CursorManager.isPaused)
