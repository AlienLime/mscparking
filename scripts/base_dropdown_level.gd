class_name BaseDropdownLevel
extends Node2D

const newCar = preload("res://scenes/random_car_driving.tscn")
const STOPWATCH = preload("res://scenes/stopwatch.tscn")
const levelDir = "res://scenes/levels/"

@onready var parking: Node = $Parking
@onready var startSpawn: Node = $Parking/StartSpawn
@onready var pop_up_complete: Control = $GUI/IngameGUIDropdown/PopUpComplete

# Car variables
var carStack: Array
var usedColors: Array #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
var carColors: Array #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
var runtimeCarColors: Array
var carOrigins: Array #0=Up 1=Left 2=Right 3=Down
var runtimeCarOrigins: Array
var carShapes: Array
var nrCars: int

# Level variables
var usedDirections: Array #0=Up 1=Left 2=Right 3=Down
var upCond: Array
var leftCond: Array
var rightCond: Array
var downCond: Array
var nextScene: String
var optionSelected: Array
var ifArray: Array
var elseVisible = false

# Text variables
var level: int
var ifLabel: Array
var thenLabel: Array
var elseLabel: String
var textbox: String
var introLabel: String
var tips: Array

# Runtime variables
var carIncrementer = 0
var currentCar: RandomCar
var parked = 0
var score = 0
var tipCounter = 0
var runCounter = 0
var restartCounter = 0
var undoCounter = 0

# UI variables
var clicks = 0
var disableCompleted = true
var disableUndo = true
var disableRun = true
var canRun = true
var restartPressed = false

# Logging
var stopwatch : Stopwatch


func setup() -> void:
	print("setup not implemented")


func _ready() -> void:
	pop_up_complete.visible = false
	setup()
	nrCars = carColors.size()
	runtimeCarColors = carColors.duplicate(true)
	runtimeCarOrigins = carOrigins.duplicate(true)
	assign_conditions()
	
	print("level " + str(level) + " initiated.")
	stopwatch = STOPWATCH.instantiate()

func checkRun() -> bool:
	# Disable run it is already running
	if !canRun:
		return true
	# Disable run if there is nothing selected
	for item in optionSelected:
		if item == -1:
			return true
	return false

func spawnCar() -> void:
	if carIncrementer < nrCars:
		carIncrementer += 1
		currentCar = newCar.instantiate()
		currentCar.withData(runtimeCarColors.pop_at(randi_range(0, runtimeCarColors.size()-1)), runtimeCarOrigins.pop_at(randi_range(0, runtimeCarOrigins.size()-1)))
		add_child(currentCar)
		carStack.push_back(currentCar)
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


func moveCar(x: int) -> bool:
	if currentCar:
		if x == 0:
			for spot in parking.get_node("Up").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					currentCar = null
					return true #Car moved
		elif x == 1:
			for spot in parking.get_node("Left").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					currentCar = null
					return true #Car moved
		elif x == 2:
			for spot in parking.get_node("Right").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					currentCar = null
					return true #Car moved
		elif x == 3:
			for spot in parking.get_node("Down").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					currentCar = null
					return true #Car moved
		else: 
			print("Direction not implemented")
	else:
		print("Currentcar is null")
	return false # Car not moved

func restart() -> void:
	restartPressed = true
	pop_up_complete.visible = false
	if !currentCar:
		currentCar = carStack.pop_back()
	while currentCar:
		currentCar.queue_free()
		currentCar = carStack.pop_back()
	
	for child in parking.get_children():
		if child != startSpawn:
			for spot in child.get_children():
				spot.isFree = true
	
	runtimeCarColors = carColors.duplicate(true)
	runtimeCarOrigins = carOrigins.duplicate(true)
	parked = 0
	score = 0
	carIncrementer = 0
	canRun = true
	await get_tree().create_timer(1).timeout
	restartPressed = false


func undo() -> void:
	restart()

func get_next_level() -> String:
	var dir = ResourceLoader.list_directory(levelDir)
	return levelDir + dir.get(level)


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


func completeLevel() -> void:
	if parked == nrCars && !pop_up_complete.visible:
		if score == nrCars:
			pop_up_complete.win()
			disableCompleted = false
		else:
			pop_up_complete.lose()


func wait(seconds: float) -> bool:
	await get_tree().create_timer(seconds).timeout
	if restartPressed:
		return false
	return true
	
