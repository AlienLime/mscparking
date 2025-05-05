extends Node

var USERID = ""

func _ready():
	var save_path = "user://USERID.txt"
	var file = FileAccess.open(save_path, FileAccess.READ)

	if file:
		USERID = file.get_line()
		file.close()
	else:
		# Generate and save a new device ID
		USERID = generate_unique_id()
		var f = FileAccess.open(save_path, FileAccess.WRITE)
		f.store_line(USERID)
		f.close()

func generate_unique_id() -> String:
	randomize()
	var uuid = str(randi_range(10000000, 99999999))
	return uuid
