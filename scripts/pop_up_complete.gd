extends Control


func _on_label_visibility_changed() -> void:
	print("\n%-30s %s" % ["Level completed at: ", owner.stopwatch.time_to_string()])
	print("%-30s %3s" % ["Tips received: ", str(owner.tipCounter)])
	if owner.runCounter > 0:
		print("%-30s %3s" % ["Times run: ", str(owner.runCounter)])
	if owner.undoCounter > 0:
		print("%-30s %3s" % ["Times undone: ", str(owner.undoCounter)])
	print("%-30s %3s" % ["Times restarted: ", str(owner.restartCounter)])
