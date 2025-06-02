extends VBoxContainer

@onready var root_node = $/root/Root

var component = preload("res://LocalServer.tscn")
var desc = preload("res://Description.tscn")
var desc_instance

func _on_button_button_down() -> void:
	var instance = component.instantiate()
	instance.global_position = global_position
	instance.dragging = true
	root_node.add_child(instance)
	


func _on_button_mouse_entered() -> void:
	if desc_instance == null:
		desc_instance = desc.instantiate()
		desc_instance.name = "LocalServerDescription"
		desc_instance.get_node("RichTextLabel").text = "Платформы для сбора и обработки данных (на серверах или в облаке) обеспечивают сбор и обработку в реальном времени, проведение ангалитики:
OSIsoft PI
GE Predix
Платформы виртуализации и симуляции: (расположены в облаке, дата-центре или локальном сервере) – здесь происходит машинное обучение и искусственный интеллект и AI и аналитика:
AVEVA (виртуализация и симуляция. Создает виртуальных двойников, предсказывает износ и отказы)
Siemens Tecnomatix (виртуализация и симуляция. Создает виртуальных двойников, предсказывает износ и отказы)
PTC ThingWorx (виртуализация и симуляция. Создает виртуальных двойников, предсказывает износ и отказы)
Custom Digital Twin Platform (обеспечивает взаимодействие с физическим объектом. Моделирует поведение)
Многие компании разрабатывают собственные платформы машинного обучения и искусственного интеллекта
TensorFlow (машинное обучение и аналитика……анализ данных, предсказания, оптимизация)
Scikit-learn (машинное обучение и аналитика……анализ данных, предсказания, оптимизация)
Azure ML (машинное обучение и аналитика……анализ данных, предсказания, оптимизация)
OSISoft PI System (реальное время, исторические данные, мониторинг)
SCADA – СИСТЕМЫ – ДЛЯ СБОРА ДАННЫХ И ВИРТУАЛИЗАЦИИ
IoT – платформы – для обработки данных с датчиков
Ignition
Wonderware
Siemens Win CC
IIoT – платформы для сбора, обработки и анализа данных с датчиков и IoT – устройств (GE Digital, Siemens MindSphere, PTC ThingWorx, Microsoft Azure IoT)
Платформы для 3D – моделеирования и визуализции (Dassault Systemes 3DEXPERIENCE, Bentley Systems MicroStation, Autodesk Civil 3D)
Платформы для анализа данных и машинного обучения (Python, R, TensorFlow, PyTorch, Apache Spark)
Системы управления базами данных (Oracle, Microsoft SQL Srver, PostgreSQL)

ПО для моделирования и симуляции виртуального объекта на локальном сервере или промышленном компьютере:
MATLAB
Simulink
ANSYS
ПО для планирования и оптимизации горных работ (Deswik, Whittle)
ПО для мониторинга состояния оборудования (AVEVA System Platform, OSIsoft PI System)
ПО для управления производством (MES) для управления и контроля производственным процессом (SAP Mnufacturing Execution, Siemens Opcenter).



ПО для моделирования и симуляции:
MATLAB
Simulink
ANSYS
ПО (для хранения инфоормации):
MongoDB – NoSQL базы
Реляционная система управления базами данных – базы данных SQL, PostgreSQL и другие
"
		desc_instance.visible = true
		desc_instance.global_position = get_global_mouse_position() - Vector2(0, desc_instance.size.y)
		root_node.add_child(desc_instance)


func _on_button_mouse_exited() -> void:
	$/root/Root/LocalServerDescription.queue_free()
	desc_instance = null
