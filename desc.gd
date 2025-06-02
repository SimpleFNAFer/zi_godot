extends Control

var desc_text: String
var display_name: String

func _process(_delta: float) -> void:
	$panel/name.text = display_name
	$panel/desc_text.text = desc_text


func _on_button_button_down() -> void:
	queue_free()
