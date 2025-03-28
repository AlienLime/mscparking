extends Control

const LEVEL_BUTTON = preload("res://scenes/level_button.tscn")


@export_dir var dir_path

@onready var grid = $MarginContainer/VBoxContainer/GridContainer

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
			create_level_button('%s/%s' % [path, file_name], "Bane " + str(level_incrementer))
	else:
		print('An error occurred when trying to access the path')
		
		

func create_level_button(level_path: String, level_name: String) -> void:
	var button = LEVEL_BUTTON.instantiate()
	button.text = level_name
	button.level_path = level_path
	grid.add_child(button)
