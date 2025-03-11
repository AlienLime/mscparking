extends MarginContainer
@onready var up: Button = $MarginContainer/HBoxContainer/VBoxContainer/Up
@onready var left: Button = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Left
@onready var right: Button = $MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Right
@onready var down: Button = $MarginContainer/HBoxContainer/VBoxContainer/Down
@onready var helper: Label = $MarginContainer/HBoxContainer/Helper


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	up.disabled = owner.owner.disableUp
	left.disabled = owner.owner.disableLeft
	right.disabled = owner.owner.disableRight
	down.disabled = owner.owner.disableDown

func _process(delta: float) -> void:
	helper.text = owner.owner.helper


func _on_up_pressed() -> void:
	owner.owner._on_up_pressed()


func _on_left_pressed() -> void:
	owner.owner._on_left_pressed()


func _on_right_pressed() -> void:
	owner.owner._on_right_pressed()


func _on_down_pressed() -> void:
	owner.owner._on_down_pressed()
