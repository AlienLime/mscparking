extends MarginContainer

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_completed_pressed() -> void:
	get_tree().change_scene_to_file(owner.owner.nextScene)
