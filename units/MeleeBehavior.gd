extends Node

onready var unit: Node = get_parent()

func _attack() -> void:
	# TODO
	print("%s has used a melee attacked!" % unit.name)

func _can_attack() -> bool:
	# TODO
	return false
