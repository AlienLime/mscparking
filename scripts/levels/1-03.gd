extends BaseButtonLevel
@onready var arrow: Sprite2D = $GUI/IngameGUIButtons/Arrow

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 3
	disableTips = true
	
	# Initial text
	textbox = "Det var godt gået.
				Nu skal vi prøve den første plads igen men med andre regler."
	
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
			disableTips = false
			arrow.visible = true
			textbox = "Hvis du har brug for lidt hjælp, kan du altid trykke på lille mig, så prøver jeg at give et godt tip."
			tips.push_back("Nu synes chefen at:
				Hvis bilen er rød,
				  så skal den parkere nederst.
				Hvis bilen er blå, 
				  så skal den parkere øverst.")
			tips.push_back("Tryk på pilene for at få bilerne til at køre hen til de rigtige parkeringspladser.
			
							Tryk på mig igen for at se pladsens regler.")
		if clicks >= 2 && tipCounter > 0:
			arrow.visible = false
			disableUp = false
			disableDown = false
			
	
	# Show result after parking all cars
	if score == nrCars && !pop_up_complete.visible:
		pop_up_complete.win()
		disableCompleted = false


func _on_up_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Up")
	if parked < nrCars:
		if currentCar && currentCar.color == 0:
			textbox = "Det var rigtigt"
			moveCar(0)
		else:
			textbox = "Forkert pil"
			print(Globals.USERID + "," + stopwatch.time_to_string() + ",Action denied,Move")

func _on_down_pressed() -> void:
	print(Globals.USERID + "," + stopwatch.time_to_string() + ",Button press,Down")
	if parked < nrCars:
		if currentCar && currentCar.color == 1:
			textbox = "Det var rigtigt"
			moveCar(3)
		else:
			textbox = "Forkert pil"
			print(Globals.USERID + "," + stopwatch.time_to_string() + ",Action denied,Move")
