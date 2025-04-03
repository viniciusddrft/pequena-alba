extends CharacterBody2D

@export var speed: float = 100 
@export var distance: float = 200 
var player :Player
var timer :float
@export var timeDamage:bool = false
@export var area2d:Area2D
var direction: int = 1 
var start_position: float 
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	audio_stream_player_2d.play()
	start_position = position.x
	if area2d:
		area2d.body_entered.connect(_on_area_2d_body_entered)
		area2d.body_exited.connect(_on_area_2d_body_exited)
	audio_stream_player_2d.finished.connect(_on_musica_finished)

func _on_musica_finished():
	audio_stream_player_2d.play() 

func _process(delta: float) -> void:
	position.x += speed * direction * delta
	if abs(position.x - start_position) >= distance:
		direction *= -1
		update_sprite_direction()
	if not player or not timeDamage:
		return
	timer +=delta
	if timer > 1.5:
		player.apanhar(1)
		timer = 0

func update_sprite_direction() -> void:
	$AnimatedSprite2D.flip_h = direction < 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	timer = 0
	player = body as Player
	if(player !=null):
		player.apanhar(1)

func _on_area_2d_body_exited(_body: Node2D) -> void:
	player = null
