extends Node

onready var unit: Node = get_parent()

func _attack():
	# TODO
	print("%s has used a ranged attacked!" % unit.name)

func _can_attack():
	# TODO
	return true
