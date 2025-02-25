extends Node2D
@onready var cars: Node = $Cars
@onready var parking: Node = $Parking
@onready var helper: Label = $GUI/ingameGUIButtons/Helper
@onready var textbox: Label = $GUI/Textbox/Label

var nrCars
var carIndex = 0
var currentCar
var nextCar
var leftPark = 0
var rightPark = 0
var done = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	nrCars = cars.get_child_count()
	currentCar = cars.get_child(carIndex) 
	textbox.text = "Hvis bilen er rød
Så skal den krydse vejen
Ellers skal den blive på samme side"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if done > nrCars-1:
		helper.text = "Godt gået!"
		helper.modulate = "00ffff"





func _on_up_pressed() -> void:
	if currentCar.color >= 7:
		rigtigt(0)
	else:
		forkert()

func _on_down_pressed() -> void:
	if currentCar.color <= 6:
		rigtigt(1)
	else:
		forkert()

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

#Helper functions
func rigtigt(x: int) -> void:
	helper.text = "Rigtigt"
	helper.modulate = "07d434"
	done += 1
	if x == 0:
		currentCar.parkingSpot = parking.get_child(x).get_child(Park)
	else:
		currentCar.parkingSpot = parking.get_child(x).get_child(downPark)
	if carIndex < nrCars-1:
		carIndex += 1
		if x == 0:
			upPark += 1
		else:
			downPark += 1
		currentCar = cars.get_child(carIndex)
		currentCar.parkingSpot = parking.get_child(2)

func forkert() -> void:
	helper.text = "FORKERT"
	helper.modulate = "da2031"
