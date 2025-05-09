extends BaseButtonLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 5
	disableTips = false
	disableUp = false
	disableDown = false
	
	# Car options
	carColors = [[0, 1], [0, 1], [0, 1], [0], [0], [1], [1]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	
	# Text
	textbox = "Her skal de øverste pladser fyldes inden du løber tør for biler.
	
				Husk at du kan trykke på mig hvis du får brug for et tip."
	tips.push_back("Hvis du ikke fylder toppen ud kan du trykke på fortryd knappen eller genstart knappen og prøve igen.")
	tips.push_back("Der kommer " + str(nrCars) + " biler i alt. Er der så nok biler tilbage?")
	tips.push_back(textbox)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	# Show result after parking all cars
	if parked == nrCars && !pop_up_complete.visible:
		var fullTop = true
		for spot in parking.get_node("Up").get_children():
				if spot.isFree:
					fullTop = false
					break
		if fullTop:
			pop_up_complete.win()
			disableCompleted = false
		else:
			pop_up_complete.lose("Du har ikke fyldt de øverste pladser og der er ikke flere biler.")
			disableCompleted = false
