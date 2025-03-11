extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking



var carIndex = 0
var currentCar
var upPark = 0
var downPark = 0
var done = 0
var spawn
const upCond = ["1_0_0"]
const downCond = ["0_0_0"]
var score = 0
var disableUp = false
var disableLeft = true
var disableRight = true
var disableDown = false
var disableCompleted = true
var helper = "Tryk på pilene for at få bilerne til at køre hen til de rigtige parkeringspladser."
var textbox = "Her er den første plads. Her gælder de her regler:
					Hvis bilen er rød
					Så skal den parkere øverst
					Ellers hvis bilen er blå 
					Så skal den parkere nederst"
var level = 1

const nextScene = "res://scenes/level_02.tscn"
const nrCars = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn = parking.get_node("Spawn").position
	spawnCar()
	
	for parking_spot in parking.get_node("Up").get_children():
		parking_spot.conditions = upCond
	for parking_spot in parking.get_node("Down").get_children():
		parking_spot.conditions = downCond


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if score == nrCars:
		helper = "Godt gået!"
		disableCompleted = false


func _on_up_pressed() -> void:
	if currentCar.color == 1:
		rigtigt(0)
	else:
		forkert()

func _on_down_pressed() -> void:
	if currentCar.color == 0:
		rigtigt(1)
	else:
		forkert()

#Helper functions
func rigtigt(x: int) -> void:
	helper = "Rigtigt"
	done += 1
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
