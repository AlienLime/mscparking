extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var pop_up_complete: Control = $GUI/IngameGUIButtons/PopUpComplete
@onready var intro: Node2D = $Intro


var clicks = 0
var carIndex = 0
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
var helper = ""
var textbox = "Der er mange forskellige parkeringspladser med forskellige regler. 
				Vi starter med et par pladser, hvor der kun kommer røde og blå biler.
				
				(Tryk for at fortsætte)"
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
			intro.visible = false
		if clicks == 2:
			textbox = "På den første plads er chefens instruktion:
						Hvis bilen er rød,
						  så skal den parkere øverst.
						Hvis bilen er blå, 
						  så skal den parkere nederst."
			disableUp = false
			disableDown = false
			helper = "Tryk på pilene for at få bilerne til at køre hen til de rigtige parkeringspladser."
	
	if score == nrCars:
		pop_up_complete.visible = true
		disableCompleted = false


func _on_up_pressed() -> void:
	if parked < nrCars:
		if currentCar.color == 1:
			rigtigt(0)
		else:
			forkert()

func _on_down_pressed() -> void:
	if parked < nrCars:
		if currentCar.color == 0:
			rigtigt(1)
		else:
			forkert()

#Helper functions
func rigtigt(x: int) -> void:
	helper = "Rigtigt"
	if x == 0:
		currentCar.parkingSpot = parking.get_node("Up").get_child(upPark)
	else:
		currentCar.parkingSpot = parking.get_node("Down").get_child(downPark)
	if carIndex < nrCars-1:
		carIndex += 1
		if x == 0:
			upPark += 1
		else:
			downPark += 1
		spawnCar()

func forkert() -> void:
	helper = "FORKERT"

func spawnCar() -> void:
	currentCar = newCar.instantiate()
	add_child(currentCar)
	currentCar.position = spawn
	currentCar.parkingSpot = parking.get_node("Start")
