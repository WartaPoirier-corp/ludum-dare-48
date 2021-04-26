extends Control

func _ready():
	MusicPlayer.reset()
	if not MusicPlayer.playing || MusicPlayer.np != "chill1":
		MusicPlayer.chill()

func _on_Button_pressed():
	get_tree().change_scene("res://MainScene/game.tscn")
