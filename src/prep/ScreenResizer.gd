extends Node

func _process(delta):
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_right"):
		OS.window_size += Vector2(160, 120)
		OS.window_position += Vector2(-80, -60)
	if Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left"):
		OS.window_size -= Vector2(160, 120)
		OS.window_position -= Vector2(-80, -60)
