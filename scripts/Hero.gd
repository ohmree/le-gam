extends KinematicBody2D

signal moved(target_pos)

const SPEED = 100
onready var health_bar = $HealthBar
onready var position_label = $PositionLabel
onready var obstacle_ray = $RayCast2D
onready var attack_cooldown = $AttackCooldown
var max_health: int = 100
var health: int = 100
var attack_damage: int = 15
var attack_range: float = 300.0
var attack_target
var can_attack: bool = true
var move_target: Vector2
var Projectile = preload("res://scenes/Projectile.tscn")
var velocity: Vector2 = Vector2.ZERO

func _ready() -> void:
	move_target = position
	health_bar.max_value = max_health
	health_bar.value = health

func _process(delta: float) -> void:
	pass


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("move"):
		var m_pos = get_global_mouse_position()
		move_target = m_pos
		velocity = position.direction_to(move_target) * SPEED
		attack_target = null
		emit_signal("moved", move_target)

	if position.distance_to(move_target) > 5:
		velocity = move_and_slide(velocity)

	if attack_target != null \
	and position.distance_to(attack_target.position) \
		<= attack_range:
		if can_attack:
			obstacle_ray.cast_to = attack_target.position
#			obstacle_ray.cast_to = get_global_mouse_position()
#			obstacle_ray.enabled = true
			if not obstacle_ray.is_colliding():
#				print('here')
				# TODO: fix raycast, it no work
				# If no obstacles in the way,
				# fire projectile.
				var p = Projectile.instance()
				add_child(p)
				p.start(transform, attack_target, attack_damage)
				# Start attack cooldown
				can_attack = false
				attack_cooldown.start()
#			obstacle_ray.enabled = false
	else:
		attack_target = null

func _on_Enemy_attack_clicked_on(enemy) -> void:
	attack_target = enemy


func _on_Enemy_died() -> void:
	attack_target = null


func _on_AttackCooldown_timeout() -> void:
	can_attack = true
	attack_cooldown.stop()
