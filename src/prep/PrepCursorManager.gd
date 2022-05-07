extends CanvasLayer

export(Texture) var empty_cursor = null
export(Texture) var default_cursor = null
export(Texture) var precision_cursor = null
export(Vector2) var base_window_size = Vector2.ZERO

enum MouseMode {
	SCALE,
	PIXEL
}

var current_mode = MouseMode.SCALE

func _ready():
	Input.set_custom_mouse_cursor(empty_cursor, Input.CURSOR_ARROW)
	get_tree().connect("screen_resized", self, "update_cursor")
	$Sprite.hide()
	update_cursor()

func _process(delta):
	$Sprite.global_position = $Sprite.get_global_mouse_position()
	if Input.is_action_just_pressed("ui_change_mode"):
		current_mode = MouseMode.PIXEL if current_mode == MouseMode.SCALE else MouseMode.SCALE
		update_cursor()

func update_cursor():
	if current_mode == MouseMode.SCALE:
		$Sprite.hide()
		var current_window_size = OS.window_size
		var scale_multiple = min(floor(current_window_size.x / base_window_size.x), floor(current_window_size.y / base_window_size.y))
		var texture = ImageTexture.new()
		var image = default_cursor.get_data()
		image.resize(8 * scale_multiple + 8, 8 * scale_multiple + 8, Image.INTERPOLATE_NEAREST)
		texture.create_from_image(image)
		
		Input.set_custom_mouse_cursor(texture, Input.CURSOR_ARROW)
	else:
		Input.set_custom_mouse_cursor(empty_cursor, Input.CURSOR_ARROW)
		$Sprite.show()
