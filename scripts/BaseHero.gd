extends KinematicBody2D

signal moved(target_pos)
signal health_changed(new_health)


onready var health_bar := $HealthBar
onready var position_label := $PositionLabel
onready var attack_cooldown := $AttackCooldown
export(int) var speed: int
export(int) var max_health: int
export(int) var health: int
export(int) var attack_damage: int
export(int) var attack_range: float
var attack_target: Node
var can_attack: bool = true
var move_target: Vector2
var velocity: Vector2 = Vector2.ZERO

func attack() -> void:
	pass

func _ready() -> void:
	move_target = position
	health_bar.max_value = max_health
	health_bar.value = health

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move"):
		var m_pos = get_global_mouse_position()
		move_target = m_pos
		velocity = position.direction_to(move_target) * speed
		attack_target = null
		emit_signal("moved", move_target)

	if position.distance_to(move_target) > 5:
		velocity = move_and_slide(velocity)

	if attack_target != null \
	and position.distance_to(attack_target.position) \
		<= attack_range:
		attack()
	else:
		attack_target = null

func _on_Enemy_marked_for_attack(enemy) -> void:
	attack_target = enemy


func _on_Enemy_died() -> void:
	attack_target = null


func _on_AttackCooldown_timeout() -> void:
	can_attack = true
	attack_cooldown.stop()
