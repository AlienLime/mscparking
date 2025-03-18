extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var pop_up_complete: Control = $GUI/IngameGUIDropdown/PopUpComplete
@onready var intro: Control = $GUI/IngameGUIDropdown/Intro

var carIncrementer = 0
var currentCar
var currentPos
var rightPark = 0
var leftPark = 0
var parked = 0
var spawnUp
var spawnDown
var score = 0
var clicks = 0
var canRun = true
#0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
const carColors = [0, 1]
const carOrigins = [0, 3]
var level = 3
var ifLabel = "Hvis bilen er "
var colorSelected = -1
var thenLabel = "så skal den parkere til højre."
var helper = "Design en instruktion som bilerne kan følge ved at vælge en af mulighederne herunder."
var textbox = "Nu er højre side reserveret til de røde biler."
var introLabel = "Du har jo super godt styr på parkering!\n
				Men man bliver træt, hvis man skal hjælpe hver eneste lille bil på vej. Vi må have dig til at lave systemer, som bilerne kan følge, når de skal finde en parkeringsplads.\n
				I den her bane skal du designe en instruktion til bilerne før de overhovedet er kommet.\n
				Held og lykke!"
var disableCompleted = true
var disableUndo = true

const nextScene = "res://scenes/victory_screen.tscn"
const nrCars = 5
const leftCond = ["0_3_0", "0_0_0"]
const rightCond = ["1_3_0", "1_0_0"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canRun = true
	spawnUp = parking.get_node("SpawnUp").position
	spawnDown = parking.get_node("SpawnDown").position
	intro.visible = true
	pop_up_complete.visible = false

	for parking_spot in parking.get_node("Right").get_children():
		parking_spot.conditions = rightCond
	for parking_spot in parking.get_node("Left").get_children():
		parking_spot.conditions = leftCond


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			intro.visible = false
			intro.z_index = -1
	if parked == nrCars:
		if score == nrCars:
			pop_up_complete.visible = true
			disableCompleted = false
		else:
			helper = "Hovsa. Der er nogle biler der parkerede forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."


#Helper functions
func moveCar(x: int) -> void:
	if currentCar:
		if x == 0:
			for spot in parking.get_node("Right").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					break
		else:
			for spot in parking.get_node("Left").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					break
		currentCar = null

func spawnCar() -> void:
	if carIncrementer < nrCars:
		carIncrementer += 1
		var origin = carOrigins.pick_random()
		currentCar = newCar.instantiate()
		currentCar.withData(carColors,origin)
		if origin == 0:
			currentCar.position = spawnUp
			currentCar.navigationTarget = parking.get_node("StartUp")
		else:
			currentCar.position = spawnDown
			currentCar.navigationTarget = parking.get_node("StartDown")
		add_child(currentCar)

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_run_pressed() -> void:
	if colorSelected != -1 && canRun:
		canRun = false
		for car in nrCars:
			spawnCar()
			await wait(1)
			if currentCar.color == colorSelected:
				moveCar(0)
			else:
				moveCar(1)
