extends Node2D
class_name BuildCircle

var radius = 20

func _draw() -> void:
	draw_circle(
		get_global_mouse_position(),
		20,
		Color("#4287f5c8")
	)
