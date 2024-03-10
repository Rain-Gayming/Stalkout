extends Node

#inventory
signal addItem(item)
signal removeItem(item)
signal findItem(item)

#survival 
signal thirstChange(value, negative)
signal hungerChange(value, negative)
signal sleepChange(value, negative)

#ui signals
signal hitMarker()

func emitAddItem(item: ItemObject, amount: int):
	emit_signal("addItem", item, amount)

func emitRemoveItem(iitem: inventoryItem):
	emit_signal("removeItem", iitem)

func emitFindItem(item : ItemObject):
	emit_signal("findItem", item)



func emitThirstChange(value : float, negative : bool):
	emit_signal("thirstChange", value, negative)

func emitHungerChange(value : float, negative : bool):
	emit_signal("hungerChange", value, negative)

func emitSleepChange(value : float, negative : bool):
	emit_signal("sleepChange", value, negative)

func emitHitMarker():
	emit_signal("hitMarker")
