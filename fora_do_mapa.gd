extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	var player :Player= body as Player
	if(player !=null):
		player.apanhar(10)
