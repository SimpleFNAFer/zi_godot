extends Button


func validate():
	var not_taken = {}
	
	for key in actual_threats.threats.keys():
		var wanted_measures = data.threat_measure[key]
		
		for wm in wanted_measures:
			if !actual_threats.taken_measures.has(wm):
				if not_taken.has(key):
					not_taken[key][wm] = 1
				else:
					not_taken[key] = { wm: 1 }
	
	return not_taken


func _on_button_down() -> void:
	actual_threats.not_taken_measures = validate()
	scenes.save_measures()
	scenes.load_final()
