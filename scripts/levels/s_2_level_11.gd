extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 17
	canRun = true
	pop_up_complete.visible = false
	stopwatch = STOPWATCH.instantiate()
	
	# Car options
	usedColors = [0, 3, 4]
	carColors = [[0],[0],[0],[0],[3],[3],[3],[3],[4],[4],[4],[4],[0, 3, 4]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	runtimeCarColors = carColors.duplicate(true)
	runtimeCarOrigins = carOrigins.duplicate(true)
	carShapes = [0]
	nrCars = carColors.size()
	
	# Win conditions
	usedDirections = [0,2,3]
	upCond = ["4_1_0"]
	rightCond = ["3_1_0"]
	downCond = ["0_1_0"]
	assign_conditions()
	
	# Select if dropdowns to use
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	# Text
	textbox = "Nu skal vi prøve at lave \"hvis/så\" instruktioner på en parkeringsplads med 3 rækker."
	tips.push_back("Det behøver nødvendigvis ikke være de samme ord du bruger til din instruktion, som chefen har brugt i sine regler.")
	tips.push_back("Tag det stille og roligt! Løs én regel ad gangen.")
	tips.push_back("Blå biler må kun parkere i bunden,
						øverste del er reserveret til grønne biler,
						og i højre side er det kun lilla biler, der er tilladt.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	for item in optionSelected:
		if item == -1:
			disableRun = true
			break
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
			textbox = "Hovsa. Der er nogle biler der er parkeret forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."

func _on_run_pressed() -> void:
	if canRun:
		canRun = false
		for car in nrCars:
			await wait(1)
			if restartPressed:
				restartPressed = false
				break
			spawnCar()
			if currentCar.color == optionSelected[0]:
				if !moveCar(optionSelected[1]):
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
			elif currentCar.color == optionSelected[2]:
				if !moveCar(optionSelected[3]):
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
			elif currentCar.color == optionSelected[4]:
				if !moveCar(optionSelected[5]):
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
			else:
				textbox = "Det var en smutter. Du har ikke bestemt hvor denne farve bil skal hen. Tryk på genstart og prøv igen."
				break
