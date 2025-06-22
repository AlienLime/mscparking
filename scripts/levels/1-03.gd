extends BaseButtonLevel
@onready var arrow: Sprite2D = $GUI/IngameGUIButtons/Arrow

# Called when the node enters the scene tree for the first time.
func setup() -> void:
	# Level setup
	level = 3
	arrow.visible = true
	
	# Initial text
	textbox = "Hvis du har brug for lidt hjælp, kan du altid trykke på lille mig, så prøver jeg at give et godt tip."
	tips.push_back("Nu synes chefen at:
				Hvis bilen er rød,
				  så skal den parkere nederst.
				Hvis bilen er blå, 
				  så skal den parkere øverst.")
	tips.push_back("Selvom det er samme plads som første bane, så er der andre regler. Sørg for at læse dem grundigt.
	
					Tryk på mig igen for at se reglerne.")
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
	
	if tipCounter == 2:
		arrow.visible = false
		disableUp = false
		disableDown = false
			
	completeLevel()
