extends Node

#TODO:
#Item using
#Item combining
#Item equipping
#Item condition
#Item context menu


@export var debugAdd : InventoryItem

@export_category("Inventory Manager")
@export_group("Items")
@export var maxItems : int
@export var inventoryItems : Array[InventoryItem]
@export var itemObjects : Array[ItemObject]

@export_category("UI")
@export var itemSlots : Array[ItemSlot]

@export_group("Context Menu")
@export var contextMenu : Control

func _ready():
	InventorySignalManager.connect("toggleContextMenu", toggleContextMenu)
	InventorySignalManager.connect("useItem", useItem)
	InventorySignalManager.connect("dropItem", removeItem)

func _process(delta):
	if Input.is_action_just_pressed("debug_console"):
		addItem(debugAdd)

func addItem(itemToAdd : InventoryItem):
	var itemLocation = itemObjects.find(itemToAdd.itemObject)
	
	if itemToAdd.itemAmount <= 0:
			itemToAdd.itemAmount = 1
			
	if itemToAdd.itemObject.canStack:
		if itemObjects.has(itemToAdd.itemObject):
			inventoryItems[itemLocation].itemAmount += itemToAdd.itemAmount
			
			itemSlots[itemLocation].itemInSlot = inventoryItems[itemLocation]
			itemSlots[itemLocation].setItem(inventoryItems[itemLocation])
		else:
			addNewItem(itemToAdd)
	else:
		addNewItem(itemToAdd)
	itemSlots[itemLocation].updateUI()

func addNewItem(itemToAdd : InventoryItem):
	if itemObjects.size() < maxItems:
		inventoryItems.append(itemToAdd)
		itemObjects.append(itemToAdd.itemObject)
		
		var itemLocation = itemObjects.find(itemToAdd.itemObject)
		itemSlots[itemLocation].setItem(itemToAdd)

func removeItem(itemToRemove : InventoryItem):
	if itemToRemove != null and itemToRemove.itemObject != null:
		var itemLocation = itemObjects.find(itemToRemove.itemObject)
		inventoryItems[itemLocation].itemAmount -= itemToRemove.itemAmount
			
		if inventoryItems[itemLocation].itemObject == itemToRemove.itemObject:
			itemSlots[itemLocation].setItem(inventoryItems[itemLocation])
		else:
			itemSlots[itemLocation].setItem(null)
		
		if inventoryItems[itemLocation].itemAmount <= 0:
			inventoryItems.remove_at(itemLocation)
			itemObjects.remove_at(itemLocation)
			itemSlots[itemLocation].setItem(null)
			print("no item in slot")
	

func moveItem():
	pass

func combineItems():
	pass

func useItem(itemObject : ItemObject, amountToUse : int):
	var itemToUse = InventoryItem.new()
	itemToUse.itemObject = itemObject
	itemToUse.itemAmount = amountToUse
	
	itemToUse.itemObject.useItem()
	removeItem(itemToUse)

func toggleContextMenu(newPosition : Vector2, itemSlot : ItemSlot):
	if contextMenu.visible:
		contextMenu.hide()
	else:
		contextMenu.show()
		contextMenu.position = newPosition
		contextMenu.selectedSlot = itemSlot
