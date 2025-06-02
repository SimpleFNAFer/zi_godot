extends VBoxContainer

@onready var root_node = $/root/Root

var component = preload("res://Router.tscn")
var desc = preload("res://Description.tscn")
var desc_instance

func _on_button_button_down() -> void:
	var instance = component.instantiate()
	instance.global_position = global_position
	instance.dragging = true
	root_node.add_child(instance)
	


func _on_button_mouse_entered() -> void:
	if desc_instance == null:
		desc_instance = desc.instantiate()
		desc_instance.name = "RouterDescription"
		desc_instance.get_node("RichTextLabel").text = "Шлюз"
		desc_instance.visible = true
		desc_instance.global_position = get_global_mouse_position() - Vector2(0, desc_instance.size.y)
		root_node.add_child(desc_instance)


func _on_button_mouse_exited() -> void:
	$/root/Root/RouterDescription.queue_free()
	desc_instance = null
