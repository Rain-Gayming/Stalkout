extends Resource
class_name ItemObject

@export_category("Item Info")
@export var itemName : String
@export var canStack : bool

@export_category("UI")
@export var itemSprite : Texture2D
@export var gridSize : Vector2

@export_category("Extra Info")
@export var weight : float
@export var value : float

func useItem():
	print("Using item " + itemName)
