extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 14
	disableTips = true
	
	# Car options
	usedColors = [0, 1, 3, 4, 5]
	carColors = [[1],[1],[1],[1],[3],[3],[3],[3],[4],[4],[0,5],[0,5],[0,5],[1,3]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	upCond = ["3_1_0"]
	rightCond = ["1_1_0"]
	downCond = ["0_1_0","4_1_0","5_1_0"]
		
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere opad.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til højre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere nedad.")
	
	elseVisible = true
	elseLabel = "Ellers skal den parkere 
					i bunden."
	
	# Text
	textbox = "Godt gået! Nu prøver vi med den samme parkeringsplads men med en \"ellers\" instruktion."
	tips.push_back("Rækkefølgen af reglerne er ikke nødvendigvis den samme som rækkefølgen i din instruktion.")
	tips.push_back("\"Ellers\" tager sig af alle farverne, som der ikke laves \"hvis\" instruktioner til.")
	tips.push_back("Røde biler skal parkere til højre,
						bunden er reserveret til grønne biler,
						i den øverste del er det kun lilla biler, der er tilladt,
						og andre farver skal parkere sammen med de grønne biler.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	disableRun = checkRun()
	
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			disableTips = false
			textbox = "Røde biler skal parkere til højre,
						bunden er reserveret til grønne biler,
						i den øverste del er det kun lilla biler der er tilladt
						og andre farver skal parkere sammen med de grønne biler i bunden."
	completeLevel()

func _on_run_pressed() -> void:
	if canRun:
		canRun = false
		for car in nrCars:
			if await wait(1):
				spawnCar()
				if currentCar.color == optionSelected[0]:
					if !moveCar(0): # Up
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[1]:
					if !moveCar(2): # Right
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[2]:
					if !moveCar(3): # Down
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				else:
					if !moveCar(3): # Down
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
			else:
				break
