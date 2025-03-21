extends MarginContainer

@onready var run: Button = $MarginContainer/HBoxContainer/Run
@onready var if_color_0: Control = $MarginContainer/HBoxContainer/VBoxContainer/IfColor0
@onready var if_color_1: Control = $MarginContainer/HBoxContainer/VBoxContainer/IfColor1
@onready var if_color_2: Control = $MarginContainer/HBoxContainer/VBoxContainer/IfColor2
var setupBool = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if setupBool:
		if_color_0.visible = owner.owner.colorIf[0]
		if_color_1.visible = owner.owner.colorIf[1]
		if_color_2.visible = owner.owner.colorIf[2]
		setupBool = false
	run.disabled = owner.owner.disableRun
	

func _on_run_pressed() -> void:
	owner.owner._on_run_pressed()
