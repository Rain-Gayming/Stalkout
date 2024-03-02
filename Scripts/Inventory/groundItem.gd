extends Node
class_name groundItem

@export_category("Item")
@export var item : ItemObject
@export var amount : int

static var _item
static var _amount

func _ready():
	_item = item
	_amount = amount

static func interact():
	SignalManager.emitAddItem(_item, _amount)
