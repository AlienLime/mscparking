extends BaseButtonLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 3
	
	# Car options
	carColors = [[0, 1], [0, 1], [0, 1], [0], [0], [1], [1]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	
	# Initial text
	textbox = "Vi bliver ved lidt endnu."
	tips.push_back("Der kommer " + str(nrCars) + " biler i alt. Er der så nok biler tilbage?")
	tips.push_back("Her skal de øverste pladser fyldes inden du løber tør for biler.
			
						Husk at du stadig skal finde plads til alle bilerne.")
	# Win conditions [color, origin, shape]
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			textbox = "Her skal de øverste pladser fyldes inden du løber tør for biler.
			
						Husk at du stadig skal finde plads til alle bilerne."
			disableUp = false
			disableDown = false
			tips.push_back("Hvis du ikke fylder toppen ud kan du trykke på fortryd knappen eller genstart knappen og prøve igen.")
			tips.push_back(textbox)
	
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
			pop_up_complete.lose()
