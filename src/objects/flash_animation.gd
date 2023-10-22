extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func custom_play():
	if $FlashTimer.is_stopped():
		play("damage_flash")
		$FlashTimer.start()


func _on_flash_timer_timeout():
	stop()
