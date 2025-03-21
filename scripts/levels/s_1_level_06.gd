extends BaseButtonLevel

#Level specific constants


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 6
	pop_up_complete.visible = false
	
	# Initial text
	textbox = "Chefen vil nu gerne have at:
					Blå, orange og grønne biler skal parkere til venstre.
					Røde, lilla og gule biler skal parkere til højre."
	helper = "Tryk på pilene for at vise bilerne hen til de korrekte pladser."
	
	# Car options
	carColors = [[0],[3],[4],[2],[5],[1],[0, 2, 4],[1, 3, 5],[0, 1, 2, 3, 4, 5],[0, 1, 2, 3, 4, 5]]
	carOrigins = [[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3]]
	carShapes = 0
	nrCars = carColors.size()
	
	# Win conditions
	leftCond = ["0_0_0", "0_3_0", "2_0_0", "2_3_0", "4_0_0", "4_3_0"]
	rightCond = ["1_0_0", "1_3_0", "3_0_0", "3_3_0", "5_0_0", "5_3_0"]
	assign_conditions()
	
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
