extends "res://units/BaseUnit.gd"

func _actively_advance_movement() -> void:
	._actively_advance_movement()
	var m_pos = get_global_mouse_position()
	_move_target = m_pos
	_velocity = position.direction_to(_move_target) * speed
	_attack_target = null
	emit_signal("move_target_updated", _move_target)

func _is_input_good() -> bool:
	return Input.is_action_pressed("move")
