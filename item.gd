extends Control
class_name Item

var vuls_scene = preload("res://vul.tscn")

var icon: Texture2D
var threats: Array
var vuls: Array
var display_name: String

var dragging = false
var of = Vector2(0, 0)
var threats_added = false

@onready var field = $/root/schema_build/field

func position_in_field(pos: Vector2) -> bool:
	return field.get_rect().has_point(pos)

func _process(_delta: float) -> void:
	$Sprite2D.texture = icon
	if dragging:
		global_position = get_global_mouse_position() - of


func _on_button_button_down() -> void:
	dragging = true
	of = get_global_mouse_position() - global_position

func _on_button_button_up() -> void:
	dragging = false
	
	if !position_in_field(global_position):
		if threats_added:
			actual_threats.remove_threats(threats)
			scenes.reload_threats()
		queue_free()
		
	if !threats_added:
		actual_threats.add_threats(threats)
		scenes.reload_threats()
		threats_added = true


func _on_alert_button_down() -> void:
	var vuls_scene_inst = vuls_scene.instantiate()
	vuls_scene_inst.vuls = vuls
	get_tree().root.add_child(vuls_scene_inst)
