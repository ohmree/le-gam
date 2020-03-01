extends KinematicBody2D

signal marked_for_attack(myself)
signal health_changed(new_health)
signal move_target_updated(target_pos)
signal attack_cooldown_reset
signal died

export(int) var max_health: int
export(int) var health: int setget _health_set, _health_get
export(int) var speed: int
export(int) var attack_damage: int
export(int) var attack_range: float
export(PackedScene) var AttackBehaviorProvider: PackedScene
var _attack_target: Node
# TODO: replace with a state machine
var can_attack: bool = true
var _move_target: Vector2
var _velocity: Vector2 = Vector2.ZERO
var _attack_cooldown: Node
var _health_bar: Node
var _attack_behavior: Node

# TODO: figure out why we need this.
# var starting_position: Vector2

# TODO: maybe make these private or read-only,
# or get rid of the heal and damage methods
func _health_set(new_health: int) -> void:
	if new_health <= 0:
		health = 0
		emit_signal('died')
	elif new_health >= max_health:
		health = max_health
	else:
		health = new_health
#	TODO: I want to have the following line here,
#	but it seems like something is calling this method
#	before the health bar has been initialized:
#	emit_signal('health_changed', health)


# TODO: see if I need a custom getter for this
func _health_get() -> int:
	return health

func take_damage(damage: int) -> void:
	health -= damage
	emit_signal('health_changed', health)

func heal_by(amount: int) -> void:
	health += amount
	emit_signal('health_changed', health)

func _ready() -> void:
	_health_bar = $HealthBar
	_attack_cooldown = $AttackCooldown
	_move_target = position
	health = max_health
	_health_bar.max_value = max_health
	_health_bar.value = health
	_attack_behavior = AttackBehaviorProvider.instance()
	add_child(_attack_behavior)

#	starting_position = position

func _on_self_died() -> void:
#	Only enemies should free themselves, I think
#	queue_free()
	pass

func _on_self_health_changed(new_health: int) -> void:
	_health_bar.value = new_health

func _on_ClickingArea_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed('attack'):
		emit_signal('marked_for_attack', self)


func _attack() -> void: pass

func _passively_advance_movement():
	# TODO: settle on a minimum walking range
	# need to have proper textures first
	# TODO: maybe make this overridable so the player
	# checks for cursor position instead of move target?
	if position.distance_to(_move_target) > 50:
		_velocity = move_and_slide(_velocity)

# TODO: find a better name for this
# This function updates the move target,
# like when the player has the mouse button
# pressed or when an enemy's target moves (I think).
# It also needs to perform some physics calculations
# that utilize the new move target.
func _actively_advance_movement() -> void: pass
# TODO: this name also isn't great.
# The architecture can also be revamped a bit more,
# since we can now have these bits only for heroes.
func _is_input_good() -> bool: return false

# Ranged units need to implement obstacle
# checks in addition to this code.
# See also: res://units/RangedBehavior.gd
func _can_attack(target: Node):
	return target != null \
	and position.distance_to(target.position) \
	<= attack_range

func _physics_process(delta: float) -> void:
	if _is_input_good():
		_actively_advance_movement()
	_passively_advance_movement()
	if _can_attack(_attack_target):
		_attack()

func _on_Enemy_marked_for_attack(enemy: Node) -> void:
	_attack_target = enemy

func _on_Enemy_died() -> void:
	_attack_target = null

func _on_AttackCooldown_timeout() -> void:
#	TODO: replace with a state machine
	can_attack = true
	_attack_cooldown.stop()
	emit_signal("attack_cooldown_reset")
