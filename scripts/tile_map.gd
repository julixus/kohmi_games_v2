extends TileMap


func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var clicked_cell_coords = local_to_map(get_local_mouse_position())
		var overlay_pos = get_global_mouse_position()
		

		# Optional: prüfe, ob da überhaupt ein Tile ist
		var tile_id = get_cell_source_id(1, clicked_cell_coords)
		
		var overlay = Sprite2D.new()
		overlay.texture = preload("res://res/rot.png") # deine Overlay-Grafik
		overlay.position = overlay_pos
		overlay.modulate = Color(1, 1, 1, 0.6) # weiß, halbtransparent
		overlay.z_index = 100 # über der Tilemap
		
		get_tree().current_scene.add_child(overlay)

		var tween = create_tween()
		tween.tween_property(overlay, "modulate:a", 0.0, 0.3)
		tween.tween_callback(Callable(overlay, "queue_free"))
