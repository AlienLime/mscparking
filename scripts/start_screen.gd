extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("ID,Time,Event,Value")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	get_tree().change_scene_to_file.call_deferred("res://scenes/menu.tscn")
