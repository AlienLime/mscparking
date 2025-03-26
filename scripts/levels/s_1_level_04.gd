extends BaseButtonLevel

#Level specific constants


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 4
	pop_up_complete.visible = false
	
	# Car options
	carColors = [[0],[0],[1],[1],[0, 1],[0, 1],[0, 1],[0, 1],[0, 1],[0, 1]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	nrCars = carColors.size()
	
	# Win conditions
	leftCond = ["1_0_0", "0_0_0"]
	rightCond = ["1_3_0", "0_3_0"]
	assign_conditions()
	
	# Initial text
	textbox = "På den her parkeringsplads har chefen lavet andre regler:
					Ingen biler må krydse vejen.
					
					Prøv dig frem. Hvis du laver fejl kan du bare trykke på genstart knappen for at prøve igen"
	tips.push_back("Hvad betyder det at krydse vejen?")
	tips.push_back("Er bilens farve vigtig for, hvor den skal parkere? Eller er det noget andet?")
	tips.push_back(textbox)
	helper = "Tryk på pilene for at vise bilerne hen til de korrekte pladser."
	
	# Enable gameplay
	disableLeft = false
	disableRight = false
	
	spawnCar()

func _process(delta: float) -> void:
	
	# Show result after parking all cars
	if parked == nrCars:
		if score == nrCars:
			pop_up_complete.visible = true
			disableCompleted = false
			helper = ""
		else:
			helper = "Hovsa. Der er nogle biler der er parkeret forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."
