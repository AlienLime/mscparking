extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 21
	
	# Car options
	usedColors = [0, 1, 2, 3]
	carColors = [[0],[0],[0],[0],[1],[1],[1],[1],[2],[2],[2],[2],[3],[3],[3],[3]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	upCond = ["0_3_0","3_3_0"]
	leftCond = ["1_3_0","2_3_0"]
	rightCond = ["1_3_0","2_3_0"]
	downCond = ["0_3_0","3_3_0"]
	
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
	tips.push_back("Er det vigtigt, om de blå biler parkere oppe eller nede?")
	tips.push_back("Hvis du viser alle de andre biler væk, så bliver den sidste farve biler vist til højre, 
					takket være \"ellers\" udtrykket.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	disableRun = checkRun()
	
	completeLevel()

func _on_run_pressed() -> void:
	if canRun:
		canRun = false
		for car in nrCars:
			if await wait(1.5):
				spawnCar()
				if currentCar.color == optionSelected[0]:
					if !moveCar(0): # Up
						pop_up_complete.lose("Der er ikke plads til bilen, hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[1]:
					if !moveCar(1): # Left
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
