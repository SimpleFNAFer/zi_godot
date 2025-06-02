extends Control

const icon_path_prefix = "res://assets/icon/measure/"

var desc_icon: Texture2D = load(icon_path_prefix+"desc.svg")
var i_icon: Texture2D = load(icon_path_prefix+"i.svg")
var ip_icon: Texture2D = load(icon_path_prefix+"ip.svg")
var ni_icon: Texture2D = load(icon_path_prefix+"ni.svg")
var tech_icon: Texture2D = load(icon_path_prefix+"tech.svg")
var org_icon: Texture2D = load(icon_path_prefix+"org.svg")

@onready var base = $bg/HBoxContainer/base/scroll/tree
@onready var adv = $bg/HBoxContainer/adv/scroll/tree

func _ready() -> void:
	var cls = actual_threats.schema_class
	
	init_measures_tree(
		base, 
		data.class_measures_parsed[cls]
	)
	init_measures_tree(
		adv, 
		data.class_measures_adv_parsed[cls]
	)
	
	base.item_edited.connect(_on_base_edited)
	adv.item_edited.connect(_on_adv_edited)
	
	sync_tree(base)
	sync_tree(adv)


func build_tree_item(
	tree, 
	root, 
	column,
	text,
	metadata,
	create_button = false,
	set_icon = -1,
	cmh = 100,
	set_cell_mode = true
	) -> TreeItem:
	
	var i: TreeItem = tree.create_item(root)
	i.set_editable(column, false)
	i.custom_minimum_height = cmh
	if set_cell_mode:
		i.set_cell_mode(column, TreeItem.CELL_MODE_CHECK)
		i.set_editable(column, true)
	
	match set_icon:
		0.0: i.set_icon(column, ni_icon)
		1.0: i.set_icon(column, ip_icon)
		2.0: i.set_icon(column, i_icon)
		3: i.set_icon(column, tech_icon)
		4: i.set_icon(column, org_icon)
	
	i.set_text(column, text)
	i.set_metadata(column, metadata)
	
	if create_button:
		i.add_button(column, desc_icon)
	
	return i


func init_measures_tree(tree: Tree, measures: Dictionary):
	var root = tree.create_item()
	tree.hide_root = true
	
	for mg in measures.keys():
		var mg_item = build_tree_item(tree, root, 0, mg, "group")
		
		for m in measures[mg].keys():
			var measure = measures[mg][m]
			var m_item = build_tree_item(
				tree, 
				mg_item, 
				0,
				mg+m+" "+measure["title"],
				"single:"+mg+m,
				true,
				measure["implementable"],
				90
			)
			
			if !measure.has("compensation"):
				continue
			
			build_tree_item(
				tree, m_item, 0, "Компенсирующие меры", "comp", false, -1, 30
			)
			
			if measure["compensation"].has("tech"):
				for text in measure["compensation"]["tech"]:
					build_tree_item(
						tree, m_item, 0, text, "", false, 3, 30, false
					)
			
			if measure["compensation"].has("org"):
				for text in measure["compensation"]["org"]:
					build_tree_item(
						tree, m_item, 0, text, "", false, 4, 30, false
					)
			
		mg_item.collapsed = true


func parse_metadata(item, column):
	var metadata = item.get_metadata(column)
	var arr = metadata.split(":")
	var res = { "type": arr[0] }
	if len(arr) > 1:
		res["measure"] = arr[1]
		
	return res


func _on_base_edited():
	var item: TreeItem = base.get_edited()
	var column = base.get_edited_column()
	
	_on_edited(item, column)


func _on_adv_edited():
	var item: TreeItem = adv.get_edited()
	var column = adv.get_edited_column()
	
	_on_edited(item, column)


func _on_edited(item: TreeItem, column):
	var metadata = parse_metadata(item, column)
	
	if metadata["type"] == "group":
		_on_edited_group(item, column)
	elif metadata["type"] == "single":
		_on_edited_measure(item, column)
	elif metadata["type"] == "comp":
		_on_edited_comp(item, column)


func _on_edited_group(item: TreeItem, column):
	var add = item.is_checked(column)
	for child: TreeItem in item.get_children():
		var m = parse_metadata(child, column)["measure"]
		if !actual_threats.taken_measures.has(m) || !add:
			check_measure(item.is_checked(column), m)
	
	sync_tree(item.get_tree())


func _on_edited_measure(item: TreeItem, column):
	var md = parse_metadata(item, column)
	check_measure(item.is_checked(column), md["measure"])
	sync_tree(item.get_tree())


func _on_edited_comp(item: TreeItem, column):
	var parent_md = parse_metadata(item.get_parent(), column)
	check_measure(item.is_checked(column), parent_md["measure"], true)
	sync_tree(item.get_tree())


func check_measure(is_add, measure, comp = false):
	if is_add:
		actual_threats.add_taken_measure(measure, comp)
	else:
		actual_threats.remove_taken_measure(measure)


func sync_tree(tree: Tree):
	for g in tree.get_root().get_children():
		
		var checked_g_measures = 0
		
		for m in g.get_children():
			var measure = parse_metadata(m, 0)["measure"]
			
			if !actual_threats.taken_measures.has(measure):
				m.set_checked(0, false)
				if m.get_child_count() > 0:
					m.get_first_child().set_checked(0, false)
				continue
			
			var taken_type = actual_threats.taken_measures[measure]
			
			if m.get_child_count() == 0:
				m.set_checked(0, true)
			elif taken_type == 1:
				m.set_checked(0, true)
				m.get_first_child().set_checked(0, false)
			elif taken_type == 2:
				m.set_checked(0, false)
				m.get_first_child().set_checked(0, true)
			
			checked_g_measures += 1
		
		if checked_g_measures == g.get_child_count():
			g.set_checked(0, true)
		else:
			g.set_checked(0, false)
