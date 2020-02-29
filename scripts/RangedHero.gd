extends "res://scripts/BaseHero.gd"

export(PackedScene) var Projectile: PackedScene = preload("res://scenes/Projectile.tscn")
onready var obstacle_ray := $RayCast2D

func attack() -> void:
	if can_attack:
		obstacle_ray.cast_to = attack_target.position
		if not obstacle_ray.is_colliding():
			# TODO: fix raycast, it no work.
			# If no obstacles in the way,
			# fire projectile.
			var p = Projectile.instance()
			add_child(p)
			p.start(transform, attack_target, attack_damage)
			# Start attack cooldown
			can_attack = false
			attack_cooldown.start()
