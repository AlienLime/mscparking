extends Control

@onready var ifLabel: Label = $HBoxContainer/If
@onready var thenLabel: Label = $HBoxContainer/Then
@onready var option_button: OptionButton = $HBoxContainer/OptionButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ifLabel.text = owner.owner.owner.ifLabel
	thenLabel.text = owner.owner.owner.thenLabel
	for item in option_button.item_count:
		if !owner.owner.owner.carColors.contains(option_button.get_item_text(item)):
			option_button.remove_item(item)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
