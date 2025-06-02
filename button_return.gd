extends Button

var rng = RandomNumberGenerator.new()

func _on_button_down() -> void:
	if rng.randi_range(0, 1) > 0:
		get_tree().change_scene_to_file("res://FinalSuccess.tscn")
	else:
		get_tree().change_scene_to_file("res://FinalFail.tscn")
