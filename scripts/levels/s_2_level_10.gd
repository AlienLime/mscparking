extends BaseDropdownLevel

@onready var intro: Control = $GUI/IngameGUIDropdown/Intro

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 16
	intro.visible = true
	
	# Car options
	usedColors = [0, 1]
	carColors = [[0],[0],[0],[0],[1],[1],[1],[1],[0, 1],[0, 1]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	usedDirections = [1,2]
	leftCond = ["0_3_0", "0_0_0"]
	rightCond = ["1_3_0", "1_0_0"]
	
	# Select if dropdowns to use
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	# Text
	textbox = "På denne parkeringsplads er højre side reserveret til de røde biler, og de blå biler skal holde til venstre.
	
				Design en instruktion med de nye valgmuligheder."
	tips.push_back("Nu kan man selv vælge rækkefølgen af sine regler")
	tips.push_back("Tag det stille og roligt! Løs én regel ad gangen.")
	tips.push_back(textbox)
	introLabel = "Indtil nu, har jeg hjulpet dig med, hvad der skulle ske, hvis bilen havde den farve, som du valgte.
	
					Nu får du mere ansvar, og du skal selv beslutte, hvor bilerne skal køre hen."

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
					pop_up_complete.lose("Du har ikke bestemt hvor denne farve bil skal hen.")
					break
			else:
				break
