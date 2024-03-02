extends Node

signal addItem(item)
signal removeItem(item)

#survival changes
signal thirstChange(value, negative)
signal hungerChange(value, negative)
signal sleepChange(value, negative)

func emitAddItem(item: ItemObject, amount: int):
	emit_signal("addItem", item, amount)

func emitRemoveItem(iitem: inventoryItem):
	emit_signal("removeItem", iitem)

func emitThirstChange(value : float, negative : bool):
	emit_signal("thirstChange", value, negative)

func emitHungerChange(value : float, negative : bool):
	emit_signal("hungerChange", value, negative)

func emitSleepChange(value : float, negative : bool):
	emit_signal("sleepChange", value, negative)
