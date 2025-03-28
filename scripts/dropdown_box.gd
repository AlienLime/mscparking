extends MarginContainer
@onready var dropdown_box: MarginContainer = $"."

@onready var run: Button = $MarginContainer/HBoxContainer/Run

const IF_COLOR = preload("res://scenes/if_color.tscn")
const IF_COLOR_THEN = preload("res://scenes/if_color_then.tscn")

@onready var elseLabel: Label = $MarginContainer/HBoxContainer/VBoxContainer/ElseLabel

@onready var v_box_container: VBoxContainer = $MarginContainer/HBoxContainer/VBoxContainer/VBoxContainer

var setupBool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if setupBool:
		for x in owner.owner.ifArray:
			match x:
				"colorIf":
					create_if_color()
				"colorIfThen":
					create_if_color_then()
		elseLabel.visible = owner.owner.elseVisible
		elseLabel.text = owner.owner.elseLabel
		setupBool = false
	run.disabled = owner.owner.disableRun
	

func create_if_color() -> void:
	var ifColor = IF_COLOR.instantiate()
	ifColor.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	ifColor.ifIndex = owner.owner.optionSelected.size()
	owner.owner.optionSelected.push_back(-1)
	
	v_box_container.add_child(ifColor)
	ifColor.set_owner(dropdown_box)


func create_if_color_then() -> void:
	var ifColorThen = IF_COLOR_THEN.instantiate()
	ifColorThen.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	print(ifColorThen.ifIndex)
	print(owner.owner.optionSelected.size())
	ifColorThen.ifIndex = owner.owner.optionSelected.size()
	owner.owner.optionSelected.push_back(-1)
	
	print(ifColorThen.thenIndex)
	print(owner.owner.optionSelected.size())
	ifColorThen.thenIndex = owner.owner.optionSelected.size()
	owner.owner.optionSelected.push_back(-1)
	
	v_box_container.add_child(ifColorThen)
	ifColorThen.set_owner(dropdown_box)


func _on_run_pressed() -> void:
	print("%-30s %s" % ["Run pressed: ", owner.owner.stopwatch.time_to_string()])
	owner.owner.runCounter += 1
	owner.owner._on_run_pressed()
