extends CharacterBody2D

@export var speed = 85
@export var health = 280
@export var damage = 50

var player
var is_ready = false

func _ready():
	player = get_node("../player")
	add_to_group("enemies")
	is_ready = true

func _physics_process(delta):
	velocity = Vector2(0, 0).move_toward(player.global_position - global_position, speed).normalized() * speed
	if velocity.x > 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	move_and_slide()

func take_damage(dmg):
	health = health - dmg
	$FlashAnimation.custom_play()
	if health <=0:
		queue_free()


func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)


func _on_glop_finished():
	$Glop.play()
