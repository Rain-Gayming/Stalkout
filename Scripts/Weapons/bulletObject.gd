extends RigidBody3D

@export var bulletItem : ItemObject

func _ready():
	mass = bulletItem.weight
	linear_velocity = (-basis.z * bulletItem.bulletInfo.velocity) * 10
