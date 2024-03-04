extends RigidBody3D
class_name BulletObject

@export var bulletHitBox : HitBox
@export var bulletItem : ItemObject

func _ready():
	mass = bulletItem.weight
	linear_velocity = (-basis.z * bulletItem.bulletInfo.velocity) * 10
	bulletHitBox.bullet = bulletItem.bulletInfo
	bulletHitBox.bulletParent = self

