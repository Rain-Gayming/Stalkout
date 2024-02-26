extends Node

@export_category("Items")
@export var inventoryItems : Array[inventoryItem]

func _ready():
	SignalManager.connect("addItem", addItem)

func addItem(item : itemObject):
	var newItem = inventoryItem.new()
	newItem.setInfo(item, 0)
	
	inventoryItems.append(newItem)
	print("picking up " + item.itemName)
