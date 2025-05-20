extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 13
	
	# Car options
	usedColors = [0, 1, 2]
	carColors = [[0],[0],[0],[1],[1],[1],[1],[2],[2],[2],[2],[2],[2],[1, 2],[0, 2],[0, 2]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	upCond = ["0_3_0"]
	leftCond = ["2_3_0"]
	rightCond = ["2_3_0"]
	downCond = ["1_3_0"]
	
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere øverst.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til venstre 
						eller til højre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere nederst.")
	
	# Text
	textbox = "Her skal blå biler parkere på de øverste pladser, alle røde biler skal parkere nederst, og de orange biler skal parkere til venstre eller til højre."
	tips.push_back("Instruksen står ikke i samme rækkefølge som chefens regler.")
	tips.push_back("Du kan prøve banen et par gange og se, hvad der sker, når du vælger forskellige farver.")
	tips.push_back(textbox)

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
						if !moveCar(2): # Right if left was not possible
							pop_up_complete.lose("Der er ikke plads til bilen, hvis den skal følge dine instruktioner.")
							break
				elif currentCar.color == optionSelected[2]:
					if !moveCar(3): # Down
						pop_up_complete.lose("Der er ikke plads til bilen, hvis den skal følge dine instruktioner.")
						break
				
			else:
				break
