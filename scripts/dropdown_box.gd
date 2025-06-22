extends MarginContainer
@onready var dropdown_box: MarginContainer = $"."

@onready var run: Button = $MarginContainer/HBoxContainer/Run

const IF_COLOR = preload("res://scenes/if_color.tscn")
const IF_COLOR_THEN = preload("res://scenes/if_color_then.tscn")
const ELSE_THEN = preload("res://scenes/else_then.tscn")


@onready var if_container: VBoxContainer = $MarginContainer/HBoxContainer/VBoxContainer/IfContainer
@onready var else_container: VBoxContainer = $MarginContainer/HBoxContainer/VBoxContainer/ElseContainer
@onready var else_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/ElseContainer/ElseLabel

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
		else_label.visible = owner.owner.elseVisible
		else_label.text = owner.owner.elseLabel
		if owner.owner.elseThenVisible:
			create_else_then()
		setupBool = false
	run.disabled = owner.owner.disableRun

# creates an "if"-statement in the drop-down box
func create_if_color() -> void:
	var ifColor = IF_COLOR.instantiate()
	ifColor.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	ifColor.ifIndex = owner.owner.optionSelected.size()
	owner.owner.optionSelected.push_back(-1)
	
	if_container.add_child(ifColor)
	ifColor.set_owner(dropdown_box)

# creates an "if-then"-statement in the drop-down box
func create_if_color_then() -> void:
	var ifColorThen = IF_COLOR_THEN.instantiate()
	ifColorThen.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	ifColorThen.ifIndex = owner.owner.optionSelected.size()
	owner.owner.optionSelected.push_back(-1)
	
	ifColorThen.thenIndex = owner.owner.optionSelected.size()
	owner.owner.optionSelected.push_back(-1)
	
	if_container.add_child(ifColorThen)
	ifColorThen.set_owner(dropdown_box)

# creates an "else-then"-statement in the drop-down box
func create_else_then() -> void:
	var elseThen = ELSE_THEN.instantiate()
	elseThen.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	elseThen.thenIndex = owner.owner.optionSelected.size()
	owner.owner.optionSelected.push_back(-1)
	
	else_container.add_child(elseThen)
	elseThen.set_owner(dropdown_box)

func _on_run_pressed() -> void:
	print(Globals.USERID + "," + owner.owner.stopwatch.time_to_string() + ",Button press,Run")
	owner.owner.runCounter += 1
	owner.owner._on_run_pressed()
	
