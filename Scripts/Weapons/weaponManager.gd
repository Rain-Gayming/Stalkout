extends Node3D
class_name WeaponManager

@export var itemRef : inventoryItem
@export var weaponInfo : WeaponInfo

@export_category("Attacking")
@export var attackTime : float
@export var hasAttacked : bool

@export_category("Ranged")
@export var muzzlePoint : Node3D
@export var currentFireType : GlobalEnums.fireType
@export var currentAmmo : int

func _ready():
	weaponInfo = itemRef.item.weaponInfo

func _process(delta):
	if attackTime > 0:
		attackTime -= delta
	if Input.is_action_pressed("mainAttack"):
		if attackTime <= 0:
			if itemRef.item.weaponInfo.isRanged and currentAmmo > 0:
				if currentFireType == GlobalEnums.fireType.fullAuto:
					rangedAttack(true)
				elif currentFireType == GlobalEnums.fireType.semiAuto:
					if hasAttacked != true:
						rangedAttack(false)
						
				elif currentFireType == GlobalEnums.fireType.burst:
					for shot in weaponInfo.burstShootAmount:
						rangedAttack(false)
			else:
				meleeAttack() 
	if Input.is_action_just_released("mainAttack"):
		hasAttacked = false
	
	if Input.is_action_just_pressed("fireMode"):
		swapFireMode()
	
	if Input.is_action_just_pressed("reload"):
		reload()

func rangedAttack(auto : bool):
	currentAmmo -= 1
	attackTime = weaponInfo.attackSpeed
	var newBullet = weaponInfo.bulletObject.instantiate()
	newBullet.transform.origin = muzzlePoint.global_position
	newBullet.transform.basis = muzzlePoint.global_basis
	get_tree().root.add_child(newBullet)
	hasAttacked = true

func swapFireMode():
	if currentFireType == GlobalEnums.fireType.semiAuto:		
		if weaponInfo.firingType.has(GlobalEnums.fireType.burst):
			currentFireType = GlobalEnums.fireType.burst
		elif weaponInfo.firingType.has(GlobalEnums.fireType.fullAuto):
			currentFireType = GlobalEnums.fireType.fullAuto
			
	elif currentFireType == GlobalEnums.fireType.burst:
		if weaponInfo.firingType.has(GlobalEnums.fireType.fullAuto):
			currentFireType = GlobalEnums.fireType.fullAuto
		elif weaponInfo.firingType.has(GlobalEnums.fireType.semiAuto):
			currentFireType = GlobalEnums.fireType.semiAuto
			
	elif currentFireType == GlobalEnums.fireType.fullAuto:
		if weaponInfo.firingType.has(GlobalEnums.fireType.semiAuto):
			currentFireType = GlobalEnums.fireType.semiAuto
		elif weaponInfo.firingType.has(GlobalEnums.fireType.burst):
			currentFireType = GlobalEnums.fireType.burst

func reload():
	await get_tree().create_timer(weaponInfo.reloadTime).timeout
	currentAmmo = weaponInfo.maxAmmo

func meleeAttack():
	pass
