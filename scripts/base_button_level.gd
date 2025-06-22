class_name BaseButtonLevel
extends Node2D

const newCar = preload("res://scenes/random_car_driving.tscn")
const STOPWATCH = preload("res://scenes/stopwatch.tscn")
const levelDir = "res://scenes/levels/"

@onready var parking: Node = $Parking
@onready var startSpawn: Node = $Parking/StartSpawn
@onready var pop_up_complete: Control = $GUI/IngameGUIButtons/PopUpComplete

# Car variables
var carStack: Array # Used to keep track of cars
var carColors: Array # potential car colors, 0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
var runtimeCarColors: Array # chosen car colors
var carOrigins: Array # potential car origins, 0=Up 1=Left 2=Right 3=Down
var runtimeCarOrigins: Array # chosen car origins
var carShapes: int # potential car shapes
var nrCars = carColors.size() # the number of cars that spawn druing a level

# Level variables
var level: int # the placement of the level in the level folder
var upCond: Array # conditions of top parkingspots
var leftCond: Array # conditions of left parkingspots
var rightCond: Array # conditions of right parkingspots
var downCond: Array # conditions of bottom parkingspots
var nextScene: String # the path to the following level

# Text variables
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
var disableUp = true
var disableLeft = true
var disableRight = true
var disableDown = true
var disableCompleted = true
var disableTips = false
var undoVisible = true

# Logging
var stopwatch : Stopwatch # used to record the time
var tipCounter = 0 # number of times Hjælpe Jens has been pressed
var runCounter = 0 # number of times run has been pressed
var restartCounter = 0 # number of times restart has been pressed
var undoCounter = 0 # number of times undo has been pressed

# setup function to overwrite when designing levels
func setup() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Error,setup not implemented")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pop_up_complete.visible = false
	setup()
	nrCars = carColors.size()
	runtimeCarColors = carColors.duplicate(true)
	runtimeCarOrigins = carOrigins.duplicate(true)
	assign_conditions()
	spawnCar()
	
	stopwatch = STOPWATCH.instantiate()
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Level initiated," + str(level))

# called when the up arrow or the up button is pressed
func _on_up_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Up")
	moveCar(0)

# called when the left arrow or the left button is pressed
func _on_left_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Left")
	moveCar(1)

# called when the right arrow or the right button is pressed
func _on_right_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Right")
	moveCar(2)

# called when the down arrow or the down button is pressed
func _on_down_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Down")
	moveCar(3)

# Moves currentCar to a free parking spot in the direction of the pressed button
func moveCar(x: int) -> void:
	if currentCar:
		if x == 0:
			for spot in parking.get_node("Up").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					print(Globals.USERID + "," + stopwatch.time_to_string() + ",Car moved,Up")
					nextCar()
					break
		elif x == 1:
			for spot in parking.get_node("Left").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					print(Globals.USERID + "," + stopwatch.time_to_string() + ",Car moved,Left")
					nextCar()
					break
		elif x == 2:
			for spot in parking.get_node("Right").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					print(Globals.USERID + "," + stopwatch.time_to_string() + ",Car moved,Right")
					nextCar()
					break
		elif x == 3:
			for spot in parking.get_node("Down").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					print(Globals.USERID + "," + stopwatch.time_to_string() + ",Car moved,Down")
					nextCar()
					break
		else: 
			print(Globals.USERID + "," + stopwatch.time_to_string() + ",Error,Direction not implemented")

# relieves control of currentCar and spawns a new car if neither undo nor restart is pressed
func nextCar() -> void:
	currentCar = null
	var temp = undoCounter + restartCounter
	await wait(1)
	if temp == undoCounter + restartCounter:
		spawnCar()

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
				print(Globals.USERID + "," + stopwatch.time_to_string() + ",Error,spawn origin does not exist")

# restarts the level, removing all cars from the parking lot
func restart() -> void:
	restartCounter += 1
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
	spawnCar()

# removes the most recently parked car and the current car, handling edge cases accordingly
func undo() -> void:
	undoCounter += 1
	if pop_up_complete.visible:
		return
	if score < nrCars:
		currentCar = carStack.pop_back()
		if currentCar.isParked:
			parked -= 1
		if currentCar.isParkedCorrectly:
			score -= 1
		if currentCar.parkingSpot != null:
			currentCar.parkingSpot.isFree = true
		runtimeCarColors.push_back([currentCar.color])
		runtimeCarOrigins.push_back([currentCar.origin])
		carIncrementer -= 1
		currentCar.queue_free()
	
	currentCar = carStack.pop_back()
	if currentCar.isParked:
		parked -= 1
	if currentCar.isParkedCorrectly:
		score -= 1
	if currentCar.parkingSpot != null:
		currentCar.parkingSpot.isFree = true
	runtimeCarColors.push_back([currentCar.color])
	runtimeCarOrigins.push_back([currentCar.origin])
	carIncrementer -= 1
	currentCar.queue_free()
	
	spawnCar()

# gets the next level in the level folder
func get_next_level() -> String:
	var dir = ResourceLoader.list_directory(levelDir)
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
func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
