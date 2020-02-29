extends Node2D

# TODO: organize this file, it's a bit fugly

var Enemy = preload("res://scenes/BaseEnemy.tscn")
var player_moved_once = false
onready var hero = $Hero
onready var hud = $HUD
onready var move_marker = $MoveMarker

func _ready() -> void:
	hud.start(
		hero.attack_cooldown.wait_time,
		hero.attack_cooldown.time_left
	)

func _on_Hero_moved(target_pos: Vector2) -> void:
	move_marker.position = target_pos
	if not player_moved_once:
		move_marker.show()
		player_moved_once = true
