extends Node

var schema_build_scene = preload("res://schema_build.tscn")
var threats_scene = preload("res://threats.tscn")
var measures_scene = preload("res://measures/measures.tscn")
var final_success_scene = preload("res://final_success.tscn")
var final_fail_scene = preload("res://final_fail.tscn")

var schema_build
var threats
var measures
var szi

var final_success
var final_fail


func _ready() -> void:
	schema_build = get_tree().root.get_node("schema_build")


func save_schema_build():
	if schema_build == null:
		schema_build = schema_build_scene.instantiate()
	schema_build.visible = false
	schema_build.z_index -= 1
	
	
func load_schema_build():
	if schema_build != null:
		schema_build.visible = true
		schema_build.z_index += 1
	else:
		schema_build = schema_build_scene.instantiate()
		get_tree().root.add_child(schema_build)
		
		
func save_threats():
	if threats != null:
		threats.visible = false
		threats.z_index -= 1


func load_threats():
	if threats != null:
		threats.visible = true
		threats.z_index += 1
	else:
		threats = threats_scene.instantiate()
		get_tree().root.add_child(threats)


func reload_threats():
	if threats != null:
		threats.queue_free()
	threats = threats_scene.instantiate()
	threats.visible = false
	threats.z_index -= 1
	get_tree().root.add_child(threats)


func save_measures():
	if measures != null:
		measures.visible = false
		measures.z_index -= 1
	
	
func load_measures():
	if measures != null:
		measures.visible = true
		measures.z_index += 1
	else:
		measures = measures_scene.instantiate()
		get_tree().root.add_child(measures)


func reload_measures():
	if measures != null:
		measures.queue_free()
	measures = measures_scene.instantiate()
	measures.visible = false
	measures.z_index -= 1
	get_tree().root.add_child(measures)


func load_final():
	if len(actual_threats.not_taken_measures) == 0:
		load_final_success()
	else:
		load_final_fail()


func load_final_success():
	final_success = final_success_scene.instantiate()
	get_tree().root.add_child(final_success)


func drop_final_success():
	final_success.queue_free()
	load_schema_build()


func load_final_fail():
	final_fail = final_fail_scene.instantiate()
	get_tree().root.add_child(final_fail)


func drop_final_fail():
	actual_threats.not_taken_measures = {}
	final_fail.queue_free()
	load_schema_build()
