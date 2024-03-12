extends Node

signal toggleContextMenu(position)

func emitToggleContextMenu(position : Vector2):
	emit_signal("toggleContextMenu", position)
