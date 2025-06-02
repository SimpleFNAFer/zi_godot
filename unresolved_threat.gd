extends Control

@onready var threat = $panel/container/threat
@onready var measures = $panel/container/scroll/measures

var t = ""
var ms = []

func _ready() -> void:
	fill()

func fill():
	threat.text = "[b]"+t+"[/b]"
	for m in ms:
		var measure = RichTextLabel.new()
		measure.custom_minimum_size = Vector2(200, 50)
		measure.text = m
		measure.name = m
		measures.add_child(measure)
