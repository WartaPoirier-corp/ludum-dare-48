extends Control

func _ready():
	if not MusicPlayer.playing || MusicPlayer.np != "chill":
		MusicPlayer.chill()
	MusicPlayer.reset()

func _on_Button_pressed():
	get_tree().change_scene("res://MainScene/game.tscn")
