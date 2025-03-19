extends MarginContainer
@onready var level: Label = $MarginContainer/VBoxContainer/level
@onready var completed: Button = $MarginContainer/VBoxContainer/Hbox/Completed
@onready var undo: Button = $MarginContainer/VBoxContainer/Hbox/Undo

var levelBool = true

func _process(delta: float) -> void:
	if levelBool:
		level.text = "bane " + str(owner.owner.level)
		levelBool = false
	completed.disabled = owner.owner.disableCompleted
	undo.disabled = owner.owner.disableUndo

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_completed_pressed() -> void:
	get_tree().change_scene_to_file(owner.owner.nextScene)

func _on_undo_pressed() -> void:
	owner.owner.undo()
