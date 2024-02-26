extends Node
class_name groundItem

@export_category("Item")
@export var item : itemObject

static var _item

func _ready():
	_item = item

static func interact():
	SignalManager.emitAddItem(_item)
