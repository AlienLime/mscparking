extends Control

@onready var ifLabel: Label = $VBoxContainer/HBoxContainer/If
@onready var if_button: OptionButton = $VBoxContainer/HBoxContainer/ifButton
@onready var thenLabel: Label = $VBoxContainer/MarginContainer/HBoxContainer/Then
@onready var then_button: OptionButton = $VBoxContainer/MarginContainer/HBoxContainer/thenButton

var ifIndex: int
var thenIndex: int
var setupBool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if setupBool:
		var temp: int
		for item in if_button.item_count:
			temp = if_button.get_item_index(item)
			if !owner.owner.owner.usedColors.has(if_button.get_item_id(temp)):
				if_button.remove_item(temp)
				
		for item in then_button.item_count:
			temp = then_button.get_item_index(item)
			if !owner.owner.owner.usedDirections.has(then_button.get_item_id(temp)):
				then_button.remove_item(temp)
				
		ifLabel.text = owner.owner.owner.ifLabel[get_index()]
		thenLabel.text = owner.owner.owner.thenLabel[get_index()]
		setupBool = false
	if_button.disabled = !owner.owner.owner.canRun
	then_button.disabled = !owner.owner.owner.canRun

func _on_if_button_item_selected(index: int) -> void:
	var id = if_button.get_item_id(index)
	owner.owner.owner.optionSelected[ifIndex] = id
	print(Globals.USERID + "," + owner.owner.owner.stopwatch.time_to_string() + ",Color dropdown," + str(id))

func _on_then_button_item_selected(index: int) -> void:
	var id = then_button.get_item_id(index)
	owner.owner.owner.optionSelected[thenIndex] = id
	print(Globals.USERID + "," + owner.owner.owner.stopwatch.time_to_string() + ",Direction dropdown," + str(id))
