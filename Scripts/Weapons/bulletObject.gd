extends RigidBody3D

@export var bulletItem : itemObject

func _ready():
	linear_velocity = (-basis.z * bulletItem.velocity) * 10
