extends AudioStreamPlayer

var np = "";
var manque_level = 1

func reset():
	manque_level = 1
	volume_db = 1

func chill():
	var level = min(manque_level, 4)
	stream = load("res://Music/chill%d.ogg" % level)
	np = "chill%d" % level
	play()
	
func drog(manque):
	np = "drog"
	manque_level = manque
	stream = load("res://Music/drog.ogg")
	play()

func _on_Music_finished():
	if np == "drog":
		chill()
