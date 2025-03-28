extends BaseDropdownLevel

@onready var intro: Control = $GUI/IngameGUIDropdown/Intro

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 7
	intro.visible = true
	
	# Car options
	usedColors = [0, 1]
	carColors = [[0],[0],[0],[0],[1],[1],[1],[1],[0, 1],[0, 1]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	leftCond = ["0_3_0", "0_0_0"]
	rightCond = ["1_3_0", "1_0_0"]
	assign_conditions()
	
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til højre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til venstre.")
	
	# Text
	textbox = "Nu er højre side reserveret til de røde biler og de blå biler skal holde til venstre.
	
				Design en instruktion som bilerne kan følge ved at vælge en af mulighederne herunder."
	tips.push_back("Brug dropdown menuerne til at bestemme hvor en bil af en bestemt farve skal parkere.")
	tips.push_back(textbox)
	introLabel = "Du har jo super godt styr på parkering!\n
				Men man bliver træt, hvis man skal hjælpe hver eneste lille bil på vej. Vi må have dig til at lave systemer, som bilerne kan følge, når de skal finde en parkeringsplads.\n
				I den her bane skal du designe en instruktion til bilerne før de overhovedet er kommet.\n
				Held og lykke!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	disableRun = checkRun()
	
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			intro.visible = false
			intro.z_index = -1
			
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
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[1]:
					if !moveCar(1): # Left
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				else:
					pop_up_complete.lose("Du har ikke bestemt hvor denne farve bil skal hen.")
					break
			else:
				break
