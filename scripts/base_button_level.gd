class_name BaseButtonLevel
extends Node2D

const newCar = preload("res://scenes/random_car_driving.tscn")
const STOPWATCH = preload("res://scenes/stopwatch.tscn")
const levelDir = "res://scenes/levels/"

@onready var parking: Node = $Parking
@onready var startSpawn: Node = $Parking/StartSpawn
@onready var pop_up_complete: Control = $GUI/IngameGUIButtons/PopUpComplete

# Car variables
var carStack = []
var carColors: Array #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
var runtimeCarColors: Array
var carOrigins: Array #0=Up 1=Left 2=Right 3=Down
var runtimeCarOrigins: Array
var carShapes: int
var nrCars = carColors.size()

# Level variables
var level: int
var upCond: Array
var leftCond: Array
var rightCond: Array
var downCond: Array
var nextScene: String

# Text variables
var levelName: String
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
var disableUp = true
var disableLeft = true
var disableRight = true
var disableDown = true
var disableCompleted = true
var disableTips = false
var undoVisible = true

# Logging
var stopwatch : Stopwatch

func setup() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Error,setup not implemented")

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

func _on_up_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Up")
	moveCar(0)

func _on_left_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Left")
	moveCar(1)
	
func _on_right_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Right")
	moveCar(2)

func _on_down_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Down")
	moveCar(3)


func moveCar(x: int) -> void:
	if currentCar:
		if x == 0:
			for spot in parking.get_node("Up").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					print(Globals.USERID + "," + stopwatch.time_to_string() + ",Car moved,Up")
					currentCar = null
					await wait(1)
					spawnCar()
					break
		elif x == 1:
			for spot in parking.get_node("Left").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					print(Globals.USERID + "," + stopwatch.time_to_string() + ",Car moved,Left")
					currentCar = null
					await wait(1)
					spawnCar()
					break
		elif x == 2:
			for spot in parking.get_node("Right").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					print(Globals.USERID + "," + stopwatch.time_to_string() + ",Car moved,Right")
					currentCar = null
					await wait(1)
					spawnCar()
					break
		elif x == 3:
			for spot in parking.get_node("Down").get_children():
				if spot.isFree:
					spot.isFree = false
					currentCar.parkingSpot = spot
					print(Globals.USERID + "," + stopwatch.time_to_string() + ",Car moved,Down")
					currentCar = null
					await wait(1)
					spawnCar()
					break
		else: 
			print(Globals.USERID + "," + stopwatch.time_to_string() + ",Error,Direction not implemented")

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


func get_next_level() -> String:
	var dir = ResourceLoader.list_directory(levelDir)
	return levelDir + dir.get(level)


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


func completeLevel() -> void:
	if parked == nrCars && !pop_up_complete.visible:
		if score == nrCars:
			pop_up_complete.win()
			disableCompleted = false
		else:
			pop_up_complete.lose("Nogle af bilerne er parkeret forkert!")
			disableCompleted = false


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
