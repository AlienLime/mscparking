extends MarginContainer
@onready var level: Label = $MarginContainer/VBoxContainer/level
@onready var completed: Button = $MarginContainer/VBoxContainer/Hbox/Completed
@onready var undo: Button = $MarginContainer/VBoxContainer/Hbox/Undo

var levelBool = true

func _ready() -> void:
	undo.visible = owner.owner.undoVisible

func _process(delta: float) -> void:
	if levelBool:
		level.text = str(owner.owner.name)
		levelBool = false
	completed.disabled = owner.owner.disableCompleted
	if undo.visible:
		undo.disabled = (owner.owner.carStack.size() < 2) || (owner.owner.nrCars == owner.owner.score)
	

func _on_restart_pressed() -> void:
	print(Globals.USERID + "," + owner.owner.stopwatch.time_to_string() + ",Button press,Restart")
	owner.owner.restart()

func _on_home_pressed() -> void:
	print(Globals.USERID + "," + owner.owner.stopwatch.time_to_string() + ",Button press,Home")
	get_tree().change_scene_to_file.call_deferred("res://scenes/menu.tscn")
	owner.owner.stopwatch.queue_free()

func _on_completed_pressed() -> void:
	print(Globals.USERID + "," + owner.owner.stopwatch.time_to_string() + ",Button press,Next Level")
	get_tree().change_scene_to_file.call_deferred(owner.owner.get_next_level())
	owner.owner.stopwatch.queue_free()

func _on_undo_pressed() -> void:
	print(Globals.USERID + "," + owner.owner.stopwatch.time_to_string() + ",Button press,Undo")
	owner.owner.undo()
