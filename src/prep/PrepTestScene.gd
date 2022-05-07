extends TextureRect

const CursorManager = preload("res://src/prep/PrepCursorManager.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if get_child_count() == 0:
			var manager = CursorManager.instance()
			add_child(manager)
		else:
			Input.set_custom_mouse_cursor(null, Input.CURSOR_ARROW)
			get_child(0).queue_free()
