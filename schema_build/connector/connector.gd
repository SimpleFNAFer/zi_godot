extends Line2D
class_name Connector

@onready var alert_button = $alert

var vuls_scene = preload("res://vul.tscn")
var wireless_texture: Texture2D = load("res://assets/texture/wireless.svg")

var begin: Item
var end: Item
var type: int
var w = 10
var is_building = true
var build_circle: BuildCircle
var threats: Array
var vuls: Array

var fp: Vector2
var sp: Vector2


func _ready() -> void:
	width = w
	add_point(Vector2(0, 0))
	add_point(Vector2(0, 0))
	if type == 0:
		default_color = Color("#4287f5", 1)
	elif type == 1:
		texture_mode = Line2D.LINE_TEXTURE_TILE
		texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED
		set_texture(wireless_texture)
	if is_building:
		add_build_circle()


func _process(_delta: float) -> void:
	_process_state()
	if is_building:
		_process_build_circle()
		_process_cancel()
		_process_building()
	else:
		alert_button.position = get_alert_button_position()
		_process_deletion()


func _process_state():
	#if (!fp || !sp) && !is_building:
		#queue_free()
	#if fp:
		#set_point_position(0, fp)
	#if fp && !sp:
		#set_point_position(1, get_global_mouse_position())
	#if sp:
		#set_point_position(1, sp)
	
	if (begin == null || end == null) && !is_building:
		queue_free()
	if begin != null:
		set_point_position(0, begin.get_global_rect().get_center())
	if begin != null && end == null:
		set_point_position(1, get_global_mouse_position())
	if end != null:
		set_point_position(1, end.get_global_rect().get_center())


func _process_building():
	#if Input.is_action_just_pressed("lmb_click"):
		#if !fp:
			#fp = get_global_mouse_position()
		#elif !sp:
			#sp = get_global_mouse_position()
			#is_building = false
	
	if Input.is_action_just_pressed("lmb_click"):
		var component = connector_helper.get_item_by_position(
			get_global_mouse_position()
		)
		print(component)
		
		if begin == null && component != null:
			begin = component
		elif end == null && component != null:
			end = component
			is_building = false
			remove_build_circle()
			actual_threats.add_threats(threats)


func _process_cancel():
	if Input.is_action_just_pressed("rmb_click"):
		queue_free()


func _process_deletion():
	if Input.is_action_just_pressed("rmb_click"):
		if _mouse_in_line():
			actual_threats.remove_threats(threats)
			queue_free()


func _mouse_in_line() -> bool:
	var mouse_pos = get_global_mouse_position()
	var a = to_global(points[0])
	var b = to_global(points[1])

	var ab = b - a
	var ap = mouse_pos - a

	var ab_length = ab.length()
	if ab_length == 0:
		return false
	
	var t = clamp(ab.dot(ap) / ab_length**2, 0.0, 1.0)
	var closest_point = a + ab * t

	return mouse_pos.distance_to(closest_point) <= width


func _on_alert_button_down():
	var vuls_scene_inst = vuls_scene.instantiate()
	vuls_scene_inst.vuls = vuls
	get_tree().root.add_child(vuls_scene_inst)


func get_alert_button_position() -> Vector2:
	var a = to_global(points[0])
	var b = to_global(points[1])
	return (a + b) * 0.5 - alert_button.size * 0.5


func add_build_circle():
	if build_circle == null:
		build_circle = BuildCircle.new()
		add_child(build_circle)

func _process_build_circle():
	if build_circle != null:
		build_circle.queue_redraw()

func remove_build_circle():
	if build_circle != null:
		build_circle.queue_free()
