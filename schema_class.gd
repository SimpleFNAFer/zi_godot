extends OptionButton


func _ready() -> void:
	actual_threats.set_schema_class(get_item_text(get_selected_id()))


func _on_item_selected(index: int) -> void:
	actual_threats.set_schema_class(get_item_text(index))
	scenes.reload_measures()
