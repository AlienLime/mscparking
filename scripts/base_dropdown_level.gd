class_name BaseDropdownLevel
extends Node2D

const newCar = preload("res://scenes/random_car_driving.tscn")
const levelDir = "res://scenes/levels/"

@onready var parking: Node = $Parking
@onready var startSpawn: Node = $Parking/StartSpawn
@onready var pop_up_complete: Control = $GUI/IngameGUIDropdown/PopUpComplete

# Car variables
var carStack: Array
var usedColors: Array
var carColors: Array #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
var carOrigins: Array #0=Up 1=Left 2=Right 3=Down
var carShapes: Array
var nrCars: int

# Level variables
var upCond: Array
var leftCond: Array
var rightCond: Array
var downCond: Array
var nextScene: String
var colorSelected = [-1,-1,-1]
var colorIf = [false,false,false]
var elseVisible = false

# Text variables
var level: int
var ifLabel = ["not defined","not defined","not defined"]
var thenLabel = ["not defined","not defined","not defined"]
var elseLabel: String = "bøvs"
var helper: String
var textbox: String
var introLabel: String
var tips: Array

# Runtime variables
var carIncrementer = 0
var currentCar: RandomCar
var parked = 0
var score = 0

# UI variables
var clicks = 0
var disableCompleted = true
var disableUndo = true
var disableRun = true
var canRun = true

func spawnCar() -> void:
	await wait(0.40)
	if carIncrementer < nrCars:
		carIncrementer += 1
		currentCar = newCar.instantiate()
		currentCar.withData(carColors.pop_at(randi_range(0, carColors.size()-1)), carOrigins.pop_at(randi_range(0, carOrigins.size()-1)))
		add_child(currentCar)
		match currentCar.origin:
			0:
				currentCar.position = startSpawn.get_node("UpSpawn").position
				currentCar.navigationTarget = startSpawn.get_node("UpStart")
			1:
				currentCar.position = startSpawn.get_node("LeftSpawn").position
				currentCar.navigationTarget = startSpawn.get_node("LeftStart")
			2:
				currentCar.position = startSpawn.get_node("RightSpawn").position
				currentCar.navigationTarget = startSpawn.get_node("RightStart")
			3:
				currentCar.position = startSpawn.get_node("DownSpawn").position
				currentCar.navigationTarget = startSpawn.get_node("DownStart")
			_:
				print("spawn origin does not exist")


func moveCar(x: int) -> void:
	if currentCar:
		if x == 0:
			for spot in parking.get_node("Up").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					currentCar = null
					break
		elif x == 1:
			for spot in parking.get_node("Left").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					currentCar = null
					break
		elif x == 2:
			for spot in parking.get_node("Right").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					currentCar = null
					break
		elif x == 3:
			for spot in parking.get_node("Down").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					currentCar = null
					break
		else: 
			print("Direction not implemented")


func get_next_level() -> String:
	var dir = DirAccess.open(levelDir)
	var next_level: String
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		var level_name = get_tree().current_scene.name
		while file_name != (level_name + ".tscn"):
			file_name = dir.get_next()
		file_name = dir.get_next()
		if file_name == "":
			next_level = "res://scenes/victory_screen.tscn"
		else:
			next_level = "res://scenes/levels/" + file_name
	else:
		print('An error occurred when trying to access the path')
	return next_level

func assign_conditions() -> void:
	if parking.get_node("Up"):
		for parking_spot in parking.get_node("Up").get_children():
			parking_spot.conditions = upCond
	if parking.get_node("Left"):
		for parking_spot in parking.get_node("Left").get_children():
			parking_spot.conditions = leftCond
	if parking.get_node("Right"):
		for parking_spot in parking.get_node("Right").get_children():
			parking_spot.conditions = rightCond
	if parking.get_node("Down"):
		for parking_spot in parking.get_node("Down").get_children():
			parking_spot.conditions = downCond

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
	
