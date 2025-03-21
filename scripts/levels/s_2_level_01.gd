extends BaseButtonLevel

#Level specific constants


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 1
	pop_up_complete.visible = false
	
	# Initial text
	textbox = "På den her parkeringsplads har chefen lavet andre regler:
					Ingen biler må krydse vejen.
					
					Prøv dig frem. Hvis du laver fejl kan du bare trykke på genstart knappen for at prøve igen"
	helper = "Tryk på pilene for at vise bilerne hen til de korrekte pladser."
	
	# Car options
	carColors = [[0],[0],[1],[1],[0, 1],[0, 1],[0, 1],[0, 1],[0, 1],[0, 1]]
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[3],[0, 3],[0, 3]]
	carShapes = 0
	nrCars = carColors.size()
	
	# Win conditions
	leftCond = ["1_0_0", "0_0_0"]
	rightCond = ["1_3_0", "0_3_0"]
	for parking_spot in parking.get_node("Right").get_children():
		parking_spot.conditions = rightCond
	for parking_spot in parking.get_node("Left").get_children():
		parking_spot.conditions = leftCond
	
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
			helper = "Hovsa. Der er nogle biler der parkerede forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."
