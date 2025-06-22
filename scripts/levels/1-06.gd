extends BaseButtonLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 6
	
	# Car options
	carColors = [[0],[0],[1],[1],[0, 1],[0, 1],[0, 1],[0, 1],[0, 1],[0, 1]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	
	# Win conditions
	leftCond = ["1_0_0", "0_0_0"]
	rightCond = ["1_3_0", "0_3_0"]
	
	
	# Initial text
	textbox = "På den her parkeringsplads har chefen lavet andre regler:
					Ingen biler må krydse vejen.
					
					Prøv dig frem. Hvis du laver fejl, kan du bare trykke på genstart knappen for at prøve igen"
	tips.push_back("Er bilens farve vigtig for, hvor den skal parkere? Eller er det noget andet?")
	tips.push_back("Hvad betyder det at krydse vejen?")
	tips.push_back(textbox)
	
	# Enable gameplay
	disableLeft = false
	disableRight = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	completeLevel()
