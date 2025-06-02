extends Control

const inventory_item_path = "res://inventory_item.tscn"
const connector_item = preload("res://schema_build/inventory/connector/connector_item.tscn")
const desc_path_prefix = "res://assets/desc"
const icon_path_prefix = "res://assets/icon"

@onready var components = $panel/tabs/components/grid_container
@onready var connectors = $panel/tabs/connectors/grid_container


func _ready() -> void:
	$panel/tabs.set_tab_title(0, "Компоненты")
	for component in data.components:
		components.add_child(
			create_component_item(component)
		)
	$panel/tabs.set_tab_title(1, "Каналы связи")
	for connector in data.connectors:
		connectors.add_child(
			create_connector_item(connector)
		)


func create_component_item(item_data):
	var item = load(inventory_item_path).instantiate()
	item.name = item_data["name"]
	item.display_name = item_data["display_name"]
	item.icon = get_icon_from_file(icon_path_prefix+"/component/"+item_data["icon_path"])
	item.desc = get_desc_from_file(desc_path_prefix+"/component/"+item_data["desc_path"])
	item.threats = item_data["threats"]
	item.vuls = item_data["vuls"]
	return item


func create_connector_item(item_data):
	var item = connector_item.instantiate()
	item.name = item_data["name"]
	item.display_name = item_data["display_name"]
	item.icon = get_icon_from_file(
		icon_path_prefix+"/connector/"+item_data["icon_path"]
	)
	item.icon_active = get_icon_from_file(
		icon_path_prefix+"/connector/"+item_data["icon_active_path"]
	)
	item.threats = item_data["threats"]
	item.vuls = item_data["vuls"]
	item.visible = true
	return item


func get_desc_from_file(path: String) -> String:
	if !FileAccess.file_exists(path):
		return ""
	
	return FileAccess.open(path, FileAccess.READ).get_as_text()


func get_icon_from_file(path: String):
	if !FileAccess.file_exists(path):
		path = "res://assets/icon/unknown.png"
	
	return load(path)
