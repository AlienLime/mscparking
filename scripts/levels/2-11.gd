extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 20
	
	# Car options
	usedColors = [0, 1, 3, 4, 5]
	carColors = [[0],[0],[0],[0],[1],[1],[1,3],[3],[3],[4],[4],[4, 5],[5],[5]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	upCond = ["0_1_0"]
	rightCond = ["4_1_0","5_1_0"]
	downCond = ["1_1_0","3_1_0"]
		
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere nedad.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere opad.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere nedad.")
	
	elseVisible = true
	elseLabel = "Ellers skal den parkere til højre."
	
	# Text
	textbox = "Instruktionerne er givet med farverne på pladserne."
	tips.push_back("Her kommer der 5 forskelige farver biler, men du kan kun vælge 3 bestemte farver. De sidste 2 skal bruge \"ellers\" udtrykket")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	disableRun = checkRun()

	completeLevel()

func _on_run_pressed() -> void:
	var movement
	if canRun:
		canRun = false
		for car in nrCars:
			if await wait(1):
				spawnCar()
				if currentCar.color == optionSelected[0]:
					if !moveCar(3): # Down
						pop_up_complete.lose("Der er ikke plads til bilen, hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[1]:
					if !moveCar(0): # Up
						pop_up_complete.lose("Der er ikke plads til bilen, hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[2]:
					if !moveCar(3): # Down
						pop_up_complete.lose("Der er ikke plads til bilen, hvis den skal følge dine instruktioner.")
						break
				else:
					if !moveCar(2): # Right
						pop_up_complete.lose("Der er ikke plads til bilen, hvis den skal følge dine instruktioner.")
						break
			else:
				break
