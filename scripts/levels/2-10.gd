extends BaseDropdownLevel

@onready var intro: Control = $GUI/IngameGUIDropdown/Intro

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 19
	
	# Car options
	usedColors = [3, 4]
	carColors = [[3],[3],[3],[4],[4],[4],[3, 4],[3, 4],[3, 4]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	leftCond = ["4_3_0", "4_0_0"]
	rightCond = ["3_3_0", "3_0_0"]
	assign_conditions()
	
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til højre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til venstre.")
	
	# Text
	textbox = "Instruktionerne er givet med farverne på pladserne."
	tips.push_back("Tryk på en dropdown for at se de mulige farver, og fordel dem, så det passer med farverne på pladserne.")
	tips.push_back("Her har vi kun med 2 farver biler at gøre, så du skal bare finde det rigtige sted at bruge hver farve.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	disableRun = checkRun()
	
	completeLevel()

func _on_run_pressed() -> void:
	if canRun:
		runCounter
		canRun = false
		for car in nrCars:
			if await wait(1):
				spawnCar()
				if currentCar.color == optionSelected[0]:
					if !moveCar(2): # Right
						pop_up_complete.lose("Der er ikke plads til bilen, hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[1]:
					if !moveCar(1): # Left
						pop_up_complete.lose("Der er ikke plads til bilen, hvis den skal følge dine instruktioner.")
						break
				else:
					pop_up_complete.lose("Du har ikke bestemt, hvor denne farve bil skal hen.")
					break
			else:
				break
