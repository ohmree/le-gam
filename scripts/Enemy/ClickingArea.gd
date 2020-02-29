extends Area2D

onready var enemy = get_parent()

func _input_event(viewport: Object, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("attack"):
		enemy.emit_signal("attack_clicked_on", enemy)
		return(self) # returns a reference to this node
