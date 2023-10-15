extends CharacterBody2D

@export var projectile_scene: PackedScene

@export var speed = 300.0
var player

func _ready():
	player = get_node("../player")

func _physics_process(delta):

#	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#
#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
#	var direction = Input.get_axis("ui_left", "ui_right")
#	if direction:
#		velocity.x = direction * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_attack_timer_timeout():
	if get_node("../player"):
		var projectile = projectile_scene.instantiate()
		projectile.position = position #+ Vector2(-60, -10)
		projectile.velocity = Vector2(0, 0).move_toward(player.global_position + player.velocity/3.5 - global_position, speed)
		get_tree().get_root().add_child(projectile)
