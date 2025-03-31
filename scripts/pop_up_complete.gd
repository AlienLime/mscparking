extends Control

@onready var pop_up_complete: Control = $"."
@onready var label: Label = $HBoxContainer/Label


func win() -> void:
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
	label.modulate = "e90000"
	label.text = "Hovsa. " + reason + "\nPrøv igen ved at trykke på genstart i toppen af skærmen."
	pop_up_complete.visible = true
	
	print("%-30s %s" % ["Level incorrect at: ", owner.stopwatch.time_to_string()])
