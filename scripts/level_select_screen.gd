extends Control

const LEVEL_BUTTON = preload("res://scenes/level_button.tscn")

@export_dir var dir_path

@onready var grid = $MarginContainer/VBoxContainer/GridContainer

func _ready() -> void:
	get_levels(dir_path)

func get_levels(path) -> void:
	var dir = DirAccess.open(path)
	var level_incrementer = 0
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			print(file_name)
			level_incrementer += 1
			create_level_button('%s/%s' % [dir.get_current_dir(), file_name], "Bane " + str(level_incrementer))
			file_name = dir.get_next()
		dir.list_dir_end()
	else:
		print('An error occurred when trying to access the path')
		
func create_level_button(level_path: String, level_name: String) -> void:
	var button = LEVEL_BUTTON.instantiate()
	button.text = level_name
	button.level_path = level_path
	grid.add_child(button)
