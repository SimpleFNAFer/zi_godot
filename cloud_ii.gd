extends VBoxContainer

@onready var root_node = $/root/Root

var component = preload("res://Cloud.tscn")
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
		desc_instance.name = "CloudDescription"
		desc_instance.get_node("RichTextLabel").text = "
Облако (AWS, Azure, Google Cloud)

Облачные платформы (В ОБЛАКЕ НАХОДЯТСЯ И ОБЕСПЕЧИВАЮТ ХРАНЕНИЕ И ОБРАБОТКУ ИНФОРМАЦИИ, машинное обучение, моделирование):
Caterpillar VisionLink
Azure IoT
AWS S3
Azure Blob Storage
Amazon S3
Azure Blob Storage
Google Cloud Storage
Microsoft Azure
Amazon AWS
Azure IoT Hub
AWS IoT (передача данных, моделирование, предиктивная аналитика. Обеспечивает обработку, хранение, аналитику)
"
		desc_instance.visible = true
		desc_instance.global_position = get_global_mouse_position() - Vector2(0, desc_instance.size.y)
		root_node.add_child(desc_instance)


func _on_button_mouse_exited() -> void:
	$/root/Root/CloudDescription.queue_free()
	desc_instance = null
