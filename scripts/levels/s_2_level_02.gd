extends BaseDropdownLevel

@onready var intro: Control = $GUI/IngameGUIDropdown/Intro

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 2
	canRun = true
	pop_up_complete.visible = false
	
	# Car options
	usedColors = [2, 4, 5]
	carColors = [[2],[2],[2],[4],[4,5],[5],[2,4],[2,5],[2,4,5]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	nrCars = carColors.size()
	
	# Win conditions
	leftCond = ["2_3_0", "2_0_0"]
	rightCond = ["4_3_0", "4_0_0", "5_3_0", "5_0_0"]
	assign_conditions()
	
	# Select if dropdowns to use
	colorIf[0] = true
	ifLabel[0] = "Hvis bilen er "
	thenLabel[0] = "så skal den parkere til højre."
	colorIf[1] = true
	ifLabel[1] = "Hvis bilen er "
	thenLabel[1] = "så skal den parkere til højre."
	colorIf[2] = true
	ifLabel[2] = "Hvis bilen er "
	thenLabel[2] = "så skal den parkere til venstre."
	
	# Text
	textbox = "Nu er venstre side reserveret til de orange biler. Hæjre side er til de grønne og gule."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Disable run if there is nothing selected
	if colorSelected[0] == -1 || colorSelected[1] == -1 || colorSelected[2] == -1:
		disableRun = true
	else:
		disableRun = false
	
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			intro.visible = false
			intro.z_index = -1
	if parked == nrCars:
		if score == nrCars:
			pop_up_complete.visible = true
			disableCompleted = false
		else:
			textbox = "Hovsa. Der er nogle biler der er parkeret forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."

func _on_run_pressed() -> void:
	if colorSelected[0] != -1 && colorSelected[1] != -1 && colorSelected[2] != -1 && canRun:
		canRun = false
		for car in nrCars:
			spawnCar()
			await wait(1)
			if currentCar.color == colorSelected[0]:
				moveCar(2) # Right
			elif currentCar.color == colorSelected[1]:
				moveCar(2) # Right
			elif currentCar.color == colorSelected[2]:
				moveCar(1) # Left
			else:
				textbox = "Det var en smutter. Du har ikke bestemt hvor denne farve bil skal hen. Tryk på genstart og prøv igen."
				break
