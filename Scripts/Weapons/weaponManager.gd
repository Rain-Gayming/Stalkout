extends Node3D
class_name WeaponManager

@export var itemRef : inventoryItem

@export_category("Attacking")
@export var attackTime : float
@export var hasAttacked : bool

@export_category("Ranged")
@export var muzzlePoint : Node3D
@export var currentFireType : GlobalEnums.fireType
@export var currentAmmo : int

func _process(delta):
	if attackTime > 0:
		attackTime -= delta
	if Input.is_action_pressed("mainAttack"):
		if attackTime <= 0:
			if itemRef.item.weaponInfo.isRanged and currentAmmo > 0:
				if currentFireType == GlobalEnums.fireType.fullAuto:
					rangedAttack(true)
				else:
					if hasAttacked != true:
						rangedAttack(false)
			else:
				meleeAttack() 
	if Input.is_action_just_released("mainAttack"):
		hasAttacked = false
	
	if Input.is_action_just_pressed("reload"):
		reload()

func rangedAttack(auto : bool):
	currentAmmo -= 1
	attackTime = itemRef.item.weaponInfo.attackSpeed
	var newBullet = itemRef.item.weaponInfo.bulletObject.instantiate()
	newBullet.transform.origin = muzzlePoint.global_position
	newBullet.transform.basis = muzzlePoint.global_basis
	get_tree().root.add_child(newBullet)
	hasAttacked = true

func reload():
	await get_tree().create_timer(itemRef.item.weaponInfo.reloadTime).timeout
	currentAmmo = itemRef.item.weaponInfo.maxAmmo

func meleeAttack():
	pass
