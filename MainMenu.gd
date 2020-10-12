extends Control


func _ready():
	if Global.end == "pk":
		$Pk.set_visible(true)
	elif Global.end == "vsk":
		$Vsk.set_visible(true)
	elif Global.end == "timeout":
		$Timeout.set_visible(true)
	elif Global.end == "good":
		$Victory.set_visible(true)
	else:
		$Begin.set_visible(true)


func _on_Start_pressed():
	get_tree().change_scene("res://Main.tscn")
