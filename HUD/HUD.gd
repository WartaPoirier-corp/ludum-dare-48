extends Control

var start_time

func _ready():
	start_time = OS.get_ticks_msec()

func _process(delta):
	var ellapsed = (OS.get_ticks_msec() / 1000.0) - (start_time / 1000.0)
	$Timer.text = "%.3fs" % ellapsed
	Global.time = ellapsed

func set_caffeine_level(level):
	var right = $CoffeeBar/Fill.margin_right
	var left = $CoffeeBar.rect_size.x
	$CoffeeBar/Fill.margin_left = right - (level * left / 100.0)

func show_message():
	$AnimationPlayer.play("text_popup")
