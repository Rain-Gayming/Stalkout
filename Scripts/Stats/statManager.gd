extends Node

@export_category("References")
@export var isPlayer : bool

@export_category("Thirst")
@export var currentThirst : float
@export var maxThirst : float
@export var thirstDepletion : float

@export_category("Hunger")
@export var currentHunger: float
@export var maxHunger : float
@export var hungerDepletion : float

@export_category("Sleep")
@export var currentSleep : float
@export var maxSleep : float
@export var sleepDepletion : float

func _ready():
	currentThirst = maxThirst
	currentHunger = maxHunger
	currentSleep = maxSleep
	
	if isPlayer:
		SignalManager.connect("thirstChange", ChangeThirst)
		SignalManager.connect("hungerChange", ChangeHunger)
		SignalManager.connect("sleepChange", ChangeSleep)

func _process(delta):
	if currentThirst > 0:
		currentThirst -= thirstDepletion * delta
	
	if currentHunger > 0:
		currentHunger -= hungerDepletion * delta
	
	if currentSleep > 0:
		currentSleep -= sleepDepletion * delta

func ChangeThirst(value : float, negative : bool):
	if negative:
		currentThirst -= value
	else:
		currentThirst += value
	currentThirst = clamp(currentThirst, 0, maxThirst)

func ChangeHunger(value : float, negative : bool):
	if negative:
		currentHunger -= value
	else:
		currentHunger += value
	currentHunger = clamp(currentHunger, 0, maxHunger)

func ChangeSleep(value : float, negative : bool):
	if negative:
		currentSleep -= value
	else:
		currentSleep += value
	currentSleep = clamp(currentSleep, 0, maxSleep)
