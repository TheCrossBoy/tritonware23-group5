extends Node

var a = preload("res://src/levels/title_screen.tscn")
var b = preload("res://src/levels/basement.tscn")
var c = preload("res://src/levels/attic.tscn") 
var current_level = 0
var levels = [a, b, c]
#kind of a dumb code but it works
func _ready():
	pass # Replace with function body.

func next_scene():
	current_level = current_level + 1
	get_tree().change_scene_to_packed(levels[current_level])


