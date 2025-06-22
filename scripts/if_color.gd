extends Control

@onready var ifLabel: Label = $VBoxContainer/HBoxContainer/If
@onready var option_button: OptionButton = $VBoxContainer/HBoxContainer/OptionButton
@onready var thenLabel: Label = $VBoxContainer/MarginContainer/Then

var ifIndex: int
var setupBool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if setupBool:
		var temp = -1
		for item in option_button.item_count:
			temp = option_button.get_item_index(item)
			if !owner.owner.owner.usedColors.has(option_button.get_item_id(temp)):
				option_button.remove_item(temp)
		ifLabel.text = owner.owner.owner.ifLabel[get_index()]
		thenLabel.text = owner.owner.owner.thenLabel[get_index()]
		setupBool = false
	option_button.disabled = !owner.owner.owner.canRun

func _on_option_button_item_selected(index: int) -> void:
	var id = option_button.get_item_id(index)
	owner.owner.owner.optionSelected[ifIndex] = id
	print(Globals.USERID + "," + owner.owner.owner.stopwatch.time_to_string() + ",Color dropdown," + str(id))
