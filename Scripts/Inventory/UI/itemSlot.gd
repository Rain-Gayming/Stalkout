extends Node
class_name itemSlot

@export_category("Items")
@export var item : inventoryItem

@export_category("UI")
@export var itemRarity : ColorRect
@export var itemIcon : TextureRect

func _ready():
	item = inventoryItem.new()
	setSlotValues()

func setSlotValues():
	if item.item:
		itemRarity.visible = true
		
		itemIcon.visible = true
		itemIcon.texture = item.item.itemIcon
	else:
		itemRarity.visible = false
		
		itemIcon.visible = false
