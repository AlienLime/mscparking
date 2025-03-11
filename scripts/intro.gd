extends Node2D
@onready var introLabel: Label = $introLabel

# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	introLabel.text = owner.introLabel
