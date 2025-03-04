extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var textbox: Label = $GUI/IngameGUIButtons/Label
@onready var completed: Button = $GUI/IngameGUIButtons/TopCornerBox/MarginContainer/VBoxContainer/Hbox/Completed
@onready var up: Button = $GUI/IngameGUIButtons/ButtonBox/MarginContainer/HBoxContainer/VBoxContainer/Up
@onready var down: Button = $GUI/IngameGUIButtons/ButtonBox/MarginContainer/HBoxContainer/VBoxContainer/Down
@onready var helper: Label = $GUI/IngameGUIButtons/ButtonBox/MarginContainer/HBoxContainer/Helper
@onready var level: Label = $GUI/IngameGUIButtons/TopCornerBox/MarginContainer/VBoxContainer/level



var carIndex = 0
var currentCar
var currentPos
var rightPark = 0
var leftPark = 0
var done = 0
var spawnUp
var spawnDown
var score = 0

const nextScene = "res://scenes/level_3.tscn"
const nrCars = 5
const leftCond = ["1_3_0", "0_0_0"]
const rightCond = ["0_3_0", "1_0_0"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnUp = parking.get_node("SpawnUp").position
	spawnDown = parking.get_node("SpawnDown").position
	spawnCar()
	up.disabled = true
	down.disabled = true
	completed.disabled = true
	textbox.text = "På den her parkeringsplads gælder andre regler.
					De røde biler skal køre over på den anden side for at parkere, men blå biler skal blive på den samme side.
					Se om du kan regne den ud, ellers kan du trykke på genstart knappe for at prøve igen"
	helper.text = "Tryk på pilene for at vise bilerne hen til de korrekte pladser."
	level.text = "Bane 2"
	
	for parking_spot in parking.get_node("Right").get_children():
		parking_spot.conditions = rightCond
	for parking_spot in parking.get_node("Left").get_children():
		parking_spot.conditions = leftCond


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if done == nrCars:
		if score == nrCars:
			helper.text = "Godt gået!"
			helper.modulate = "00ffff"
			completed.disabled = false
		else:
			helper.text = "Hovsa. Der er nogle biler der parkerede forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."


func _on_right_pressed() -> void:
	moveCar(0)

func _on_left_pressed() -> void:
	moveCar(1)

#Helper functions
func moveCar(x: int) -> void:
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

func spawnCar() -> void:
	currentCar = newCar.instantiate()
	add_child(currentCar)
	if randi_range(0, 1) == 1:
		currentCar.position = spawnUp
		currentCar.origin = 0
		currentCar.parkingSpot = parking.get_node("StartUp")
	else:
		currentCar.position = spawnDown
		currentCar.origin = 3
		currentCar.parkingSpot = parking.get_node("StartDown")
