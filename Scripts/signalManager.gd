extends Node

signal addItem(item)

func emitAddItem(item: itemObject):
	emit_signal("addItem", item)
