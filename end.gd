extends Control

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene_to_file('res://hq.tscn')

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file('res://hq.tscn')
