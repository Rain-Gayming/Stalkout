extends Node



@export_category("Inventory Manager")
@export var itemDatabase : ItemDatabase
@export_group("Items")
@export var maxItems : int
@export var inventoryItems : Array[InventoryItem]
@export var itemObjects : Array[ItemObject]

@export_category("UI")
@export var itemSlotScene : PackedScene
@export var itemSlotGrid : GridContainer
@export var itemSlots : Array[ItemSlot]

@export_group("Context Menu")
@export var contextMenu : Control

@export_group("Swap Items")
@export var swapFrom : ItemSlot
@export var swapTo : ItemSlot
@export var storedSwapItem : InventoryItem

@export_group("Debug")
@export var debugItemName : TextEdit

func _ready():
	for slot in maxItems:
		var newSlot = itemSlotScene.instantiate()
		itemSlotGrid.add_child(newSlot)
		itemSlots.append(newSlot)
	
	InventorySignalManager.connect("toggleContextMenu", toggleContextMenu)
	InventorySignalManager.connect("useItem", useItem)
	InventorySignalManager.connect("dropItem", removeItem)
	InventorySignalManager.connect("slotClicked", swapItems)


func addItem(itemToAdd : InventoryItem):
	
	if itemToAdd.itemAmount <= 0:
			itemToAdd.itemAmount = 1
			
	if itemToAdd.itemObject.canStack:
		var itemLocation = itemObjects.find(itemToAdd.itemObject)
		if itemObjects.has(itemToAdd.itemObject):
			inventoryItems[itemLocation].itemAmount += itemToAdd.itemAmount
			
			itemSlots[itemLocation].itemInSlot = inventoryItems[itemLocation]
			itemSlots[itemLocation].setItem(inventoryItems[itemLocation])
		else:
			addNewItem(itemToAdd)
	else:
		addNewItem(itemToAdd)

func addNewItem(itemToAdd : InventoryItem):
	if itemObjects.size() < maxItems:
		inventoryItems.push_back(itemToAdd)
		itemObjects.push_back(itemToAdd.itemObject)
		
		var newSlot = findNextEmptySlot()
		newSlot.setItem(itemToAdd)
		print(newSlot)

func findNextEmptySlot():
	for slot in itemSlots:
		if !slot.itemInSlot or !slot.itemInSlot.itemObject:
			return slot 

func swapItems(itemSlotClicked : ItemSlot):
	if swapFrom == null:
		swapFrom = itemSlotClicked
	else:
		swapTo = itemSlotClicked
		
		storedSwapItem = swapFrom.itemInSlot
		swapFrom.itemInSlot = swapTo.itemInSlot
		swapTo.itemInSlot = storedSwapItem
		
		swapFrom = null
		swapTo = null
		storedSwapItem = null

func removeItem(itemToRemove : InventoryItem):
	if itemToRemove != null and itemToRemove.itemObject != null:
		var itemLocation = itemObjects.find(itemToRemove.itemObject)
		inventoryItems[itemLocation].itemAmount -= itemToRemove.itemAmount
			
		if inventoryItems[itemLocation].itemObject == itemToRemove.itemObject:
			itemSlots[itemLocation].setItem(inventoryItems[itemLocation])
		else:
			itemSlots[itemLocation].setItem(null)
		
		if inventoryItems[itemLocation].itemAmount <= 0:
			inventoryItems.remove_at(itemLocation)
			itemObjects.remove_at(itemLocation)
			itemSlots[itemLocation].setItem(null)
			print("no item in slot")
	

func combineItems():
	pass

func useItem(itemObject : ItemObject, amountToUse : int):
	var itemToUse = InventoryItem.new()
	itemToUse.itemObject = itemObject
	itemToUse.itemAmount = amountToUse
	
	itemToUse.itemObject.useItem()
	removeItem(itemToUse)

func toggleContextMenu(newPosition : Vector2, itemSlot : ItemSlot):
	if contextMenu.visible:
		contextMenu.hide()
	else:
		contextMenu.show()
		contextMenu.position = newPosition + itemSlotGrid.position
		contextMenu.selectedSlot = itemSlot


func addDebugItem():
	for dbItem in itemDatabase.items:
		if dbItem.itemName == debugItemName.text:
			var newDBItem = CreateNewInventoryItem(dbItem)
			newDBItem.itemObject = dbItem
			newDBItem.itemAmount = 1
			addItem(newDBItem)

func CreateNewInventoryItem(item : ItemObject):
	if item.get_script() == ItemObject:
		var newIItem = InventoryItem.new()
		return newIItem
	elif item.get_script() == GunItem:
		var newIItem = GunInventoryItem.new()
		return newIItem
	elif item.get_script() == MagazineItem:
		var newIItem = MagazineInventoryItem.new()
		return newIItem
	else: 
		var newIItem = InventoryItem.new()
		return newIItem
