extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var helper: Label = $GUI/IngameGUIButtons/ButtonBox/MarginContainer/HBoxContainer/Helper
@onready var textbox: Label = $GUI/IngameGUIButtons/Label
@onready var completed: Button = $GUI/IngameGUIButtons/TopCornerBox/MarginContainer/Hbox/Completed
@onready var left: Button = $GUI/IngameGUIButtons/ButtonBox/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Left
@onready var right: Button = $GUI/IngameGUIButtons/ButtonBox/MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/Right

var carIndex = 0
var currentCar
var upPark = 0
var downPark = 0
var done = 0
var spawn

const nrCars = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn = parking.get_node("Spawn").position
	spawnCar()
	left.disabled = true
	right.disabled = true
	completed.disabled = true
	textbox.text = "Hvis bilen er rød
Så skal den parkere øverst
Ellers skal den parkere nederst"
	helper.text = "Tryk på pilene for at vise bilerne hen til de korrekte pladser."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if done > nrCars-1:
		helper.text = "Godt gået!"
		helper.modulate = "00ffff"
		completed.disabled = false


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

func _on_completed_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/level_2.tscn")

func spawnCar() -> void:
	currentCar = newCar.instantiate()
	add_child(currentCar)
	currentCar.position = spawn
	currentCar.parkingSpot = parking.get_node("Start")

func _on_restart_pressed() -> void:
	get_tree().reload_current_scene()

func _on_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu.tscn")


func _on_left_pressed() -> void:
	pass # Replace with function body.


func _on_right_pressed() -> void:
	pass # Replace with function body.
