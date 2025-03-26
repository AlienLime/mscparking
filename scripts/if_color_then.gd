extends Control

@onready var ifLabel: Label = $VBoxContainer/HBoxContainer/If
@onready var if_button: OptionButton = $VBoxContainer/HBoxContainer/OptionButton
@onready var thenLabel: Label = $VBoxContainer/MarginContainer/Then
@onready var then_button: OptionButton = $VBoxContainer/MarginContainer/HBoxContainer/OptionButton

var setupBool = true

func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if setupBool:
		var temp = -1
		for item in if_button.item_count:
			temp = if_button.get_item_index(item)
			if !owner.owner.owner.usedColors.has(if_button.get_item_id(temp)):
				if_button.remove_item(temp)
		ifLabel.text = owner.owner.owner.ifLabel[get_index()]
		thenLabel.text = owner.owner.owner.thenLabel[get_index()]
		setupBool = false
	if_button.disabled = !owner.owner.owner.canRun


func _on_option_button_item_selected(index: int) -> void:
	owner.owner.owner.colorSelected[get_index()] = if_button.get_item_id(index)
