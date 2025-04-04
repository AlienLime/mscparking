extends Node2D

func _ready() -> void:
	print("ID " + str(randi_range(10000000, 99999999)))
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
