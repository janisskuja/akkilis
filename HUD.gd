extends Control

func _process(delta):
	$TimeLeft.text = "Time Left: " + String(int($Timer.time_left))
	$EnemiesRemaining.text = "Blood: " + String(Global.enemies) + "/16"
	
func _on_Timer_timeout():
	Global.game_over("timeout")
