extends Control

func _ready() -> void:
	for threat in actual_threats.threats.keys():
		var hbc = HBoxContainer.new()
		hbc.custom_minimum_size = Vector2(800, 100)
		var code = RichTextLabel.new()
		code.text = data.threats_dict[threat]["display_name"]
		code.custom_minimum_size = Vector2(150, 100)
		var desc = RichTextLabel.new()
		desc.text = data.threats_dict[threat]["desc"]
		desc.custom_minimum_size = Vector2(600, 100)
		hbc.add_child(code)
		hbc.add_child(desc)
		$ColorRect/Panel/ScrollContainer/VBoxContainer.add_child(hbc)
		$ColorRect/Panel/ScrollContainer/VBoxContainer.size += Vector2(0, 50)
		$ColorRect/Panel/ScrollContainer.queue_sort()
