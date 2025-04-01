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
					Tryk på fluebenet øverst til højre for at komme videre 
					til næste bane"
	pop_up_complete.visible = true
	
	print("%-30s %s" % ["Level completed at: ", owner.stopwatch.time_to_string()])
	print("%-30s %3s" % ["Tips received: ", str(owner.tipCounter)])
	if owner.runCounter > 0:
		print("%-30s %3s" % ["Times run: ", str(owner.runCounter)])
	if owner.undoCounter > 0:
		print("%-30s %3s" % ["Times undone: ", str(owner.undoCounter)])
	print("%-30s %3s" % ["Times restarted: ", str(owner.restartCounter)])

func lose(reason: String) -> void:
	restart.visible = true
	completed.visible = false
	label.modulate = "e90000"
	label.text = "Hovsa. " + reason + "\nPrøv igen ved at trykke på genstart i toppen af skærmen."
	pop_up_complete.visible = true
	
	print("%-30s %s" % ["Level incorrect at: ", owner.stopwatch.time_to_string()])


func _on_completed_pressed() -> void:
	print("%-30s %s" % ["Next level button pressed: ", owner.stopwatch.time_to_string() + "\n"])
	get_tree().change_scene_to_file(owner.get_next_level())


func _on_restart_pressed() -> void:
	print("%-30s %s" % ["Restart pressed: ", owner.stopwatch.time_to_string()])
	owner.restartCounter += 1
	owner.restart()
