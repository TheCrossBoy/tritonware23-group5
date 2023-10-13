extends CharacterBody2D


const SPEED = 300.0


func _physics_process(delta):
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		pass
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_anything_pressed():
		var x = Input.get_axis("ui_left", "ui_right")
		var y = Input.get_axis("ui_up", "ui_down")
		velocity.x = x * SPEED
		velocity.y = y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

