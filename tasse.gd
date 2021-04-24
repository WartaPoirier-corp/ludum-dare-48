extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var speed = 10
var up = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > 0 and up:
		position.y -= delta * speed
	elif position.y < 20 and not up:
		position.y += delta * speed
	else:
		up = not up
