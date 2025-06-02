extends Node

const type_array = 0
const type_dictionary = 1

const components_path = "res://assets/data/component.json"
const connectors_path = "res://assets/data/connector.json"
const measures_path = "res://assets/data/measure.json"
const szi_path = "res://assets/data/szi.json"
const threats_path = "res://assets/data/threat.json"
const users_path = "res://assets/data/user.json"

const class_measures_path = "res://assets/data/class-measure.json"
const threat_measure_path = "res://assets/data/threat-measure.json"

var components: Array
var connectors: Array
var measures: Array
var szi: Array
var threats: Array
var users: Array
var class_measures: Dictionary
var threat_measure: Dictionary

var threats_dict: Dictionary
var measures_dict: Dictionary
var measures_dict_parsed: Dictionary
var class_measures_parsed: Dictionary
var class_measures_adv_parsed: Dictionary


func _ready() -> void:
	components = load_json(components_path, type_array)
	
	connectors = load_json(connectors_path, type_array)
	
	measures = load_json(measures_path, type_array)
	prepare_measures_dict()
	parse_measures_dict()
	
	szi = load_json(szi_path, type_array)
	
	threats = load_json(threats_path, type_array)
	prepare_threats_dict()
	
	users = load_json(users_path, type_array)
	
	class_measures = load_json(class_measures_path, type_dictionary)
	parse_class_measures()
	parse_class_measures_adv()
	
	threat_measure = load_json(threat_measure_path, type_dictionary)


func load_json(path, type):
	if !FileAccess.file_exists(path):
		print(path + " does not exist")
		return
		
	var file_data = FileAccess.open(path, FileAccess.READ)
	var parsed_data = JSON.parse_string(file_data.get_as_text())
	
	var correct_format = false
	match type:
		0: correct_format = parsed_data is Array
		1: correct_format = parsed_data is Dictionary
	
	if correct_format:
		return parsed_data
	else:
		print(path+" incorrect file format")


func prepare_threats_dict():
	for threat in threats:
		threats_dict[threat["name"]] = threat


func prepare_measures_dict():
	for measure in measures:
		measures_dict[measure["group"]+measure["group_id"]] = measure


func parse_measures_dict():
	for measure in measures:
		if !measures_dict_parsed.has(measure["group"]):
			measures_dict_parsed[measure["group"]] = {}
		measures_dict_parsed[measure["group"]][measure["group_id"]] = measure


func deepcopy_dict(dict: Dictionary) -> Dictionary:
	var res = {}
	for k in dict.keys():
		if dict[k] is Dictionary:
			res[k] = deepcopy_dict(dict[k])
		elif dict[k] is Array:
			res[k] = deepcopy_array(dict[k])
		else:
			res[k] = dict[k]
	return res


func deepcopy_array(arr: Array) -> Array:
	var res = []
	for elem in arr:
		if elem is Dictionary:
			res.append(deepcopy_dict(elem))
		elif elem is Array:
			res.append(deepcopy_array(elem))
		else:
			res.append(elem)
	return res


func parse_class_measures():
	for cls in class_measures.keys():
		class_measures_parsed[cls] = {}
		for mkey in class_measures[cls]:
			if !measures_dict.has(mkey):
				continue
			
			var measure = measures_dict[mkey]
			
			if !class_measures_parsed[cls].has(measure["group"]):
				class_measures_parsed[cls][measure["group"]] = {}
			
			class_measures_parsed[cls][measure["group"]][measure["group_id"]] = measure


func parse_class_measures_adv():
	class_measures_adv_parsed = {}
	
	for cls in class_measures_parsed.keys():
		class_measures_adv_parsed[cls] = deepcopy_dict(measures_dict_parsed) 
	
	for cls in class_measures_parsed.keys():
		for g in class_measures_parsed[cls].keys():
			if !class_measures_adv_parsed[cls].has(g):
				continue
			
			for m in class_measures_parsed[cls][g].keys():
				if class_measures_adv_parsed[cls][g].has(m):
					class_measures_adv_parsed[cls][g].erase(m)
			
			if len(class_measures_adv_parsed[cls][g]) == 0:
				class_measures_adv_parsed[cls].erase(g)
