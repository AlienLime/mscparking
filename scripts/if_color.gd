extends Control

@onready var ifLabel: Label = $VBoxContainer/HBoxContainer/If
@onready var option_button: OptionButton = $VBoxContainer/HBoxContainer/OptionButton
@onready var thenLabel: Label = $VBoxContainer/MarginContainer/Then

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp = -1
	for item in option_button.item_count:
		temp = option_button.get_item_index(item)
		if !owner.owner.owner.carColors.has(option_button.get_item_text(temp)):
			option_button.remove_item(temp)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ifLabel.text = owner.owner.owner.ifLabel
	thenLabel.text = owner.owner.owner.thenLabel
	option_button.disabled = !owner.owner.owner.canRun


func _on_option_button_item_selected(index: int) -> void:
	owner.owner.owner.colorSelected = index
