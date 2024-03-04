extends Area3D
class_name HitBox

@export var bullet : BulletInfo
@export var bulletParent : BulletObject

func _on_area_entered(area):
	if area.script == HurtBox:
		area.hit(bullet.damage, bulletParent)
