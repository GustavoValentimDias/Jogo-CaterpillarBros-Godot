extends Label

var time = 0;
var timer_on = false;

func _process(delta):
	time += delta;
	text = var2str(time);
