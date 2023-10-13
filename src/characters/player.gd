extends CharacterBody2D


const SPEED = 500.0


func _physics_process(delta):
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		pass
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#if Input.is_anything_pressed():
	
	
	var new_velocity = Vector2(0, 0)
	new_velocity.x = Input.get_axis("ui_left", "ui_right")
	new_velocity.y = Input.get_axis("ui_up", "ui_down")
	
	new_velocity = new_velocity.normalized() * SPEED
	velocity = velocity.move_toward(new_velocity, 7500*delta)
	#velocity = new_velocity

	move_and_slide()

