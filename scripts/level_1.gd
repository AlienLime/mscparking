extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var pop_up_complete: Control = $GUI/IngameGUIButtons/PopUpComplete
@onready var intro: Control = $GUI/IngameGUIButtons/Intro


var clicks = 0
var carIncrementer = 0
var carStack = []
var currentCar
var upPark = 0
var downPark = 0
var parked = 0
var spawn
const upCond = ["1_0_0"]
const downCond = ["0_0_0"]
var score = 0
var disableUp = true
var disableLeft = true
var disableRight = true
var disableDown = true
var disableCompleted = true
var disableUndo = true
var helper = ""
var textbox = "Der er mange forskellige parkeringspladser med forskellige regler. 
				Vi starter med et par pladser, hvor der kun kommer røde og blå biler.
				
				(Tryk for at fortsætte)"
var introLabel = "Hej med dig. Velkommen til parkeringspladsen! Jeg hedder Hjælpe Jens, men du kan bare kalde mig for Jens.
			
			Din opgave er at vise bilerne hen til de rette pladser."
var level = 1

const nextScene = "res://scenes/level_02.tscn"
const nrCars = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pop_up_complete.visible = false
	intro.visible = true
	
	spawn = parking.get_node("Spawn").position
	spawnCar()
	
	for parking_spot in parking.get_node("Up").get_children():
		parking_spot.conditions = upCond
	for parking_spot in parking.get_node("Down").get_children():
		parking_spot.conditions = downCond


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			intro.queue_free()
		if clicks == 2:
			textbox = "På den første plads er chefens instruktion:
						Hvis bilen er rød,
						  så skal den parkere øverst.
						Hvis bilen er blå, 
						  så skal den parkere nederst."
			disableUp = false
			disableDown = false
			helper = "Tryk på pilene for at få bilerne til at køre hen til de rigtige parkeringspladser."
	
	if carStack.is_empty():
		disableUndo = true
	else:
		disableUndo = false
	
	if score == nrCars:
		pop_up_complete.visible = true
		disableCompleted = false
		disableUndo = true


func _on_up_pressed() -> void:
	if parked < nrCars:
		if currentCar && currentCar.color == 1:
			helper = "Rigtigt"
			moveCar(0)
		else:
			forkert()

func _on_down_pressed() -> void:
	if parked < nrCars:
		if currentCar && currentCar.color == 0:
			helper = "Rigtigt"
			moveCar(1)
		else:
			forkert()

#Helper functions
func forkert() -> void:
	helper = "FORKERT"
	
func moveCar(x: int) -> void:
	if currentCar:
		if x == 0:
			for spot in parking.get_node("Up").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					break
		else:
			for spot in parking.get_node("Down").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					break
		currentCar = null
		spawnCar()

func spawnCar() -> void:
	if carIncrementer < nrCars:
		carIncrementer += 1
		currentCar = newCar.instantiate()
		add_child(currentCar)
		carStack.push_back(currentCar)
		currentCar.position = spawn
		currentCar.navigationTarget = parking.get_node("Start")


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
