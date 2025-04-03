class_name Player
extends CharacterBody2D

var speed = 240
var jump_velocity = -300
var hp = 3
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@export var audiosAndar:Array[AudioStream]
@onready var audio_andar: AudioStreamPlayer2D = $audioAndar
@export var audiosVoar:Array[AudioStream]
@onready var audio_voar: AudioStreamPlayer2D = $audioVoar
@onready var audio_rato: AudioStreamPlayer2D = $audioRato
@onready var audio_apanhando: AudioStreamPlayer2D = $audioApanhando
@onready var audio_pulo: AudioStreamPlayer2D = $AudioPulo
@onready var audio_grito: AudioStreamPlayer2D = $AudioGrito

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	audio_andar.stream = audiosAndar[randi_range(0,audiosAndar.size()-1)]
	audio_voar.stream = audiosAndar[randi_range(0,audiosVoar.size()-1)]
	if Input.is_action_pressed("correr") and is_on_floor():#troca de velocidade
		speed = 350
		jump_velocity = -400
	else:
		speed = 240
		jump_velocity = -300
	if not is_on_floor():#planar
		$AnimatedSprite2D.play("voando")
		if Input.is_action_pressed("ui_accept"):
			velocity += (get_gravity() * delta)/1.9
		else:
			velocity += get_gravity() * delta
	else:
		if direction:
			if is_on_floor():
				audio_andar.play()
			if Input.is_action_pressed("correr"):
				$AnimatedSprite2D.play("correndo")
			else:
				$AnimatedSprite2D.play("andando")
		else:
			$AnimatedSprite2D.play("idle")
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		audio_pulo.play()
	if direction:
		if not is_on_floor():
			velocity.x = direction * speed
			sprite.flip_h = direction > 0
		else:
			velocity.x = direction * speed
			sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()

func apanhar(dano:int):
	audio_apanhando.play()
	hp -= dano
	if(hp <= 0):
		game_over()
	var t := create_tween();
	sprite.modulate = Color.RED;
	t.tween_property(sprite, "modulate", Color.WHITE, 0.25);

func ganhar_vida(vida:int):
	audio_rato.play()
	if hp<3:
		hp += vida
	
func game_over():
	call_deferred("mudar_cena")

func mudar_cena():
	get_tree().change_scene_to_file('res://game_over.tscn')


func _on_audio_pulo_finished() -> void:
	if not is_on_floor():
		audio_voar.play()

func _on_audio_rato_finished() -> void:
	audio_grito.play()
