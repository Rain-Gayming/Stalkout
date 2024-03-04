extends Area3D
class_name HurtBox

@export var statManager : StatManager

func hit(damage : float, bullet : BulletObject):
	if statManager:
		statManager.ChangeHealth(damage, true)
		print("Taking Damage")
		
		if bullet:
			bullet.call_deferred('free')
