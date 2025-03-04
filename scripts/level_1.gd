extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var helper: Label = $GUI/IngameGUIButtons/ButtonBox/MarginContainer/HBoxContainer/Helper
@onready var textbox: Label = $GUI/IngameGUIButtons/Label
@onready var completed: Button = $GUI/IngameGUIButtons/TopCornerBox/MarginContainer/VBoxContainer/Hbox/Completed
@onready var left: Button = $GUI/IngameGUIButtons/ButtonBox/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Left
@onready var right: Button = $GUI/IngameGUIButtons/ButtonBox/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Right
@onready var level: Label = $GUI/IngameGUIButtons/TopCornerBox/MarginContainer/VBoxContainer/level



var carIndex = 0
var currentCar
var upPark = 0
var downPark = 0
var done = 0
var spawn
const upCond = ["1_0_0"]
const downCond = ["0_0_0"]
var score = 0

const nextScene = "res://scenes/level_02.tscn"
const nrCars = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn = parking.get_node("Spawn").position
	spawnCar()
	left.disabled = true
	right.disabled = true
	completed.disabled = true
	textbox.text = "Her er den første plads. Her gælder de her regler:
					Hvis bilen er rød
					Så skal den parkere øverst
					Ellers hvis bilen er blå 
					Så skal den parkere nederst"
	helper.text = "Tryk på pilene for at få bilerne til at køre hen til de rigtige parkeringspladser."
	level.text = "Bane 1"
	
	for parking_spot in parking.get_node("Up").get_children():
		parking_spot.conditions = upCond
	for parking_spot in parking.get_node("Down").get_children():
		parking_spot.conditions = downCond


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if score == nrCars:
		helper.text = "Godt gået!"
		helper.modulate = "00ffff"
		completed.disabled = false


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
	helper.text = "Rigtigt"
	helper.modulate = "07d434"
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
	helper.text = "FORKERT"
	helper.modulate = "da2031"

func spawnCar() -> void:
	currentCar = newCar.instantiate()
	add_child(currentCar)
	currentCar.position = spawn
	currentCar.parkingSpot = parking.get_node("Start")
