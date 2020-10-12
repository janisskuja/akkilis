extends Node

var enemies = 0
var end = null

func _process(delta):
	if enemies == 16:
		game_over("good")

func game_over(ending):
	end = ending
	enemies = 0
	get_tree().change_scene("res://MainMenu.tscn")
