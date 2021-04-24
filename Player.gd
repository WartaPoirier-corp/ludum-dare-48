extends RigidBody2D

var speed = 300

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > 200:
		position.x = 200
		position.y = -100

func _input(evt):
	if evt.is_action_pressed("jump"):
		if len(get_colliding_bodies()) > 0:
			apply_impulse(Vector2(), Vector2(0, -9000))

func _physics_process(delta):
	var vel = get_linear_velocity()
	if Input.is_action_pressed("move_right"):
		set_linear_velocity(Vector2(speed, vel.y))
		$Sprite.flip_h = false
	if Input.is_action_pressed("move_left"):
		set_linear_velocity(Vector2(-speed, vel.y))
		$Sprite.flip_h = true

func _integrate_forces(state):
	rotation_degrees = 0

func enter_coffee_mode():
	$Sprite.fps = 80
