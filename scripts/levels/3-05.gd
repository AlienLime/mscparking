extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 26
	
	# Car options
	usedColors = [0, 1, 2, 5]
	carColors = [[0],[0],[1],[1],[1],[1],[2],[2],[2],[2],[5],[5],[0, 1, 2, 5]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	usedDirections = [0,2,3]
	upCond = ["2_1_0"]
	rightCond = ["0_1_0", "5_1_0"]
	downCond = ["1_1_0"]
	
	# Select if dropdowns to use
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	elseVisible = true
	elseLabel = "Ellers skal den parkere til højre."
	
	# Text
	textbox = "Instruktionerne er givet med farverne på pladserne."
	tips.push_back("Tag det stille og roligt! Løs én regel ad gangen.")
	tips.push_back("Hvor mange farver biler kommer der? Du skal bruge \"ellers\" udtrykket for at vise alle bilerne på plads.")
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
				else:
					if !moveCar(2): #Right
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
			else:
				break
