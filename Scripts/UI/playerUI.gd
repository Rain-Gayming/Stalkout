extends Node

@export_category("UI")
@export var hitMarker : Control
@export var currentHitMarkerTimer : float

func _ready():
	SignalManager.connect("hitMarker", showHitMarker)

func _process(delta):
	if currentHitMarkerTimer < 0:
		if hitMarker.visible:
			hitMarker.hide()
	else:
		currentHitMarkerTimer -= delta

func showHitMarker():
	if hitMarker.visible == false:
		hitMarker.show() 
		currentHitMarkerTimer = GameSettings.hitMarkerTime
