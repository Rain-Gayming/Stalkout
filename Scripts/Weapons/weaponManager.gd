extends Node3D
class_name WeaponManager

@export var itemRef : inventoryItem
@export var weaponInfo : WeaponInfo 
@export var animTree : AnimationTree
@export var leftHandIK : SkeletonIK3D
@export var rightHandIK : SkeletonIK3D

@export_category("Attacking")
@export var attackTime : float
@export var hasAttacked : bool
@export var isAttacking : bool
@export var isAltAttack : bool

@export_category("Ranged")
@export var muzzlePoint : Node3D
@export var currentFireType : GlobalEnums.fireType
@export var currentAmmo : int
@export var isReloading : bool

func _ready():
	weaponInfo = itemRef.item.weaponInfo
	currentAmmo = itemRef.weaponAttachments.magazine.ammoInMag.size()
	leftHandIK.start(false)
	rightHandIK.start(false)
	
	for bul in itemRef.weaponAttachments.magazine.maxAmmo:
		itemRef.weaponAttachments.magazine.ammoInMag.append(itemRef.weaponAttachments.magazine.ammoInMag[0])

func _process(delta):
	if !CursorManager.isPaused:
		#updateAnimationValues()
		
		#time between attacks
		if attackTime > 0:
			attackTime -= delta
			
		#if pressing attack key
		if Input.is_action_pressed("mainAttack"):
			#if not waiting on attack time
			if attackTime <= 0:
				#if weapon is ranged and it has ammo
				if itemRef.item.weaponInfo.isRanged:
					if currentAmmo > 0:
						#if full auto shoot constantly
						if currentFireType == GlobalEnums.fireType.fullAuto:
							rangedAttack(true)
						#else shoot once
						elif currentFireType == GlobalEnums.fireType.semiAuto:
							if hasAttacked != true:
								rangedAttack(false)
						#TODO: impliment burst firing
						elif currentFireType == GlobalEnums.fireType.burst:
							for shot in weaponInfo.burstShootAmount:
								rangedAttack(false)
				else:
					#TODO: impliment melee attacking
					meleeAttack() 
		#resets has attacked
		if Input.is_action_just_released("mainAttack"):
			hasAttacked = false
			isAttacking = false
		
		#allows swapping of firemodes
		if Input.is_action_just_pressed("fireMode"):
			swapFireMode()
		
		#allows reloading
		if Input.is_action_just_pressed("reload"):
			reload()
		
		if Input.is_action_just_pressed("checkMag"):
			checkMag()
		
		if Input.is_action_just_pressed("altAttack"):
			isAltAttack = !isAltAttack

func checkMag():
	print(currentAmmo)

func rangedAttack(auto : bool):
	isAttacking = true
	
	#sets the attack time to weapon speed
	attackTime = weaponInfo.attackSpeed
	
	#creates a new bullet at the muzzle
	var newBullet = weaponInfo.bulletObject.instantiate()
	newBullet.transform.origin = muzzlePoint.global_position
	newBullet.transform.basis = muzzlePoint.global_basis
	
	#sets the bullets vars to the first bullet
	newBullet.bulletItem = itemRef.weaponAttachments.magazine.ammoInMag[0]
	
	#removes the first bullet in the mag
	itemRef.weaponAttachments.magazine.ammoInMag.remove_at(0)
	#updates current ammo size
	currentAmmo = itemRef.weaponAttachments.magazine.ammoInMag.size()
	
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
	isReloading = true
	await get_tree().create_timer(weaponInfo.reloadTime).timeout
	currentAmmo = weaponInfo.maxAmmo
	isReloading = false

func meleeAttack():
	pass
	
func updateAnimationValues():
	if isAttacking:
		animTree["parameters/conditions/isAttacking"] = true
		animTree["parameters/conditions/isIdle"] = false
	else:
		animTree["parameters/conditions/isAttacking"] = false
		animTree["parameters/conditions/isIdle"] = true
	
	if isAltAttack:
		animTree["parameters/conditions/isAltAttack"] = true
		animTree["parameters/conditions/isIdle"] = false
	else:
		animTree["parameters/conditions/isAltAttack"] = false
		animTree["parameters/conditions/isIdle"] = true
