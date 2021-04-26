extends KinematicBody2D

var gravity = 380.0
var velocity = Vector2()
var speed = 300
var manque_level = 0
var is_jumping = false
var drog = false

func animation(base, bad):
	var anim = base
	if manque_level > 2:
		anim = bad
		
	if $Sprite.animation != anim:
		$Sprite.animation = anim

func run_animation():
	animation("run", "run_bad")
	
func drink_animation():
	animation("drink", "drink")

func default_animation():
	animation("default", "default_bad")

func _ready():
	MusicPlayer.reset()
	if not MusicPlayer.playing || MusicPlayer.np != "chill1":
		MusicPlayer.chill()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > 200:
		get_tree().change_scene("res://GameOver/GameOver.tscn")
	get_parent().get_node("CanvasLayer/HUD").set_caffeine_level($CoffeeTimer.time_left * 100 / 15)
	if is_jumping and is_on_floor():
		is_jumping = false
		
	var mood_mat = get_parent().get_node("CanvasLayer2/Mood").material
	var current_mood = mood_mat.get_shader_param("mood")
	if current_mood > 0.5 - (0.05 * manque_level) and not drog:
		var new_mood = current_mood - (delta / 4)
		mood_mat.set_shader_param("mood", max(0.5 - (0.05 * manque_level), new_mood))
	

func _input(evt):
	if evt.is_action_pressed("jump") and not is_jumping and is_on_floor():
		is_jumping = true
		velocity.y = -400

func _physics_process(delta):
	var running = false

	velocity.y += delta * gravity
	velocity.x = 0
	if Input.is_action_pressed("move_right"):
		velocity.x += speed;
		$Sprite.flip_h = false
		run_animation()
		running = true
	if Input.is_action_pressed("move_left"):
		velocity.x -= speed;
		run_animation()
		$Sprite.flip_h = true
		running = true
	
	if not is_on_floor():
		velocity.x /= 1.5
	
	if not running and $Sprite.animation != "drink":
		default_animation()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for i in get_slide_count():
		var col = get_slide_collision(i).collider
		if col.name == "TasseCollider":
			col.get_parent().depop()
			drink_animation()
			enter_coffee_mode()
		if col.name == "PikCol":
			get_tree().change_scene("res://GameOver/GameOver.tscn")
		if col.name == "Drapo":
			get_tree().change_scene("res://Win/Win.tscn")

func enter_coffee_mode():
	$CoffeeTimer.stop()
	$CoffeeTimer.start(15)
	$Sprite.speed_scale = 10
	MusicPlayer.drog(manque_level + 1)
	gravity /= 1.5
	speed = 600
	get_parent().get_node("CanvasLayer/HUD").show_message()
	get_parent().get_node("CanvasLayer2/Mood").material.set_shader_param("mood", 0.75)
	var blur_mat = get_parent().get_node("CanvasLayer2/Mood/Blur").material
	var blur = blur_mat.get_shader_param("sharp_radius")
	blur_mat.set_shader_param("sharp_radius", blur - 0.05)
	drog = true

func _on_CoffeeTimer_timeout():
	drog = false
	manque_level += 1
	$CoffeeTimer.stop()
	$Sprite.speed_scale = 1 - (0.05 * manque_level)
	gravity = 380.0 + (10 * manque_level)
	speed = 300 - (manque_level * 20)

func _on_Sprite_animation_finished():
	if $Sprite.animation == "drink":
		$Sprite.animation = "default"

