extends KinematicBody2D

signal marked_for_attack(myself)
signal health_changed(new_health)
signal died

export(int) var max_health: int
export(int) var health: int
onready var health_bar = $HealthBar
# TODO: figure out why we need this.
# var starting_position: Vector2

func harm(damage):
	var new_health = health - damage
	if new_health <= 0:
		health = 0
		emit_signal('died')
	else:
		health = new_health

	emit_signal('health_changed', health)

func heal(amount):
	var new_health = health + amount
	if new_health >= max_health:
		health = max_health
	else:
		health = new_health

	emit_signal('health_changed', health)

func _ready() -> void:
	health_bar.max_value = max_health
	health_bar.value = health
#	starting_position = position

func _on_self_died() -> void:
	queue_free()

func _on_self_health_changed(new_health) -> void:
	health_bar.value = new_health

func _on_ClickingArea_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed('attack'):
		emit_signal('marked_for_attack', self)
