extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 15
	
	# Car options
	usedColors = [0, 1, 3, 4, 5]
	carColors = [[1],[1],[1,4],[4],[4],[3],[3],[3],[0],[5],[0,5],[0,5],[0,5],[0,5],[0,5]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	upCond = ["0_1_0","5_1_0"]
	rightCond = ["1_1_0","4_1_0"]
	downCond = ["0_1_0","3_1_0","5_1_0"]
		
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere højre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til nedad.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere højre.")
	
	elseVisible = true
	elseLabel = "Ellers må den parkere 
					på ikke reserverede pladser"
	
	# Text
	textbox = "Imponerende. Nu er chefens \"ellers\" instruks mindre streng."
	tips.push_back("Der er forskel på, at en plads er reserveret, og at en bil skal parkere et bestemt sted.")
	tips.push_back("Rækkefølgen af reglerne er ikke nødvendigvis den samme som rækkefølgen i din instruktion.")
	tips.push_back("Højre side er reserveret til røde og grønne biler,
						lilla biler skal parkere i bunden,
						og andre farver må parkere på de plader, der ikke er reserverede.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	disableRun = checkRun()
	
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			textbox = "Højre side er reserveret til røde og grønne biler,
						lilla biler skal parkere i bunden
						og andre farver må parkere på de plader der ikke er reserverede."
	completeLevel()

func _on_run_pressed() -> void:
	var movement
	if canRun:
		canRun = false
		for car in nrCars:
			if await wait(1):
				spawnCar()
				if currentCar.color == optionSelected[0]:
					if !moveCar(2): # Right
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[1]:
					if !moveCar(3): # Down
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				elif currentCar.color == optionSelected[2]:
					if !moveCar(2): # Right
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				else:
					if !moveCar(0):
						if !moveCar(3):
							pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
							break
			else:
				break
