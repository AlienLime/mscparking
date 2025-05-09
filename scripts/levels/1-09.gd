extends BaseButtonLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 9
	
	# Car options
	carColors = [[0],[1],[2],[2],[3],[3],[4],[5],[0, 5],[0, 5],[1, 4],[1, 4],[2, 3],[2, 3],[0, 1, 2, 4, 5]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3],[3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	
	# Win conditions
	upCond = ["2_3_0"]
	leftCond = ["0_3_0", "5_3_0"]
	rightCond = ["3_3_0"]
	downCond = ["1_3_0", "4_3_0"]
	
	# Text
	textbox = "Instruktionerne er givet med farverne på pladserne."
	tips.push_back("Match farverne på parkeringspladserne med bilernes farver.")
	tips.push_back("Flere farver på en plads betyder at der må holde flere forskellige farver biler.")
	tips.push_back(textbox)
	
	# Enable gameplay
	disableUp = false
	disableLeft = false
	disableRight = false
	disableDown = false

func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	completeLevel()
