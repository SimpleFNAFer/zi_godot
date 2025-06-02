extends PanelContainer

func _process(_delta: float) -> void:
	global_position = get_global_mouse_position() - Vector2(0, size.y)
