extends RigidBody2D

var speed = 300

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicPlayer.stream = load("res://Music/chill.ogg")
	MusicPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > 200:
		get_tree().change_scene("res://GameOver/GameOver.tscn")
	for col in get_colliding_bodies():
		if col.name == "TasseCollider":
			col.get_parent().queue_free()
			$Sprite.animation = "drink"
			enter_coffee_mode()
	$HUD.set_caffeine_level($CoffeeTimer.time_left * 100 / 15)
	

func _input(evt):
	if evt.is_action_pressed("jump"):
		if len(get_colliding_bodies()) > 0:
			apply_impulse(Vector2(), Vector2(0, -9000))

func _physics_process(delta):
	var vel = get_linear_velocity()
	var running = false
	var s = speed
	if len(get_colliding_bodies()) == 0:
		s = s / 2
	if Input.is_action_pressed("move_right"):
		set_linear_velocity(Vector2(s, vel.y))
		if $Sprite.animation != "run":
			$Sprite.animation = "run"
		$Sprite.flip_h = false
		running = true
	if Input.is_action_pressed("move_left"):
		set_linear_velocity(Vector2(-s, vel.y))
		if $Sprite.animation != "run":		
			$Sprite.animation = "run"
		$Sprite.flip_h = true
		running = true
	if not running and $Sprite.animation != "drink":
		$Sprite.animation = "default"

func _integrate_forces(state):
	rotation_degrees = 0

func enter_coffee_mode():
	$CoffeeTimer.start(15)
	$Sprite.speed_scale = 10
	MusicPlayer.pitch_scale *= 3
	gravity_scale = 1
	speed = 600
	$HUD.show_message()

func _on_CoffeeTimer_timeout():
	$CoffeeTimer.stop()
	$Sprite.speed_scale = 1
	MusicPlayer.pitch_scale /= 3
	gravity_scale = 2
	speed = 300

func _on_Sprite_animation_finished():
	if $Sprite.animation == "drink":
		$Sprite.animation = "default"

