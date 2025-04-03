extends Node2D

@onready var player: Player = $Player
@onready var hud: Node2D = $HUD
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	audio_stream_player.play()
	audio_stream_player.finished.connect(_on_musica_finished)

func _on_musica_finished():
	audio_stream_player.play() 

func _process(_delta: float) -> void:
	var sprite = hud.get_node("CanvasLayer/Sprite2D")
	var sprite2 = hud.get_node("CanvasLayer/Sprite2D2")
	var sprite3 = hud.get_node("CanvasLayer/Sprite2D3")
	if player.hp == 3:
		sprite.visible = true
		sprite2.visible = true
		sprite3.visible = true
	elif player.hp == 2:
		sprite.visible = true
		sprite2.visible = true
		sprite3.visible = false
	elif player.hp == 1:
		sprite.visible = true
		sprite2.visible = false
		sprite3.visible = false
