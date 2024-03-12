extends Control

@export var mouseOnButton : bool
@export var selectedSlot : ItemSlot

func _process(delta):
	if Input.is_action_just_pressed("ui_leftClick"):
		if !mouseOnButton:
			hide()


func useItemButton():
	InventorySignalManager.emitUseItem(selectedSlot.itemInSlot.itemObject, 1)
	InventorySignalManager.emitToggleContextMenu(Vector2(0, 0), null)


func dropItemButton():
	InventorySignalManager.emitDropItem(selectedSlot.itemInSlot)
	InventorySignalManager.emitToggleContextMenu(Vector2(0, 0), null)



func mouseEnteredButton():
	mouseOnButton = true

func mouseExitedButton():
	mouseOnButton = false

