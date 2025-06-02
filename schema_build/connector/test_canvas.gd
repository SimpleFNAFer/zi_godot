extends Node2D
class_name TestCanvas

var rect: Rect2


func _init(r: Rect2) -> void:
	rect = r
	

func _draw() -> void:
	draw_rect(rect, Color(1,1,1,1))
