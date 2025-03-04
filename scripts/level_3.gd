extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var textbox: Label = $GUI/IngameGUIDropdown/Label
@onready var completed: Button = $GUI/IngameGUIDropdown/TopCornerBox/MarginContainer/VBoxContainer/Hbox/Completed
@onready var helper: Label = $GUI/IngameGUIDropdown/DropdownBox/MarginContainer/HBoxContainer/VBoxContainer/Helper
@onready var label: Label = $GUI/IngameGUIDropdown/DropdownBox/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/IfColor/HBoxContainer/Label
@onready var color_if: Label = $GUI/IngameGUIDropdown/DropdownBox/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/IfColor/HBoxContainer/If
@onready var color_option: OptionButton = $GUI/IngameGUIDropdown/DropdownBox/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/IfColor/HBoxContainer/OptionButton
@onready var color_then: Label = $GUI/IngameGUIDropdown/DropdownBox/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/IfColor/HBoxContainer/Then
@onready var level: Label = $GUI/IngameGUIDropdown/TopCornerBox/MarginContainer/VBoxContainer/level
@onready var intro: Label = $Intro/Label

var carIndex = 0
var currentCar
var currentPos
var rightPark = 0
var leftPark = 0
var done = 0
var spawnUp
var spawnDown
var score = 0
var canRun = true

const nextScene = "res://scenes/victory_screen.tscn"
const nrCars = 5
const leftCond = ["0_3_0", "0_0_0"]
const rightCond = ["1_3_0", "1_0_0"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	canRun = true
	spawnUp = parking.get_node("SpawnUp").position
	spawnDown = parking.get_node("SpawnDown").position
	completed.disabled = true
	
	intro.text = "Du har da super godt styr på parkering!\n
				Men du kan ikke stå ved den samme parkeringsplads hele dagen. Vi må have dig til at lave systemer som bilerne kan følge når de skal finde en parkeringsplads.\n
				I den næste bane skal du designe en instruktion til bilerne før de overhovedet er kommet.\n
				Held og lykke!"
	textbox.text = "Denne gang er højre side reserveret til de røde biler."
	helper.text = "Design en instruktion som bilerne kan følge ved at vælge en af mulighederne herunder."
	color_if.text = "Hvis 
					bilen 
					er "
	color_then.text = "Så skal den
						parkere til 
						højre."
	level.text = "Bane 3"
						
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

func spawnCar() -> void:
	currentCar = newCar.instantiate()
	add_child(currentCar)
	if randi_range(0, 1) == 1:
		currentCar.position = spawnUp
		currentCar.origin = "0"
		currentCar.parkingSpot = parking.get_node("StartUp")
	else:
		currentCar.position = spawnDown
		currentCar.origin = "3"
		currentCar.parkingSpot = parking.get_node("StartDown")

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout

func _on_run_pressed() -> void:
	if color_option.get_selected_id() != -1 && canRun:
		canRun = false
		for car in nrCars:
			spawnCar()
			await wait(2.5)
			if currentCar.color == color_option.get_selected_id():
				moveCar(0)
			else:
				moveCar(1)
