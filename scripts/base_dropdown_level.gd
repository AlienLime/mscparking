class_name BaseDropdownLevel
extends Node2D

const newCar = preload("res://scenes/random_car_driving.tscn")
const STOPWATCH = preload("res://scenes/stopwatch.tscn")
const levelDir = "res://scenes/levels/"

@onready var parking: Node = $Parking
@onready var startSpawn: Node = $Parking/StartSpawn
@onready var pop_up_complete: Control = $GUI/IngameGUIDropdown/PopUpComplete

# Car variables
var carStack = [] # Used to keep track of cars
var usedColors: Array #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
var carColors: Array # potential car colors, 0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
var runtimeCarColors: Array # chosen car colors
var carOrigins: Array # potential car origins, 0=Up 1=Left 2=Right 3=Down
var runtimeCarOrigins: Array # chosen car origins
var carShapes: Array # potential car shapes
var nrCars = carColors.size() # the number of cars that spawn druing a level

# Level variables
var level: int # the placement of the level in the level folder
var usedDirections: Array # the directions used in the level, 0=Up 1=Left 2=Right 3=Down
var upCond: Array # conditions of top parkingspots
var leftCond: Array # conditions of left parkingspots
var rightCond: Array # conditions of right parkingspots
var downCond: Array # conditions of bottom parkingspots
var nextScene: String # the path to the following level
var optionSelected: Array # the selected values of the drop-down menus
var ifArray: Array # holds the "if-then"-parts
var elseVisible = false # enables the "else"-part
var elseThenVisible = false # enables the "else-then"-part

# Text variables
var ifLabel: Array # the text for the "if"-parts
var thenLabel: Array # the text for the "then"-parts
var elseLabel: String # the text for the "else"-part
var textbox: String # the text for the box with Hjælpe Jens
var introLabel: String # the text for any potential intro
var tips: Array # the tips shown when clicking Hjælpe Jens

# Runtime variables
var carIncrementer = 0 # keeps track of the amount of spawned cars
var currentCar: RandomCar # holds the currently controlled car
var parked = 0 # number of parked cars
var score = 0 # number of correctly parked cars

# UI variables
var clicks = 0 # number of times LMB has been clicked
	# The following variables are used to disable buttons not in use
var disableCompleted = true
var disableRun = true
var disableTips = false
var canRun = true
var restartPressed = false
var undoVisible = false

# Logging
var stopwatch : Stopwatch # used to record the time
var tipCounter = 0 # number of times Hjælpe Jens has been pressed
var runCounter = 0 # number of times run has been pressed
var restartCounter = 0 # number of times restart has been pressed
var undoCounter = 0 # number of times undo has been pressed

# setup function to overwrite when designing levels
func setup() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Error,Setup not implemented")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pop_up_complete.visible = false
	setup()
	nrCars = carColors.size()
	runtimeCarColors = carColors.duplicate(true)
	runtimeCarOrigins = carOrigins.duplicate(true)
	assign_conditions()
	
	stopwatch = STOPWATCH.instantiate()
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Level initiated," + str(level))

# used to disable the run button when the drop-downs are not filled or when the level is already running
func checkRun() -> bool:
	# Disable run it is already running
	if !canRun:
		return true
	# Disable run if there is nothing selected
	for item in optionSelected:
		if item == -1:
			return true
	return false

# spawns a new car and sets it as currentCar
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
				print(Globals.USERID + "," + stopwatch.time_to_string() + ",Error,Spawn origin does not exist")

# attempts to moves currentCar to a free parking spot in the chosen direction
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
			print(Globals.USERID + "," + stopwatch.time_to_string() + ",Error,Direction not implemented")
	else:
		print(Globals.USERID + "," + stopwatch.time_to_string() + ",Error,Currentcar is null")
	return false # Car not moved

# restarts the level, removing all cars from the parking lot
func restart() -> void:
	restartCounter += 1
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
	await get_tree().create_timer(2).timeout
	restartPressed = false

# gets the next level in the level folder
func get_next_level() -> String:
	var dir = ResourceLoader.list_directory(levelDir)
	if level == dir.size():
		return "res://scenes/victory_screen.tscn"
	return levelDir + dir.get(level)

# assigns the level conditions to each individual parking spot
func assign_conditions() -> void:
	if parking.get_node_or_null("Up"):
		for parking_spot in parking.get_node("Up").get_children():
			parking_spot.conditions = upCond
	if parking.get_node_or_null("Left"):
		for parking_spot in parking.get_node("Left").get_children():
			parking_spot.conditions = leftCond
	if parking.get_node_or_null("Right"):
		for parking_spot in parking.get_node("Right").get_children():
			parking_spot.conditions = rightCond
	if parking.get_node_or_null("Down"):
		for parking_spot in parking.get_node("Down").get_children():
			parking_spot.conditions = downCond

# shows a pop up when all cars are parked, green if succes, red if failure
func completeLevel() -> void:
	if parked == nrCars && !pop_up_complete.visible:
		if score == nrCars:
			pop_up_complete.win()
			disableCompleted = false
		else:
			pop_up_complete.lose("Nogle af bilerne er parkeret forkert!")

# auxilary function to delay car spawns
func wait(seconds: float) -> bool:
	await get_tree().create_timer(seconds).timeout
	if restartPressed:
		return false
	return true
	
