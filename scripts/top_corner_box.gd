extends MarginContainer
@onready var level: Label = $MarginContainer/VBoxContainer/level
@onready var completed: Button = $MarginContainer/VBoxContainer/Hbox/Completed

func _ready() -> void:
	level.text = "bane " + str(owner.owner.level)

func _process(delta: float) -> void:
	completed.disabled = owner.owner.disableCompleted

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_completed_pressed() -> void:
	get_tree().change_scene_to_file(owner.owner.nextScene)
