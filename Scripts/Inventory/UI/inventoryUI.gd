extends Node
class_name InventoryUI

@export_category("References")
@export var inventoryManager : InventoryManager
@export var rarityDatabase : RarityDatabase

@export_category("UI")
@export var inventoryUI : Control
@export var itemSlots : Array[itemSlot] = []
@export var itemSlot : PackedScene
@export var slotGrid : GridContainer

@export_category("Swapping")
@export var slotFrom : itemSlot
@export var storedItem : inventoryItem

@export_category("Debug")
@export var itemInput : TextEdit
@export var database : itemDatabase

func _ready():
	for i in 30:
		var newSlot = itemSlot.instantiate()
		slotGrid.add_child(newSlot)
		itemSlots.append(newSlot)
		newSlot.setSlotInventory(self)

func findNextEmptySlot():
	for slot in itemSlots:
		if !slot.item.item:
			return slot 

func _process(delta):
	if Input.is_action_just_pressed("inventory"):
		CursorManager.togglePause()
		toggleUI(CursorManager.isPaused)

func toggleUI(show : bool):
	if show:
		inventoryUI.show()
	else:
		inventoryUI.hide()
		
func setSlotItem(item : inventoryItem, itemSlotSet : itemSlot):
	itemSlotSet.item = item
	itemSlotSet.setSlotValues()

func debugItem():
	for item in database.items:
		if item.itemName == itemInput.text:
			inventoryManager.addItem(item, 1)

func itemSlotSelected(slotSelected : itemSlot):
	#if slot already selected swap the items
	if slotFrom:
		# to do:
		# stack stackables
		# swap non stackables
		# swap items of different types
		if slotFrom.item.item == slotSelected.item.item and slotFrom.item.item.canStack:
			# stack
			slotSelected.item.amount += slotFrom.item.amount
			slotFrom.item = inventoryItem.new()
			slotFrom.setSlotValues()
			slotSelected.setSlotValues()
			pass
		else:
			#swap
			swapItems(slotSelected)
	else:
		slotFrom = slotSelected

func swapItems(slotSelected : itemSlot):
	storedItem = slotSelected.item
	slotSelected.item = slotFrom.item
	slotFrom.item = storedItem
	slotSelected.setSlotValues()
	clearSwapInfo()

func clearSwapInfo():
	slotFrom.setSlotValues()
	
	slotFrom = null
	storedItem = inventoryItem.new()
