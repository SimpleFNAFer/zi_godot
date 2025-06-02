extends Button

func _on_button_down() -> void:
	scenes.save_threats()
	scenes.load_measures()
