extends Control

@onready var unresolved = $scroll/unresolved

var uts = preload("res://unresolved_threat.tscn")


func _ready() -> void:
	var ntm = actual_threats.not_taken_measures
	for t in ntm.keys():
		var ms = ntm[t].keys()
		var ut = uts.instantiate()
		ut.t = data.threats_dict[t]["display_name"]
		ut.ms = ms
		unresolved.add_child(ut)
		
