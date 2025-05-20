extends Control

@onready var pop_up_complete: Control = $"."
@onready var label: Label = $HBoxContainer/VBoxContainer/Label
@onready var completed: Button = $HBoxContainer/VBoxContainer/Completed
@onready var restart: Button = $HBoxContainer/VBoxContainer/Restart


func win() -> void:
	restart.visible = false
	completed.visible = true
	label.modulate = "26bc3b"
	label.text = "Godt gået!!! Du har løst banen!
					Tryk på fluebenet for at komme videre til næste bane"
	pop_up_complete.visible = true
	
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Victory,Level complete")
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Sum of tips," + str(owner.tipCounter))
	if owner.runCounter > 0:
		print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Sum of runs," + str(owner.runCounter))
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Sum of undos," + str(owner.undoCounter))
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Sum of restarts," + str(owner.restartCounter))

func lose(reason: String) -> void:
	restart.visible = true
	completed.visible = false
	label.modulate = "e90000"
	label.text = "Hovsa. " + reason + "\nPrøv igen ved at trykke på genstart."
	pop_up_complete.visible = true
	
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Loss," + reason)
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Sum of tips," + str(owner.tipCounter))
	if owner.runCounter > 0:
		print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Sum of runs," + str(owner.runCounter))
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Sum of undos," + str(owner.undoCounter))
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Sum of restarts," + str(owner.restartCounter))


func _on_completed_pressed() -> void:
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Button press,Next level")
	get_tree().change_scene_to_file.call_deferred(owner.get_next_level())
	owner.stopwatch.queue_free()


func _on_restart_pressed() -> void:
	print(Globals.USERID + "," + owner.stopwatch.time_to_string() + ",Button press,Restart")
	owner.restart()
