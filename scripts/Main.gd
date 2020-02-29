extends Node2D

var MoveMarker = preload("res://scenes/MoveMarker.tscn")
var Enemy = preload("res://scenes/Enemy.tscn")
var has_player_moved = false
onready var hero_attack_cooldown = $Hero/AttackCooldown
onready var attack_timer_progress = $HUD/AttackTimerProgress
onready var m = MoveMarker.instance()
onready var enemy = $Enemy
onready var enemy_dupe = enemy.duplicate()
var enemy_starting_pos: Vector2 = Vector2(752, 280)
var t

func _ready() -> void:
	attack_timer_progress.max_value = hero_attack_cooldown.wait_time
	attack_timer_progress.value = hero_attack_cooldown.time_left
	enemy_dupe.position = enemy_starting_pos
	t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)

func _process(delta: float) -> void:
	attack_timer_progress.value = \
	attack_timer_progress.max_value - hero_attack_cooldown.time_left

func _on_Hero_moved(target_pos: Vector2) -> void:
	m.position = target_pos
	if not has_player_moved:
		add_child(m)
		has_player_moved = true

func _on_Enemy_died() -> void:
	t.start()
	yield(t, "timeout")
	add_child(enemy_dupe.duplicate())
