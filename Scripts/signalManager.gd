extends Node

signal addItem(item)
signal removeItem(item)

func emitAddItem(item: itemObject, amount: int):
	emit_signal("addItem", item, amount)

func emitRemoveItem(iitem: inventoryItem):
	emit_signal("removeItem", iitem)
