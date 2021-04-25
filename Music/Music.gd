extends AudioStreamPlayer

# var music_pos = 0.0;
var np = "";
var manque_level = 1

func reset():
	manque_level = 1

func chill():
	np = "chill"
	var level = min(manque_level, 4)
	stream = load("res://Music/chill%d.ogg" % level)
	#stop()
	#play(floor(85.0 / 60.0 * music_pos))
	play()
	
func drog(manque):
	np = "drog"
	manque_level = manque
	#music_pos = MusicPlayer.get_playback_position()
	stream = load("res://Music/drog.ogg")
	play()

func _on_Music_finished():
	if np == "drog":
		chill()
