extends Node2D

func _ready() -> void:
	print("ID,Time,Event,Value")
	
func _process(delta: float) -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/menu.tscn")
