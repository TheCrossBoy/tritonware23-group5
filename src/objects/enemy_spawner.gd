extends Node2D

@export var mob: PackedScene 
@export var min_respawn_time = 3.0
@export var max_respawn_time = 6.0
@export var total_respawn_time = 30.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$BigTimer.wait_time = total_respawn_time
	$BigTimer/SmallTimer.wait_time = max_respawn_time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_small_timer_timeout():
	if !$BigTimer.is_stopped():
		var m = mob.instantiate()
		m.global_position = global_position
		get_tree().get_root().add_child(m)
		$BigTimer/SmallTimer.wait_time = randf_range(min_respawn_time, max_respawn_time)
		$BigTimer/SmallTimer.start()
