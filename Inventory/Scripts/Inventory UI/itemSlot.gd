extends Control
class_name ItemSlot

@export_category("Items")
@export var itemInSlot : InventoryItem

@export_category("UI")
@export var itemIcon : TextureRect
@export var amountText : RichTextLabel

func setItem(item : InventoryItem):
	itemInSlot = item
	updateUI()

func updateUI():
	
	if itemInSlot != null:
		if itemInSlot.itemObject:
			
			print(itemInSlot.itemObject.itemName)
			itemIcon.texture = itemInSlot.itemObject.itemSprite
			itemIcon.show()
			
			if itemInSlot.itemAmount > 1:
				amountText.show()
				amountText.text = str(itemInSlot.itemAmount)
			else:
				amountText.hide()
	else:
		itemIcon.hide()
		amountText.hide()

func contextMenuToggle():
	InventorySignalManager.emitToggleContextMenu(position, self)
