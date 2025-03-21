extends Control
@onready var label: Label = $Label
var tipCounter = -1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = owner.textbox

func _on_button_pressed() -> void:
	if owner.tips.size()==0:
		return
	tipCounter += 1
	if tipCounter == owner.tips.size():
		tipCounter = 0
	owner.textbox = owner.tips[tipCounter]
