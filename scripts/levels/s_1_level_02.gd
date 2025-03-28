extends BaseButtonLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 2
	
	# Initial text
	textbox = "Det var godt gået.
				Nu skal vi prøve den samme plads men med andre regler."
	
	# Car options
	carColors = [[0, 1], [0, 1], [0, 1], [0], [0], [1], [1]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	
	# Win conditions [color, origin, shape]
	upCond = ["0_1_0"]
	downCond = ["1_1_0"]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			textbox = "Nu synes chefen at:
						Hvis bilen er rød,
						  så skal den parkere nederst.
						Hvis bilen er blå, 
						  så skal den parkere øverst."
			disableUp = false
			disableDown = false
			tips.push_back("Tryk på pilene for at få bilerne til at køre hen til de rigtige parkeringspladser.")
			tips.push_back(textbox)
	
	# Show result after parking all cars
	if score == nrCars:
		pop_up_complete.visible = true
		disableCompleted = false


func _on_up_pressed() -> void:
	if parked < nrCars:
		if currentCar && currentCar.color == 0:
			textbox = "Rigtigt"
			moveCar(0)
		else:
			textbox = "FORKERT"


func _on_down_pressed() -> void:
	if parked < nrCars:
		if currentCar && currentCar.color == 1:
			textbox = "Rigtigt"
			moveCar(3)
		else:
			textbox = "FORKERT"
