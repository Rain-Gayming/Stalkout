extends Node
class_name InventoryUI

@export_category("References")
@export var inventoryManager : InventoryManager

@export_category("UI")
@export var itemSlots : Array[itemSlot] = []
@export var itemSlot : PackedScene
@export var slotGrid : GridContainer

@export_category("Debug")
@export var itemInput : TextEdit
@export var database : itemDatabase

func _ready():
	for i in 30:
		var newSlot = itemSlot.instantiate()
		slotGrid.add_child(newSlot)
		itemSlots.append(newSlot)

func findNextEmptySlot():
	for slot in itemSlots:
		if !slot.item.item:
			return slot 

func setSlotItem(item : inventoryItem, itemSlotSet : itemSlot):
	itemSlotSet.item = item
	itemSlotSet.setSlotValues()

func debugItem():
	for item in database.items:
		if item.itemName == itemInput.text:
			inventoryManager.addItem(item, 1)
