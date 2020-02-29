extends CanvasLayer

onready var attack_progress = $AttackProgress
var cooldown_time_left: float setget cooldown_time_left_set

func start(max_value: float, value: float):
	attack_progress.max_value = max_value
	attack_progress.value = value

func cooldown_time_left_set(time_left: float) -> void:
	cooldown_time_left = time_left

func _process(delta: float) -> void:
	attack_progress.value \
	= attack_progress.max_value \
	- cooldown_time_left
