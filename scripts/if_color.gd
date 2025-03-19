extends Control

@onready var ifLabel: Label = $VBoxContainer/HBoxContainer/If
@onready var option_button: OptionButton = $VBoxContainer/HBoxContainer/OptionButton
@onready var thenLabel: Label = $VBoxContainer/MarginContainer/Then

var optionsBool = true

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if optionsBool:
		var temp = -1
		for item in option_button.item_count:
			temp = option_button.get_item_index(item)
			if !owner.owner.owner.usedColors.has(option_button.get_item_id(temp)):
				option_button.remove_item(temp)
		optionsBool = false
	ifLabel.text = owner.owner.owner.ifLabel
	thenLabel.text = owner.owner.owner.thenLabel
	option_button.disabled = !owner.owner.owner.canRun


func _on_option_button_item_selected(index: int) -> void:
	owner.owner.owner.colorSelected = index
