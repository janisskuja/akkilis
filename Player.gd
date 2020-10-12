extends KinematicBody2D

# character walking code stolen from here: https://kidscancode.org/godot_recipes/2d/platform_character/
# animation state machine stolen from here: https://www.youtube.com/watch?v=CPDlaKWnQPM

export (int) var speed = 600
export (int) var jump_speed = -800
export (int) var gravity = 2000
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO
var playback

func _ready():
	playback = $AnimationTree.get("parameters/playback")
	playback.start("idle")
	
func get_input():
	var dir = 0
	if Input.is_action_pressed("walk_right"):
		dir += 1
		if playback.is_playing():
			playback.travel("walk_right")
	if Input.is_action_pressed("walk_left"):
		dir -= 1
		if playback.is_playing():
			playback.travel("walk_left")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if playback.is_playing():
			playback.travel("idle")
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		if playback.is_playing():
			playback.travel("jump")
		velocity.y = jump_speed
	
	if Input.is_action_just_pressed("attack") && playback.is_playing():
			playback.travel("attack")
		
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
