extends Control
class_name ItemSlot

@export_category("Items")
@export var itemInSlot : InventoryItem

@export_category("UI")
@export var itemIcon : TextureRect
@export var amountText : RichTextLabel
@export var mouseHovered : bool

func _ready():
	updateUI()

func setItem(item : InventoryItem):
	itemInSlot = item
	updateUI()

func _process(delta):
	if Input.is_action_just_pressed("ui_rightClick"):
		if mouseHovered:
			contextMenuToggle()
	if Input.is_action_just_pressed("ui_leftClick"):
		if mouseHovered:
			itemSlotPressed()

func updateUI():
	if itemInSlot != null:
		if itemInSlot.itemObject:
			
			print(itemInSlot.itemObject.itemName)
			itemIcon.texture = itemInSlot.itemObject.itemSprite
			itemIcon.show()
			
			if itemInSlot.itemAmount > 1:
				amountText.show()
				amountText.text = "[right] " + str(itemInSlot.itemAmount) + "[/right]"
			else:
				amountText.hide()
	else:
		itemIcon.hide()
		amountText.hide()

func contextMenuToggle():
	InventorySignalManager.emitToggleContextMenu(position, self)


func itemSlotPressed():
	InventorySignalManager.emitSlotClicked(self)


func mouseEntered():
	mouseHovered = true

func mouseExited():
	mouseHovered = false
