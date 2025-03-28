extends Control
@onready var label: Label = $Label


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = owner.textbox

func _on_button_pressed() -> void:
	if owner.tips.size()==0:
		return
	owner.textbox = owner.tips[owner.tipCounter%owner.tips.size()]
	owner.tipCounter += 1
	print("%-30s %s" % ["Tip pressed: ", owner.owner.stopwatch.time_to_string()])
