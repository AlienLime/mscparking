extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 30
	
	# Car options
	usedColors = [0, 1, 2, 3, 5]
	carColors = [[0],[0],[0],[0],[1],[1],[1],[1],[2],[2],[2],[2],[3],[3, 5],[3, 5],[3, 5],[5]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	usedDirections = [0,1,2,3]
	upCond = ["3_3_0","5_3_0"]
	leftCond = ["0_3_0","2_3_0"]
	rightCond = ["0_3_0","1_3_0"]
	downCond = ["1_3_0","2_3_0"]
	
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
	
	elseThenVisible = true
	elseLabel = "Ellers skal den parkere "
	
	# Text
	textbox = "Instruktionerne er givet med farverne på pladserne."
	tips.push_back("Hvor mange forskelige farver kan der komme?")
	tips.push_back("For at vise alle bilerne på plads skal du bruge \"ellers\" udtrykket på en smart måde.")
	tips.push_back(textbox)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	disableRun = checkRun()
	
	completeLevel()

# starts a loop where all cars are parked i accordance with the chosen conditions and consequenses
func _on_run_pressed() -> void:
	if canRun:
		canRun = false
		for car in nrCars:
			if await wait(1):
				spawnCar()
				if currentCar.color == optionSelected[0]:
					if !moveCar(optionSelected[1]):
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[2]:
					if !moveCar(optionSelected[3]):
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[4]:
					if !moveCar(optionSelected[5]):
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				else:
					if !moveCar(optionSelected[6]): # Right if left was not possible
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
			else:
				break
