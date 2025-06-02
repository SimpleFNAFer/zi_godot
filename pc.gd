extends Panel

var dragging = false
var of = Vector2(0, 0)
@onready var field = $/root/Root/Field

func position_in_field(pos: Vector2) -> bool:
	return field.get_rect().has_point(pos)

func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - of


func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false
	if !position_in_field(global_position):
		queue_free()
