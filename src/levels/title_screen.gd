extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(event):
	if $Timer.is_stopped() && event.is_pressed():
		globals.next_scene()