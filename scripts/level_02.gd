extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var pop_up_complete: Control = $GUI/IngameGUIButtons/PopUpComplete

var navigationMesh: NavigationMesh


var currentCar
var carStack = []
var carIncrementer = 0
var parked = 0
var score = 0
var spawnUp
var spawnDown
var disableUp = true
var disableLeft = false
var disableRight = false
var disableDown = true
var disableCompleted = true
var disableUndo = true
var helper = ""
var textbox = "Der er mange forskellige parkeringspladser, med forskellige regler. 
				Vi starter med et par pladser hvor der kun kommer røde og blå biler.
				
				(Tryk for at fortsætte)"
var level = 2

const nextScene = "res://scenes/level_3.tscn"
const nrCars = 5
const leftCond = ["1_0_0", "0_0_0"]
const rightCond = ["1_3_0", "0_3_0"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnUp = parking.get_node("SpawnUp").position
	spawnDown = parking.get_node("SpawnDown").position
	spawnCar()
	
	pop_up_complete.visible = false
	textbox = "På den her parkeringsplads har chefen lavet andre regler:
					Ingen biler må krydse vejen.
					
					Prøv dig frem. Hvis du laver fejl kan du bare trykke på genstart knappen for at prøve igen"
	helper = "Tryk på pilene for at vise bilerne hen til de korrekte pladser."
	
	for parking_spot in parking.get_node("Right").get_children():
		parking_spot.conditions = rightCond
	for parking_spot in parking.get_node("Left").get_children():
		parking_spot.conditions = leftCond


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if carStack.is_empty():
		disableUndo = true
	else:
		disableUndo = false
	if parked == nrCars:
		if score == nrCars:
			pop_up_complete.visible = true
			disableCompleted = false
			disableUndo = true
			helper = ""
		else:
			helper = "Hovsa. Der er nogle biler der parkerede forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."


func _on_right_pressed() -> void:
	moveCar(0)

func _on_left_pressed() -> void:
	moveCar(1)

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
		spawnCar()

func spawnCar() -> void:
	await wait(0.75)
	if carIncrementer < nrCars:
		carIncrementer += 1
		currentCar = newCar.instantiate()
		add_child(currentCar)
		carStack.push_back(currentCar)
		if randi_range(0, 1) == 1:
			currentCar.position = spawnUp
			currentCar.origin = 0
			currentCar.navigationTarget = parking.get_node("StartUp")
		else:
			currentCar.position = spawnDown
			currentCar.origin = 3
			currentCar.navigationTarget = parking.get_node("StartDown")

func undo() -> void:
	if parked < nrCars:
		currentCar = carStack.pop_back()
		if currentCar.isParked:
			parked -= 1
		if currentCar.isParkedCorrectly:
			score -= 1
		if currentCar.parkingSpot != null:
			currentCar.parkingSpot.isFree = true
		carIncrementer -= 1
		currentCar.queue_free()
	
	currentCar = carStack.pop_back()
	if currentCar.isParked:
		parked -= 1
	if currentCar.isParkedCorrectly:
		score -= 1
	if currentCar.parkingSpot != null:
		currentCar.parkingSpot.isFree = true
	carIncrementer -= 1
	currentCar.queue_free()
	
	spawnCar()

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
