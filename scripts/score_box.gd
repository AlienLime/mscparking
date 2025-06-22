extends Control
@onready var label: Label = $MarginContainer/Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Biler: " + str(owner.owner.parked) + "/" + str(owner.owner.nrCars)
	
