extends BaseButtonLevel

#Level specific constants


# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 8
	
	# Car options
	carColors = [[0],[3],[4],[2],[5],[1],[0, 2, 4],[1, 3, 5],[0, 1, 2, 3, 4, 5],[0, 1, 2, 3, 4, 5]]
	carOrigins = [[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3],[0, 3]]
	carShapes = 0
	
	# Win conditions
	leftCond = ["0_0_0", "0_3_0", "2_0_0", "2_3_0", "4_0_0", "4_3_0"]
	rightCond = ["1_0_0", "1_3_0", "3_0_0", "3_3_0", "5_0_0", "5_3_0"]
	
	# Text
	textbox = "Chefen vil nu gerne have at:
					Blå, orange og grønne biler skal parkere til venstre.
					Røde, lilla og gule biler skal parkere til højre."
	tips.push_back("Du behøver ikke huske alle reglerne. Du kan altid kigge på dem igen, når der kommer en ny bil.")
	tips.push_back(textbox)
	
	# Enable gameplay
	disableLeft = false
	disableRight = false


func _process(delta: float) -> void:
	# Logging 
	stopwatch.update(delta)
	
	completeLevel()
