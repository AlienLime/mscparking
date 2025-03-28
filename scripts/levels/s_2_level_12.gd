extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 18
	
	# Car options
	usedColors = [0, 1, 2, 3, 4, 5]
	carColors = [[0],[5],[0, 5],[0, 5],[3],[3],[3],[1, 3, 4],[1, 2, 4],[1, 2, 4],[1, 2, 4],[1, 2, 4],[1, 2, 4],[1, 2, 4],[1, 2, 4],[1, 2, 4]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	
	# Win conditions
	usedDirections = [0,1,2,3]
	upCond = ["0_3_0","5_3_0"]
	leftCond = ["1_3_0","2_3_0","4_3_0"]
	rightCond = ["1_3_0","2_3_0","4_3_0"]
	downCond = ["3_3_0"]
	
	# Select if dropdowns to use
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	ifArray.push_back("colorIfThen")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere ")
	
	elseVisible = true
	elseLabel = "Ellers skal den parkere til 
				venstre eller højre"
	
	# Text
	textbox = "Her skal blå og de gule biler parkere på de øverste pladser, og de lilla biler skal parkere nederst."
	tips.push_back("Prøv at gennemgå hver enkelt regel i beskrivelsen. Så kan du lave dem en ad gangen nedenunder.")
	tips.push_back("Husk at der er en \"ellers\" til sidst, så hav fokus på de biler, der ikke skal til venstre eller højre.")
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
				elif currentCar.color == optionSelected[4]:
					if !moveCar(optionSelected[5]):
						pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
						break
				else:
					if !moveCar(1): # Left
						if !moveCar(2): # Right if left was not possible
							pop_up_complete.lose("Der er ikke plads til bilen hvis den skal følge dine instruktioner.")
							break
			else:
				break
