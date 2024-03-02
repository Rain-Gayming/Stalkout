extends Node3D

@export_category("References")
@export var body : Node3D

@export_category("Camera Sensitivity")
@export var mouseSensX : float = 0.4
@export var mouseSensY : float = 0.4

func _input(event):
	if !CursorManager.isPaused:
		if event is InputEventMouseMotion:
			body.rotate_y(deg_to_rad(-event.relative.x * mouseSensX))
			rotate_x(deg_to_rad(-event.relative.y * mouseSensY))
			rotation.x = clamp(rotation.x, deg_to_rad(-80), deg_to_rad(80))
