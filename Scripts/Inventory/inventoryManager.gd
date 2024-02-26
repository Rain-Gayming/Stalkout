extends Node

func _ready():
	SignalManager.connect("addItem", addItem)

func addItem(item : itemObject):
	print(item.itemName)
