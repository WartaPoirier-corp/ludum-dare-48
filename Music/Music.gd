extends AudioStreamPlayer

var music_pos = 0.0;
var np = "";

func chill():
	np = "chill"
	stream = load("res://Music/chill.ogg")
	print(music_pos)
	print(floor(85.0 / 60.0 * music_pos))
	stop()
	play(floor(85.0 / 60.0 * music_pos))
	
func drog():
	np = "drog"
	music_pos = MusicPlayer.get_playback_position()
	stream = load("res://Music/drog.ogg")
	play()

func _on_Music_finished():
	if np == "drog":
		chill()
