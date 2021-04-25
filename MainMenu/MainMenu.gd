extends Control

func _ready():
	if not MusicPlayer.playing:
		MusicPlayer.chill()

func _on_Button_pressed():
	get_tree().change_scene("res://MainScene/game.tscn")
