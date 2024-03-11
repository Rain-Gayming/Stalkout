extends Node

@export var debugAdd : InventoryItem

@export_category("Inventory Manager")
@export_group("Items")
@export var maxItems : int
@export var inventoryItems : Array[InventoryItem]
@export var itemObjects : Array[ItemObject]

@export_category("UI")
@export var itemSlots : Array[ItemSlot]

func _process(delta):
	if Input.is_action_just_pressed("debug_console"):
		addItem(debugAdd)

func addItem(itemToAdd : InventoryItem):
	if itemToAdd.itemObject.canStack:
		if itemObjects.has(itemToAdd.itemObject):
			var itemLocation = itemObjects.find(itemToAdd.itemObject)
			inventoryItems[itemLocation].itemAmount += itemToAdd.itemAmount
			itemSlots[itemLocation].updateUI()
		else:
			addNewItem(itemToAdd)
	else:
		addNewItem(itemToAdd)

func addNewItem(itemToAdd : InventoryItem):
	if itemObjects.size() < maxItems:
		inventoryItems.append(itemToAdd)
		itemObjects.append(itemToAdd.itemObject)
		
		var itemLocation = itemObjects.find(itemToAdd.itemObject)
		itemSlots[itemLocation].setItem(itemToAdd)

func removeItem(itemToRemove : InventoryItem):
	var itemLocation = itemObjects.find(itemToRemove.itemObject)
	inventoryItems[itemLocation].itemAmount = itemToRemove.itemAmount
	
	if inventoryItems[itemLocation].itemAmount <= 0:
		inventoryItems.remove_at(itemLocation)
		itemObjects.remove_at(itemLocation)
	
	itemSlots[itemLocation].updateUI()

func moveItem():
	pass

func combineItems():
	pass

func useItem():
	pass
