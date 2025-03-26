extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 14
	canRun = true
	pop_up_complete.visible = false
	
	# Car options
	usedColors = [0, 1, 3, 4, 5]
	carColors = [[1],[1],[1],[1],[3],[3],[3],[3],[4],[4],[0,5],[0,5],[0,5],[1,3]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	nrCars = carColors.size()
	
	# Win conditions
	upCond = ["3_1_0"]
	rightCond = ["1_1_0"]
	downCond = ["0_1_0","4_1_0","5_1_0"]
	assign_conditions()
		
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
					sammen med de grønne"
	
	# Text
	textbox = "Godt gået! Nu prøver vi med den samme parkeringsplads men med en \"ellers\" instruks"
	tips.push_back("Rækkefølgen af reglerne er ikke nødvendigvis den samme som rækkefølgen af din instruks")
	tips.push_back("\"Ellers\" tager sig af alle farverne, som der ikke laves \"hvis\" instrukser til")
	tips.push_back("Røde biler skal parkere til højre,
						bunden er reserveret til grønne biler,
						i den øverste del er det kun lilla biler, der er tilladt,
						og andre farver skal parkere sammen med de grønne biler.")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Disable run if there is nothing selected
	for item in optionSelected:
		if item == -1:
			disableRun = true
			break
		else:
			disableRun = false
	
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			textbox = "Røde biler skal parkere til højre,
						bunden er reserveret til grønne biler,
						i den øverste del er det kun lilla biler der er tilladt
						og andre farver skal parkere sammen med de grønne biler."
	if parked == nrCars:
		if score == nrCars:
			pop_up_complete.visible = true
			disableCompleted = false
		else:
			textbox = "Hovsa. Der er nogle biler der er parkeret forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."

func _on_run_pressed() -> void:
	if canRun:
		canRun = false
		for car in nrCars:
			spawnCar()
			await wait(1)
			if currentCar.color == optionSelected[0]:
				moveCar(0) # Up
			elif currentCar.color == optionSelected[1]:
				moveCar(2) # Right
			elif currentCar.color == optionSelected[2]:
				moveCar(3) # Down
			else:
				moveCar(3)
