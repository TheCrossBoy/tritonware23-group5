extends CharacterBody2D

@export var damage = 35


func _physics_process(delta):
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	pass


func _on_projectile_area_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()

func block_attack():
	print("block attack")
	queue_free()


func _on_buzz_finished():
	$Buzz.play()
