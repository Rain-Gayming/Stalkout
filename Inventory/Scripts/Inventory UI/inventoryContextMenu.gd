extends Control

@export var mouseOnButton : bool

func _process(delta):
	if Input.is_action_just_pressed("ui_leftClick"):
		if !mouseOnButton:
			InventorySignalManager.emitToggleContextMenu(Vector2(0, 0))


func useItemButton():
	print("using item")
	InventorySignalManager.emitToggleContextMenu(Vector2(0, 0))


func dropItemButton():
	InventorySignalManager.emitToggleContextMenu(Vector2(0, 0))



func mouseEnteredButton():
	mouseOnButton = true

func mouseExitedButton():
	mouseOnButton = false

