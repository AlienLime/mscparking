extends Control

@onready var else_then_label: Label = $HBoxContainer/ElseThenLabel
@onready var then_button: OptionButton = $HBoxContainer/ThenButton

var thenIndex: int
var setupBool = true

func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if setupBool:
		var temp = -1
		for item in then_button.item_count:
			temp = then_button.get_item_index(item)
			if !owner.owner.owner.usedDirections.has(then_button.get_item_id(temp)):
				then_button.remove_item(temp)
		else_then_label.text = owner.owner.owner.elseLabel
		setupBool = false
	then_button.disabled = !owner.owner.owner.canRun

func _on_then_button_item_selected(index: int) -> void:
	var id = then_button.get_item_id(index)
	owner.owner.owner.optionSelected[thenIndex] = id
	print(Globals.USERID + "," + owner.owner.owner.stopwatch.time_to_string() + ",Direction dropdown," + str(id))
