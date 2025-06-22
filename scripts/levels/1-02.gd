extends BaseButtonLevel

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 2
	
	# Car options
	carColors = [[0],[0],[0],[0],[0],[1],[1],[1],[1],[1],[0, 1]] #0=Blue 1=Red 2=Orange 3=Purple 4=Green 5=Yellow
	carOrigins = [[0],[0],[0],[0],[3],[3],[3],[3],[0, 3],[0, 3],[0, 3]] #0=Up 1=Left 2=Right 3=Down
	carShapes = 0
	
	# Win conditions
	upCond = ["0_0_0", "0_3_0", "1_0_0", "1_3_0"]
	downCond = ["1_0_0", "1_3_0"]
	
	# Text
	textbox = "Lad os se på en anden parkeringsplads.
	
				Chefen vil have de blå biler øverst her."
	tips.push_back("Hvis de blå biler skal holde øverst, er der så også plads til at parkere de røde biler øverst?")
	tips.push_back("Selvom de blå skal holde øverst må de røde også gerne holde der. Bare der er plads til alle de blå.")
	tips.push_back("Chefen vil have de blå biler øverst her.")
	
	# Enable gameplay
	disableUp = false
	disableDown = false

func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	completeLevel()
