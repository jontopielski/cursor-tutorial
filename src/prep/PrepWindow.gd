extends Control

export(Texture) var atlas = null

func _ready():
	generate_colored_tiles()
	$TileMap.hide()
	for background in $Backgrounds.get_children():
		randomize()
		background.color = Color(randf(), randf(), randf()).darkened(1.0)

func recolor_tiles():
	for tile in $Textures.get_children():
		randomize()
		tile.modulate = Color(randf(), randf(), randf())

func generate_colored_tiles():
	for tile in $Textures.get_children():
		tile.queue_free()
	for used_cell in $TileMap.get_used_cells():
		var next_atlas = AtlasTexture.new()
		next_atlas.atlas = atlas
		next_atlas.region.size = Vector2(4, 4)
		next_atlas.region.position = $TileMap.get_cell_autotile_coord(used_cell.x, used_cell.y) * 4.0
		
		var next_texture = TextureRect.new()
		next_texture.texture = next_atlas
		$Textures.add_child(next_texture)
		
		next_texture.rect_position = used_cell * 4.0
		next_texture.flip_h = $TileMap.is_cell_x_flipped(used_cell.x, used_cell.y)
		next_texture.flip_v = $TileMap.is_cell_y_flipped(used_cell.x, used_cell.y)
		
		randomize()
		next_texture.modulate = Color(randf(), randf(), randf()).lightened(0.5)

func _process(delta):
	if Input.is_action_just_pressed("ui_screenshot") and OS.is_debug_build():
		var image = get_viewport().get_texture().get_data()
		image.flip_y()
		image.save_png("C:\\Users\\jonto\\Desktop\\Game_Screenshot_%s.png" % str(randi() % 1000))
	if Input.is_action_just_pressed("ui_reset"):
		get_tree().change_scene("res://src/Window.tscn")

func _on_Timer_timeout():
	recolor_tiles()
