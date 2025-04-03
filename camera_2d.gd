extends Camera2D

@onready var player: Player = $"../Player"

func _process(delta: float) -> void:
	var target = position
	target.x = player.position.x
	if player.is_on_floor():
		target.y = player.position.y - 150
	position = position.move_toward(target, delta * 500)
