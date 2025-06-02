extends Button

func _on_button_down() -> void:
	scenes.save_schema_build()
	scenes.load_threats()
	
