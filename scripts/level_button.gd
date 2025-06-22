extends Button

var level_path
var original_size := scale
var grow_size := Vector2(1.1, 1.1)

# grows the button when it is hovered with the mouse
func grow_button(end_size: Vector2, duration: float) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, 'scale', end_size, duration)

func _on_mouse_entered() -> void:
	grow_button(grow_size, .1)

func _on_mouse_exited() -> void:
	grow_button(original_size, .1)

func _on_pressed() -> void:
	if level_path == null:
		return
	get_tree().change_scene_to_file.call_deferred(level_path)
