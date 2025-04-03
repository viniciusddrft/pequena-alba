extends Node2D

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file('res://world_test.tscn')

func _on_button_button_down() -> void:
	get_tree().change_scene_to_file('res://world_test.tscn')
