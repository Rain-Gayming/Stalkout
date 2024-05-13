extends Node

signal toggleContextMenu(position, itemSlot)
signal slotClicked(itemSlot)
signal useItem(itemObject, amountToUse)
signal dropItem(inventoryItem)

func emitUseItem(itemObject : ItemObject, amountToUse : int):
	emit_signal("useItem", itemObject, amountToUse)

func emitToggleContextMenu(position : Vector2, itemSlot : ItemSlot):
	emit_signal("toggleContextMenu", position, itemSlot)

func emitDropItem(item : InventoryItem):
	emit_signal("dropItem", item)

func emitSlotClicked(itemSlot : ItemSlot):
	emit_signal("slotClicked", itemSlot)
