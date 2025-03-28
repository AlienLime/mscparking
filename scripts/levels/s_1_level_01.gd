extends BaseButtonLevel

@onready var intro: Control = $GUI/IngameGUIButtons/Intro


# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 1
	intro.visible = true
	
	# Initial text
	textbox = "Der er mange forskellige parkeringspladser med forskellige regler. 
				Vi starter med et par pladser, hvor der kun kommer røde og blå biler.
				
				(Tryk for at fortsætte)"
	introLabel = "Hej med dig. Velkommen til parkeringspladsen! Jeg hedder Hjælpe Jens, men du kan bare kalde mig for Jens.
			
			Din opgave er at vise bilerne hen til de rette pladser."
	
	# Car options
	carColors = [[0, 1], [0, 1], [0, 1], [0], [0], [1], [1]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	
	# Win conditions
	upCond = ["1_1_0"]
	downCond = ["0_1_0"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	# Click thorugh the intro to enable gameplay
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			intro.queue_free()
		if clicks == 2:
			textbox = "På den første plads er chefens instruktion:
						Hvis bilen er rød,
						  så skal den parkere øverst.
						Hvis bilen er blå, 
						  så skal den parkere nederst.
						
						Tryk på pilene for at få bilerne til at køre hen til de rigtige parkeringspladser."
			tips.push_back(textbox)
			disableUp = false
			disableDown = false
	
	# Show result after parking all cars
	if score == nrCars && !pop_up_complete.visible:
		pop_up_complete.win()
		disableCompleted = false


func _on_up_pressed() -> void:
	if parked < nrCars:
		if currentCar && currentCar.color == 1:
			textbox = "Rigtigt"
			moveCar(0)
		else:
			textbox = "FORKERT"

func _on_down_pressed() -> void:
	if parked < nrCars:
		if currentCar && currentCar.color == 0:
			textbox = "Rigtigt"
			moveCar(3)
		else:
			textbox = "FORKERT"
