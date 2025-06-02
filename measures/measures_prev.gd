extends Button


func _on_button_down() -> void:
	scenes.load_threats()
	scenes.save_measures()
