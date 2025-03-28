extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 13
	
	# Car options
	usedColors = [0, 3, 4]
	carColors = [[0],[0],[0],[0],[3],[3],[3],[3],[4],[4],[4],[4],[0, 3, 4]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	upCond = ["4_1_0"]
	rightCond = ["3_1_0"]
	downCond = ["0_1_0"]
		
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere opad.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til højre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere nedad.")
	
	# Text
	textbox = "Nu skal vi prøve at lave instruktioner på en parkeringsplads med 3 rækker."
	tips.push_back("Rækkefølgen af reglerne er ikke nødvendigvis den samme som rækkefølgen i din instruktion.")
	tips.push_back("Blå biler må kun parkere i bunden,
						øverste del er reserveret til grønne biler,
						og i højre side er det kun lilla biler, der er tilladt.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	disableRun = checkRun()
	
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
			if await wait(1):
				spawnCar()
				if currentCar.color == optionSelected[0]:
					if !moveCar(0): # Up
						textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
						break
				elif currentCar.color == optionSelected[1]:
					if !moveCar(2): # Right
						textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
						break
				elif currentCar.color == optionSelected[2]:
					if !moveCar(3): # Down
						textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
						break
				else:
					print("Car with an unchosen color found. Found colors was " + str(optionSelected[0]) + ", " + str(optionSelected[1]) + " and " + str(optionSelected[2]))
			else:
				break
