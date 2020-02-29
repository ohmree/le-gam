extends KinematicBody2D

signal attack_clicked_on(myself)
signal died

var Projectile = preload("res://scenes/Projectile.tscn")
var max_health = 100
var health = 100
var starting_position: Vector2
var going_up = true

func harm(damage):
	var new_health = health - damage
	if new_health <= 0:
		health = 0
	else:
		health = new_health
	# Make the enemy invincible
	# For debugging purposes.
#	heal(damage)

func heal(amount):
	var new_health = health + amount
	if new_health >= max_health:
		health = max_health
	else:
		health = new_health


func _ready() -> void:
	$HealthBar.max_value = max_health
	$HealthBar.value = health
	starting_position = position

func _process(delta: float) -> void:
	if health <= 0:
		emit_signal("died")
		queue_free()
	$HealthBar.value = health

func _physics_process(delta: float) -> void:
	# Target practice
	if going_up:
		if position.y < starting_position.y - 150: going_up = false
		move_and_slide(Vector2(0,-1)*150)
	else:
		if position.y > starting_position.y + 150: going_up = true
		move_and_slide(Vector2(0,1)*150)
