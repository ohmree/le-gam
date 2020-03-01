extends Node2D

# TODO: organize this file, it's a bit fugly

var Enemy = preload("res://units/enemies/ranged/FirstEnemy/FirstEnemy.tscn")
var player_moved_once: bool = false
onready var hero: Node = $Hero
onready var hud: Node = $HUD
onready var move_marker: Node = $MoveMarker

func _ready() -> void:
	hud.start(
		hero._attack_cooldown.wait_time,
		hero._attack_cooldown.time_left
	)

func _on_Hero_move_target_updated(target_pos: Vector2) -> void:
	move_marker.position = target_pos
	if not player_moved_once:
		move_marker.show()
		player_moved_once = true
