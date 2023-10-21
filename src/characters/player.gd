extends CharacterBody2D


@export var health = 100
@export var speed = 500.0
@export var accel = 7500
@export var projectile_scene: PackedScene
@export var projectile_speed = 600


func _physics_process(delta):
	# Handle Shooting
	if Input.is_action_pressed("ui_select") && get_node("ShootTimer").is_stopped():
		get_node("ShootTimer").start()
		var projectile = projectile_scene.instantiate()
		projectile.position = position
		projectile.velocity = Vector2(0, 0).move_toward(get_viewport().get_mouse_position() - position, projectile_speed).normalized() * projectile_speed
		projectile.look_at(get_viewport().get_mouse_position())
		get_tree().get_root().add_child(projectile)
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	#if Input.is_anything_pressed():
	
	
	var new_velocity = Vector2(0, 0)
	new_velocity.x = Input.get_axis("ui_left", "ui_right")
	new_velocity.y = Input.get_axis("ui_up", "ui_down")
	
	new_velocity = new_velocity.normalized() * speed
	velocity = velocity.move_toward(new_velocity, accel*delta)
	#velocity = new_velocity

	move_and_slide()
	
func take_damage(damage):
	health = health - damage
	$FlashAnimation.custom_play()
	if health <=0:
		queue_free()
		get_tree().reload_current_scene()
