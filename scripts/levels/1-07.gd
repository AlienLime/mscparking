extends BaseButtonLevel
@onready var intro: Control = $GUI/IngameGUIButtons/Intro


# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 7
	intro.visible = true
	disableTips = true
	
	# Text
	introLabel = "Chefen har fundet på en ny måde at lave regler på. 
	
			Nu er parkeringspladserne farvet efter, hvilke biler der må parkere på dem.
			
			Din opgave er stadig at vise bilerne hen til de rette pladser.
			
			(Tryk for at fortsætte)"
	textbox = ""
	tips.push_back("Tryk på pilene for at få bilerne til at køre hen til de rigtige parkeringspladser.")
	
	# Car options
	carColors = [[0, 1], [0, 1, 2], [0], [0], [1], [1], [1], [2]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[1],[1],[1],[1],[1],[1],[1],[1],[1]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	
	# Win conditions
	upCond = ["1_1_0"]
	downCond = ["0_1_0","2_1_0"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	# Click thorugh the intro to enable gameplay
	if Input.is_action_just_pressed("mouse"):
		clicks += 1
		if clicks == 1:
			intro.visible = false
			disableTips = false
			disableUp = false
			disableDown = false

	completeLevel()
