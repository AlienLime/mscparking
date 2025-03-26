extends BaseDropdownLevel

@onready var intro: Control = $GUI/IngameGUIDropdown/Intro

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 10
	canRun = true
	pop_up_complete.visible = false
	
	# Car options
	usedColors = [0, 1, 2, 3, 4, 5]
	carColors = [[0],[0],[0],[1],[1],[1],[2],[2],[1, 2],[0, 2, 3, 4, 5],[0, 3, 4, 5],[1, 3, 4, 5],[3, 4, 5],[3, 4, 5]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = [0]
	nrCars = carColors.size()
	
	# Win conditions
	upCond = ["0_3_0"]
	leftCond = ["0_3_0","1_3_0","2_3_0","3_3_0","4_3_0","5_3_0"]
	rightCond = ["2_3_0"]
	downCond = ["1_3_0"]
	assign_conditions()
	
	# Select if dropdowns to use
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere øverst.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere til højre.")
	
	ifArray.push_back("colorIf")
	ifLabel.push_back("Hvis bilen er ")
	thenLabel.push_back("så skal den parkere nederst.")
	
	elseVisible = true
	elseLabel = "Ellers skal den parkere til venstre"
	
	# Text
	textbox = "Her skal blå biler parkere på de øverste pladser, alle røde biler skal parkere til nederst og de orange biler skal parkere til højre."
	tips.push_back("Har du tænkt over hvad der skal ske med de lilla, grønne og gule biler?")
	tips.push_back("Du kan prøve banen et par gange og se hvad der sker når du vælger forskellige farver.")
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
	
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			intro.visible = false
			intro.z_index = -1
	if parked == nrCars:
		if score == nrCars:
			pop_up_complete.visible = true
			disableCompleted = false
		else:
			helper = "Hovsa. Der er nogle biler der er parkeret forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."

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
				moveCar(1) # Left
