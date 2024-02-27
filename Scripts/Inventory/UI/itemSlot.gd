extends Node
class_name itemSlot

@export_category("References")
@export var inventoryUI : InventoryUI

@export_category("Items")
@export var item : inventoryItem

@export_category("UI")
@export var itemRarity : ColorRect
@export var itemIcon : TextureRect

func _ready():
	item = inventoryItem.new()
	setSlotValues()

func setSlotInventory(inventory : InventoryUI):
	inventoryUI = inventory

func setSlotValues():
	if item.item:
		itemRarity.visible = true
		
		itemIcon.visible = true
		itemIcon.texture = item.item.itemIcon
		
		for rar in inventoryUI.rarityDatabase.rarities:
			if item.item.itemRarity == rar.rarityType:
				itemRarity.color = rar.rarityColour
	else:
		itemRarity.visible = false
		
		itemIcon.visible = false


func itemSlotPressed():
	inventoryUI.itemSlotSelected(self)
