extends VBoxContainer

@onready var components_root = $/root/schema_build/items/components

const click_threshold = 0.2
const desc_path = "res://desc.tscn"
const item_path = "res://item.tscn"

var display_name: String
var icon: Texture2D
var desc: String
var threats: Array
var vuls: Array

var pressed_time


func _ready() -> void:
	$display_name.text = display_name
	$icon.texture = icon


func _process(_delta: float) -> void:
	if pressed_time != null && !check_click_threshold():
		create_item()
		pressed_time = null
	

func _on_button_button_down() -> void:
	if pressed_time == null:
		pressed_time = Time.get_unix_time_from_system()


func _on_button_button_up() -> void:
	if pressed_time != null && check_click_threshold():
		create_desc()
		pressed_time = null


func check_click_threshold() -> bool:
	return Time.get_unix_time_from_system() - pressed_time <= click_threshold


func create_desc():
	var instance = load(desc_path).instantiate()
	instance.name = name+"_desc"
	instance.desc_text = desc
	instance.display_name = display_name
	get_tree().root.add_child(instance)


func create_item():
	var instance : Control = load(item_path).instantiate()
	instance.threats = threats
	instance.vuls = vuls
	instance.icon = icon
	instance.display_name = display_name
	instance.global_position = global_position
	instance.dragging = true
	components_root.add_child(instance)
