class_name BaseButtonLevel
extends Node2D

@export var newCar: PackedScene
@onready var parking: Node = $Parking
@onready var startSpawn: Node = $Parking/StartSpawn
@onready var pop_up_complete: Control = $GUI/IngameGUIButtons/PopUpComplete

# Car variables
var carColors: Array #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
var carOrigins: Array #0=Up 1=Left 2=Right 3=Down
var carShapes: int
var nrCars = carColors.size()

# Level variables
var upCond: Array
var leftCond: Array
var rightCond: Array
var downCond: Array
var nextScene: String

# Text variables
var level: int
var helper: String
var textbox: String
var introLabel: String

# Runtime variables
var carIncrementer = 0
var carStack = []
var currentCar: RandomCar
var parked = 0
var score = 0

# UI variables
var clicks = 0
var disableUp = true
var disableLeft = true
var disableRight = true
var disableDown = true
var disableCompleted = true
var disableUndo = true

func _on_up_pressed() -> void:
	print("Not implemented")

func _on_left_pressed() -> void:
	print("Not implemented")
	
func _on_right_pressed() -> void:
	print("Not implemented")

func _on_down_pressed() -> void:
	print("Not implemented")

func moveCar(x: int) -> void:
	print("Not implemented")

func spawnCar() -> void:
	await wait(0.25)
	if carIncrementer < nrCars:
		carIncrementer += 1
		currentCar = newCar.instantiate()
		currentCar.withData(carColors.pop_at(randi_range(0, carColors.size()-1)), carOrigins.pop_at(randi_range(0, carOrigins.size()-1)))
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


func undo() -> void:
	if parked < nrCars:
		currentCar = carStack.pop_back()
		if currentCar.isParked:
			parked -= 1
		if currentCar.isParkedCorrectly:
			score -= 1
		if currentCar.parkingSpot != null:
			currentCar.parkingSpot.isFree = true
		carColors.push_back([currentCar.color])
		carOrigins.push_back([currentCar.origin])
		carIncrementer -= 1
		currentCar.queue_free()
	
	currentCar = carStack.pop_back()
	if currentCar.isParked:
		parked -= 1
	if currentCar.isParkedCorrectly:
		score -= 1
	if currentCar.parkingSpot != null:
		currentCar.parkingSpot.isFree = true
	carColors.push_back([currentCar.color])
	carOrigins.push_back([currentCar.origin])
	carIncrementer -= 1
	currentCar.queue_free()
	
	spawnCar()


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
