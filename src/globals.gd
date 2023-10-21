extends Node

var current_level = 0
var levels = [
preload("res://src/levels/title_screen.tscn"), 
preload("res://src/levels/basement.tscn"), 
preload("res://src/levels/attic.tscn"),
preload("res://src/levels/finish_screen.tscn"), 
preload("res://src/levels/credits_screen.tscn")
]


func _ready():
	pass # Replace with function body.

func next_scene():
	current_level = current_level + 1
	if current_level == levels.size():
		current_level = 0
	get_tree().change_scene_to_packed(levels[current_level])


