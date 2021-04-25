extends Control

func _on_TryAgain_pressed():
	get_tree().change_scene("res://MainScene/game.tscn")

func _on_BackMenu_pressed():
	get_tree().change_scene("res://MainMenu/MainMenu.tscn")
