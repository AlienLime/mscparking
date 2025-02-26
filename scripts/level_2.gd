extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var helper: Label = $GUI/ingameGUIButtons/Background/Helper
@onready var textbox: Label = $GUI/Textbox/Background/Label
@onready var completed: Button = $GUI/ingameGUIButtons/Background/Completed
@onready var up: Button = $GUI/ingameGUIButtons/Background/Up
@onready var down: Button = $GUI/ingameGUIButtons/Background/Down


var carIndex = 0
var currentCar
var currentPos
var rightPark = 0
var leftPark = 0
var done = 0
var spawnUp
var spawnDown

const nrCars = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnUp = parking.get_node("SpawnUp").position
	spawnDown = parking.get_node("SpawnDown").position
	spawnCar()
	up.disabled = true
	down.disabled = true
	completed.disabled = true
	textbox.text = "Hvis bilen er rød
Så skal den krydse vejen.
Blå biler skal blive på samme side"
	helper.text = "Tryk på pilene for at vise bilerne hen til de korrekte pladser."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if done > nrCars-1:
		helper.text = "Godt gået!"
		helper.modulate = "00ffff"
		completed.disabled = false


func _on_right_pressed() -> void:
	if (currentCar.color >= 7 && currentPos == 0) || (currentCar.color <= 6 && currentPos == 1):
		rigtigt(1)
	else:
		forkert()

func _on_left_pressed() -> void:
	if (currentCar.color >= 7 && currentPos == 1) || (currentCar.color <= 6 && currentPos == 0):
		rigtigt(0)
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
		currentCar.parkingSpot = parking.get_node("Right").get_child(rightPark)
	else:
		currentCar.parkingSpot = parking.get_node("Left").get_child(leftPark)
	if carIndex < nrCars-1:
		carIndex += 1
		if x == 0:
			rightPark += 1
		else:
			leftPark += 1
		spawnCar()

func forkert() -> void:
	helper.text = "FORKERT"
	helper.modulate = "da2031"

func _on_completed_pressed() -> void:
	pass # Replace with function body.

func spawnCar() -> void:
	currentCar = newCar.instantiate()
	add_child(currentCar)
	if randi_range(0, 1) == 1:
		currentCar.position = spawnUp
		currentPos = 0
		currentCar.parkingSpot = parking.get_node("StartUp")
	else:
		currentCar.position = spawnDown
		currentPos = 1
		currentCar.parkingSpot = parking.get_node("StartDown")
