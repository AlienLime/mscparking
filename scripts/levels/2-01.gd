extends BaseDropdownLevel

@onready var intro: Control = $GUI/IngameGUIDropdown/Intro

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 10
	intro.visible = true
	disableTips = true
	
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
	introLabel = "Du har jo super godt styr på parkering!\n
				Men man bliver træt, hvis man skal hjælpe hver eneste bil på vej. I de næste baner skal du designe en instruktion til bilerne, før de overhovedet er kommet, så de selv kan parkere."
	textbox = "Nu er højre side reserveret til de røde biler, og de blå biler skal holde til venstre.
	
				Brug dropdown menuerne til at bestemme, hvor en bil af en bestemt farve skal parkere."
	tips.push_back("Sørg for at læse chefens regler og dine valgmuligheder grundigt.")
	tips.push_back(textbox)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	disableRun = checkRun()
	
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			intro.visible = false
			disableTips = false
			
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
