extends KinematicBody2D


export (int) var speed = 100
export (int) var jump_speed = -800
export (int) var gravity = 2000
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var dead = false
var jump = false

var dir = 1
var velocity = Vector2.ZERO
var playback

func _ready():
	playback = $AnimationTree.get("parameters/playback")
	playback.start("walk_left")

func _process(delta):
	if playback.is_playing():
		if dead:
			playback.travel("dead")
		elif dir == 1:
			playback.travel("walk_right")
		elif dir == -1:
			playback.travel("walk_left")
		
	
func _physics_process(delta):
	if dead:
		dir = 0
		
	if jump && is_on_floor():
		jump = false
		velocity.y = jump_speed

	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)


func _on_platform_check_body_entered(body):
	if !dead && is_on_floor():
		dir *= -1

func _on_platform_check_area_entered(area):
	if area.is_in_group("jump"):
		jump = true

func _on_HurtBox_area_entered(area):
	if !area.is_in_group("EnemyBox"):
		dead = true
		Global.enemies += 1

func _on_Timer_timeout():
	if !dead && is_on_floor():
		dir *= -1
