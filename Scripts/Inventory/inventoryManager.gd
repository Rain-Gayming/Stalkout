extends Node
class_name InventoryManager

@export_category("References")
@export var inventoryVisibility : Control
@export var inventoryUserInterface : Control

@export_category("Items")
@export var inventoryItems : Array[inventoryItem]
@export var itemObjects : Array[ItemObject]
@export var maxItems : int = 30

func _ready():
	SignalManager.connect("addItem", addItem)
	SignalManager.connect("removeItem", removeItem)
	SignalManager.connect("findItem", findItem)

func _process(delta):
	if Input.is_action_just_pressed("shortcut1"):
		inventoryItems[0].useItem()

func findItem(item : ItemObject):
	if itemObjects.has(item):
		var itemLocation = itemObjects.find(item)
		return inventoryItems[itemLocation]
	else: 
		print("item not in inventory")

func addItem(item : ItemObject, amount : int):
	if inventoryItems.size() < maxItems:
		if item.canStack:
			if itemObjects.has(item):
				var itemLocation = itemObjects.find(item)
				inventoryItems[itemLocation].amount += amount
			else:
				addNewItem(item, amount)
		else:
			for i in amount:
				addNewItem(item, 1)

func addNewItem(item : ItemObject, amount : int):
	var newItem = inventoryItem.new()
	newItem.setInfo(item, amount)
	
	if inventoryUserInterface:
		var emptySlot = inventoryUserInterface.findNextEmptySlot()
		inventoryUserInterface.setSlotItem(newItem, emptySlot)
		
	
	inventoryItems.append(newItem)
	itemObjects.append(item)

func removeItem(item : inventoryItem):
	var itemLocation = inventoryItems.find(item)
	inventoryItems.remove_at(itemLocation)
