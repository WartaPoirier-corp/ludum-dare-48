extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_caffeine_level(level):
	var right = $CoffeeBar/Fill.margin_right
	var left = $CoffeeBar.rect_size.x
	$CoffeeBar/Fill.margin_left = right - (level * left / 100.0)

func show_message():
	$AnimationPlayer.play("text_popup")
