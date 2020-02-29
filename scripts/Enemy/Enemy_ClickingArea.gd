extends Area2D

func _ready() -> void:
	pass

func _input_event(viewport: Object, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("attack"):
		get_parent().emit_signal("attack_clicked_on", get_parent())
		return(self) # returns a reference to this node
