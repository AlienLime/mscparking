extends Node2D

func _ready() -> void:
	print("ID " + str(randi_range(10000000, 99999999)))

func _process(delta: float) -> void:
	# Click thorugh the intro to enable gameplay
	if Input.is_action_just_pressed("mouse"):
		get_tree().change_scene_to_file("res://scenes/menu.tscn")
