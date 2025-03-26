extends BaseDropdownLevel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 9
	canRun = true
	pop_up_complete.visible = false
	
	# Car options
	usedColors = [0, 2, 3]
	carColors = [[2],[2],[2],[0],[0,3],[3],[2,0],[2,3],[2,0,3]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	nrCars = carColors.size()
	
	# Win conditions
	leftCond = ["0_3_0", "0_0_0", "3_3_0", "3_0_0"]
	rightCond = ["2_3_0", "2_0_0"]
	assign_conditions()
	
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til venstre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til venstre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til højre.")
	
	# Text
	textbox = "Nu skal de orange biler parkere til højre, mens de andre skal holde til venstre."
	tips.push_back("Du kan se hvilke farver biler, der kommer ved at udvide en af knapperne, hvor du vælger farverne.")
	tips.push_back("Husk at sørge for at alle de mulige farver er blevet valgt et sted.")
	tips.push_back(textbox)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Disable run if there is nothing selected
	for item in optionSelected:
		if item == -1:
			disableRun = true
			break
		else:
			disableRun = false
	
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
				moveCar(1) # Left
			elif currentCar.color == optionSelected[1]:
				moveCar(1) # Left
			elif currentCar.color == optionSelected[2]:
				moveCar(2) # Right
			else:
				textbox = "Det var en smutter. Du har ikke bestemt hvor denne farve bil skal hen. Tryk på genstart og prøv igen."
				break
