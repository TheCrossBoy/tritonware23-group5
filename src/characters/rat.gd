extends CharacterBody2D

@export var speed = 300.0
@export var health = 50
@export var projectile_scene: PackedScene
@export var projectile_speed = 300

var player
var is_ready = false

func _ready():
	player = get_node("../player")
	is_ready = true

func _physics_process(delta):
	velocity = Vector2(0, 0).move_toward(player.global_position - global_position, speed).normalized() * speed
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.flip_h = true
	move_and_slide()

func take_damage(damage):
	health = health - damage
	$FlashAnimation.custom_play()
	if health <=0:
		queue_free()
