extends Resource
class_name itemObject

@export_category("Basic Info")
@export var itemName : String
@export var canStack : bool
@export var itemIcon : Texture2D
@export var itemRarity : GlobalEnums.rarity
@export var weight : float

@export_category("Consumable Effects")
@export var consumableEffects : Array[consumableEffect]

@export_category("Weapon Info")
@export var weaponInfo : WeaponInfo
@export var bulletInfo : BulletInfo
