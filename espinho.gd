extends Node2D

var player :Player
var timer :float
@export var timeDamage:bool = false
@export var area2d:Area2D

func _ready() -> void:
	if area2d:
		area2d.body_entered.connect(_on_area_2d_body_entered)
		area2d.body_exited.connect(_on_area_2d_body_exited)


func  _process(delta: float) -> void:
	if not player or not timeDamage:
		return
	timer +=delta
	if timer > 1.5:
		player.apanhar(1)
		timer = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	timer = 0
	player = body as Player
	if(player !=null):
		player.apanhar(1)

func _on_area_2d_body_exited(_body: Node2D) -> void:
	player = null
