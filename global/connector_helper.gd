extends Node

const components_container_path = "/root/schema_build/items/components"
const connectors_container_path = "/root/schema_build/items/connectors"

var components_container: Control
var connectors_container: Node2D

func _process(_delta: float) -> void:
	if components_container == null:
		components_container = get_node_or_null(components_container_path)
	if connectors_container == null:
		connectors_container = get_node_or_null(connectors_container_path)


func get_item_by_position(pos: Vector2) -> Item:
	if components_container == null:
		return null
	
	for component in components_container.get_children():
		if component.get_rect().has_point(pos):
			return component
	
	return null


func is_now_building(type: int) -> bool:
	if connectors_container == null:
		return false
	
	for connector: Connector in connectors_container.get_children():
		if connector.type == type && connector.is_building:
			return true
	
	return false
