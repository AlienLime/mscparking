extends MarginContainer

@onready var helper: Label = $MarginContainer/HBoxContainer/VBoxContainer/Helper
@onready var run: Button = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Run

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	helper.text = owner.owner.helper
	run.disabled = owner.owner.disableRun
	

func _on_run_pressed() -> void:
	owner.owner._on_run_pressed()
