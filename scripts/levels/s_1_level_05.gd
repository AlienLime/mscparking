extends BaseButtonLevel

#Level specific constants


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Level setup
	level = 5
	pop_up_complete.visible = false
	
	# Initial text
	textbox = "Lad os se på nogle biler med andre farver.
	
				Chefen vil have de orange biler øverst her."
	helper = ""
	tips.push_back("Hvis de orange biler skal holde øverst er det en god ide at parkere de lilla biler nederst.")
	
	# Car options
	carColors = [[2],[2],[2],[2],[3],[3],[3],[3],[2, 3],[2, 3]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[3],[0, 3],[0, 3]]
	carShapes = 0
	nrCars = carColors.size()
	
	# Win conditions
	upCond = ["2_0_0", "2_3_0","3_0_0", "3_3_0"]
	downCond = ["3_0_0", "3_3_0"]
	assign_conditions()
	
	# Enable gameplay
	disableUp = false
	disableDown = false
	
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
