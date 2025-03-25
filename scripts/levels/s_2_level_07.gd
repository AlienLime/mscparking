extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 7
	canRun = true
	pop_up_complete.visible = false
	
	# Car options
	usedColors = [0, 3, 4]
	carColors = [[0],[0],[0],[0],[3],[3],[3],[3],[4],[4],[4],[4],[0, 3, 4]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	nrCars = carColors.size()
	
	# Win conditions
	upCond = ["4_1_0"]
	rightCond = ["3_1_0"]
	downCond = ["0_1_0"]
	assign_conditions()
		
	# Select if dropdowns to use
	colorIf[0] = true
	ifLabel[0] = "Hvis bilen er "
	thenLabel[0] = "så skal den parkere opad."
	colorIf[1] = true
	ifLabel[1] = "Hvis bilen er "
	thenLabel[1] = "så skal den parkere til højre."
	colorIf[2] = true
	ifLabel[2] = "Hvis bilen er "
	thenLabel[2] = "så skal den parkere nedad."
	
	# Text
	textbox = "Nu skal vi prøve at lave instruktioner på en parkeringsplads med 3 rækker."
	tips.push_back("Rækkefølgen af reglerne er ikke nødvendigvis den samme som rækkefølgen af din instruks")
	tips.push_back("Blå biler må kun parkere i bunden,
						øverste del er reserveret til grønne biler
						og i højre side er det kun lilla biler der er tilladt.")

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
			textbox = "Blå biler må kun parkere i bunden,
						øverste del er reserveret til grønne biler
						og i højre side er det kun lilla biler der er tilladt."
	if parked == nrCars:
		if score == nrCars:
			pop_up_complete.visible = true
			disableCompleted = false
		else:
			helper = "Hovsa. Der er nogle biler der er parkeret forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."

func _on_run_pressed() -> void:
	if colorSelected[0] != -1 && colorSelected[1] != -1 && colorSelected[2] != -1 && canRun:
		canRun = false
		for car in nrCars:
			spawnCar()
			await wait(1)
			if currentCar.color == colorSelected[0]:
				moveCar(0) # Up
			elif currentCar.color == colorSelected[1]:
				moveCar(2) # Right
			elif currentCar.color == colorSelected[2]:
				moveCar(3) # Down
			else:
				print("Car with an unchosen color found. Found colors was " + str(colorSelected[0]) + ", " + str(colorSelected[1]) + " and " + str(colorSelected[2]))
