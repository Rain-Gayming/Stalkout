extends Resource
class_name inventoryItem

@export var item : itemObject
@export var amount : int

func setInfo(iItem : itemObject, iAmount : int):
	if iItem:
		if iAmount <= 0:
			iAmount = 1
	
	item = iItem
	amount = iAmount

func useItem():
	var itemUsed = false
	
	if item.consumableEffects.size() > 0:
		itemUsed = true
	
	if itemUsed:
		removeItem(1)

func removeItem(amountRemoved : int):
	amount -= amountRemoved
	if amount <= 0:
		SignalManager.emitRemoveItem(self)
