extends BaseButtonLevel

#Level specific constants


# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 5
	
	# Car options
	carColors = [[2],[2],[2],[2],[3],[3],[3],[3],[2, 3],[2, 3]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	
	# Win conditions
	upCond = ["2_0_0", "2_3_0", "3_0_0", "3_3_0"]
	downCond = ["3_0_0", "3_3_0"]
	
	# Initial text
	textbox = "Lad os se på nogle biler med andre farver.
	
				Chefen vil have de orange biler øverst her."
	tips.push_back("Hvis de orange biler skal holde øverst, er der så også plads til at parkere de lilla biler øverst?")
	tips.push_back("Chefen vil have de orange biler øverst her.")
	
	# Enable gameplay
	disableUp = false
	disableDown = false

func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	# Show result after parking all cars
	if parked == nrCars:
		if score == nrCars:
			pop_up_complete.visible = true
			disableCompleted = false
		else:
			textbox = "Hovsa. Der er nogle biler der er parkeret forkert. Prøv igen ved at trykke på genstart i toppen af skærmen."
