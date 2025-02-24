extends Node2D
@onready var cars: Node = $Cars
@onready var parking: Node = $Parking
@onready var helper: Label = $Labels/Helper

var carIndex = 0
var currentCar
var nextCar
var park = 0
var done = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentCar = cars.get_child(carIndex) 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if done > 4:
		helper.text = "Godt gået!"
		helper.modulate = "e8b705"





func _on_up_button_pressed() -> void:
	if currentCar.color >= 7:
		rigtigt(0)
	else:
		forkert()

func _on_down_button_pressed() -> void:
	if currentCar.color <= 6:
		rigtigt(1)
	else:
		forkert()

func rigtigt(x: int) -> void:
	helper.text = "Rigtigt"
	helper.modulate = "07d434"
	done += 1
	currentCar.parkingSpot = parking.get_child(x).get_child(park)
	if carIndex < 4:
		carIndex += 1
		park += 1
		currentCar = cars.get_child(carIndex)
		currentCar.parkingSpot = parking.get_child(2)

func forkert() -> void:
	helper.text = "FORKERT"
	helper.modulate = "da2031"


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
