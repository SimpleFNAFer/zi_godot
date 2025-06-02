extends Control

@onready var container = $ScrollContainer/VBoxContainer

var vuls: Array

func _ready() -> void:
	for vul in vuls:		
		var rtl = RichTextLabel.new()
		rtl.text = vul
		rtl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		rtl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		rtl.set_anchors_preset(Control.PRESET_FULL_RECT)
		
		var panel = Panel.new()
		panel.size_flags_horizontal = Control.SIZE_FILL
		panel.custom_minimum_size.y = 100
		
		container.add_child(panel)
		panel.add_child(rtl)


func _on_button_button_down() -> void:
	queue_free()
