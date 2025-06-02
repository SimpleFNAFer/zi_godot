extends VBoxContainer
class_name ConnectorInvItem

var conn_scene = preload("res://schema_build/connector/connector.tscn")

@onready var connectors_root = $/root/schema_build/items/connectors
@onready var display_name_node = $display_name
@onready var icon_node = $icon

var display_name: String
var icon: Texture2D
var icon_active: Texture2D
var threats: Array
var vuls: Array


func _ready() -> void:
	display_name_node.text = display_name
	icon_node.texture = icon


func _process(_delta: float) -> void:
	if connector_helper.is_now_building(get_type()):
		icon_node.texture = icon_active
	else:
		icon_node.texture = icon


func create_connector():
	var conn = conn_scene.instantiate()
	conn.threats = threats
	conn.vuls = vuls
	conn.type = get_type()
	connectors_root.add_child(conn)


func _on_button_button_down() -> void:
	create_connector()


func get_type() -> int:
	if name == "wire":
		return 0
	elif name == "wireless":
		return 1
	
	return -1
