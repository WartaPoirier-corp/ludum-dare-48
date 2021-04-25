extends KinematicBody2D

var gravity = 400.0
var velocity = Vector2()
var speed = 300
var manque_level = 0
var is_jumping = false

func _ready():
	MusicPlayer.pitch_scale = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > 200:
		get_tree().change_scene("res://GameOver/GameOver.tscn")
	get_parent().get_node("CanvasLayer/HUD").set_caffeine_level($CoffeeTimer.time_left * 100 / 15)
	if is_jumping and is_on_floor():
		is_jumping = false
	

func _input(evt):
	if evt.is_action_pressed("jump") and not is_jumping and is_on_floor():
		is_jumping = true
		velocity.y = -400

func _physics_process(delta):
	var running = false
	var s = speed

	velocity.y += delta * gravity
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed;
		if $Sprite.animation != "run":
			$Sprite.animation = "run"
		$Sprite.flip_h = false
		running = true
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed;
		if $Sprite.animation != "run":		
			$Sprite.animation = "run"
		$Sprite.flip_h = true
		running = true
	
	if not is_on_floor():
		velocity.x /= 1.5
	
	if not running and $Sprite.animation != "drink":
		$Sprite.animation = "default"
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var col = get_slide_collision(i).collider
		if col.name == "TasseCollider":
			col.get_parent().queue_free()
			$Sprite.animation = "drink"
			enter_coffee_mode()
		if col.name == "PikCol":
			get_tree().change_scene("res://GameOver/GameOver.tscn")

func _integrate_forces(state):
	rotation_degrees = 0

func enter_coffee_mode():
	$CoffeeTimer.start(15)
	$Sprite.speed_scale = 10
	MusicPlayer.drog()
	gravity /= 1.5
	speed = 600
	get_parent().get_node("CanvasLayer/HUD").show_message()

func _on_CoffeeTimer_timeout():
	manque_level += 1
	$CoffeeTimer.stop()
	$Sprite.speed_scale = 1 - (0.05 * manque_level)
	MusicPlayer.pitch_scale = 1 - (0.05 * manque_level)
	gravity = 400.0 + (20 * manque_level)
	speed = 300 - (manque_level * 20)

func _on_Sprite_animation_finished():
	if $Sprite.animation == "drink":
		$Sprite.animation = "default"

