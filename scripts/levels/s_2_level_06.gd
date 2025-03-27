extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 12
	canRun = true
	pop_up_complete.visible = false
	stopwatch = STOPWATCH.instantiate()
	
	# Car options
	usedColors = [1, 3, 4, 5]
	carColors = [[4],[4],[1,4],[4,5],[1],[3],[1,3],[1,3],[5],[1,3,5]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[3],[3],[3],[3],[3],[3],[3],[3],[3],[3]] #0=Up 1=Left 2=Right 3=Down
	runtimeCarColors = carColors.duplicate(true)
	runtimeCarOrigins = carOrigins.duplicate(true)
	carShapes = [0]
	nrCars = carColors.size()
	
	# Win conditions
	upCond = ["1_3_0","3_3_0","5_3_0"]
	leftCond = ["1_3_0","3_3_0","5_3_0"]
	rightCond = ["4_3_0"]
	downCond = ["1_3_0","3_3_0","5_3_0"]
	assign_conditions()
	
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere øverst.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til venstre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere nederst.")
	
	elseVisible = true
	elseLabel = "Ellers skal den parkere til højre"
	
	# Text
	textbox = "Her skal de grønne biler parkere til højre."
	tips.push_back("Er det vigtigt, hvor de lilla, gule og røde biler kører hen?")
	tips.push_back("Hvis du leder alle de andre biler væk, så bliver den sidste farve biler sendt til højre.")
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
				if !moveCar(0): # Up
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
			elif currentCar.color == optionSelected[1]:
				if !moveCar(1): # Left
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
			elif currentCar.color == optionSelected[2]:
				if !moveCar(3): # Down
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
			else:
				if !moveCar(2): # Right
					textbox = "Der var ikke plads til bilen. Tryk på genstart og prøv igen."
					break
