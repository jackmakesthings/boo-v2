extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func onPause():
	get_tree().paused = true
	$pause_screen.layer = 0

func onUnpause():
	get_tree().paused = false
	$pause_screen.layer = -1


func _input(event):
	if event.is_action_pressed('pause'):
		if get_tree().paused:
			onUnpause()
		else:
			onPause()
			

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _init():
	var screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size*0.5 - window_size*0.5)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
