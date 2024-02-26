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
