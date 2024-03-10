extends Resource
class_name WeaponInfo

@export_category("Weapon Info")
@export var isRanged : bool
@export var attackSpeed : float
@export var weaponType : GlobalEnums.weaponType
@export var bulletCaliber : GlobalEnums.bulletCaliber

@export_category("Melee")
@export var damage : float

@export_category("Ranged")
@export var firingType : Array[GlobalEnums.fireType]
@export var bulletObject : PackedScene
@export var reloadTime : float
@export var maxAmmo : int = 30
@export var burstShootAmount : int
