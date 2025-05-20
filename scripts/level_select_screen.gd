extends Control

const LEVEL_BUTTON = preload("res://scenes/level_button.tscn")


@export_dir var dir_path

@onready var grid1: GridContainer = $MarginContainer/VBoxContainer/GridContainer1
@onready var grid2: GridContainer = $MarginContainer/VBoxContainer/GridContainer2
@onready var grid3: GridContainer = $MarginContainer/VBoxContainer/GridContainer3

func _ready() -> void:
	get_levels(dir_path)

func get_levels(path) -> void:
	var dir = ResourceLoader.list_directory(path)
	var level_incrementer = 0
	if dir:
		var file_name
		while level_incrementer < dir.size():
			file_name = dir.get(level_incrementer)
			level_incrementer += 1
			create_level_button('%s/%s' % [path, file_name], file_name.get_basename(), int(file_name[0]))
	else:
		print(Globals.USERID + ",NOTIME,Error,An error occurred when trying to access the path")
		

func create_level_button(level_path: String, level_name: String, stage: int) -> void:
	var button = LEVEL_BUTTON.instantiate()
	button.text = level_name
	button.level_path = level_path
	match stage:
		1:
			grid1.add_child(button)
		2:
			grid2.add_child(button)
		3:
			grid3.add_child(button)


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/menu.tscn")
