extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 8
	canRun = true
	pop_up_complete.visible = false
	stopwatch = STOPWATCH.instantiate()
	
	# Car options
	usedColors = [2, 4, 5]
	carColors = [[2],[2],[2],[4],[4,5],[5],[2,4],[2,5],[2,4,5]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	runtimeCarColors = carColors.duplicate(true)
	runtimeCarOrigins = carOrigins.duplicate(true)
	carShapes = [0]
	nrCars = carColors.size()
	
	# Win conditions
	leftCond = ["2_3_0", "2_0_0"]
	rightCond = ["4_3_0", "4_0_0", "5_3_0", "5_0_0"]
	assign_conditions()
	
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til højre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til højre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til venstre.")
	
	# Text
	textbox = "Nu er venstre side reserveret til de orange biler. Højre side er til de grønne og gule."
	tips.push_back("Nu er der flere farver biler, der må parkere i samme side.")
	tips.push_back("Instruksen står ikke i samme rækkefølge som chefens regler.")
	tips.push_back(textbox)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	# Disable run if there is nothing selected
	for item in optionSelected:
		if item == -1:
			disableRun = true
			break
		else:
			disableRun = false
	
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
				if !moveCar(2): # Right
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
			elif currentCar.color == optionSelected[1]:
				if !moveCar(2): # Right
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
			elif currentCar.color == optionSelected[2]:
				if !moveCar(1): # Left
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
			else:
				textbox = "Det var en smutter. Du har ikke bestemt hvor denne farve bil skal hen. Tryk på genstart og prøv igen."
				break
