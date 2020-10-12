extends Node2D


var Enemy:PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
	Enemy = load("res://Enemy.tscn")

func _on_EnemySpawnTimer_timeout():
	randomize()
	var idx = randi() % 5 + 1
	var enemy = Enemy.instance()
	enemy.position = get_node("Enemies/Spawn" + String(idx)).position
	$Enemies.add_child(enemy)
	 

func _on_AkkilisBox_area_entered(area):
	if area.is_in_group("PlayerAttackBox"):
		Global.game_over("pk")
	else:
		Global.game_over("vsk")
