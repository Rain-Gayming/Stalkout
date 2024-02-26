extends Node

@export_category("Items")
@export var inventoryItems : Array[inventoryItem]
@export var itemObjects : Array[itemObject]
@export var maxItems : int

func _ready():
	SignalManager.connect("addItem", addItem)
	SignalManager.connect("removeItem", removeItem)

func _process(delta):
	if Input.is_action_just_pressed("item1"):
		inventoryItems[0].useItem()

func addItem(item : itemObject, amount : int):
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

func addNewItem(item : itemObject, amount : int):
	var newItem = inventoryItem.new()
	newItem.setInfo(item, amount)
	
	inventoryItems.append(newItem)
	itemObjects.append(item)
	print("picking up " + item.itemName)

func removeItem(item : inventoryItem):
	var itemLocation = inventoryItems.find(item)
	inventoryItems.remove_at(itemLocation)
