extends CharacterBody2D

@export var speed = 50.0
@export var health = 100
@export var projectile_scene: PackedScene
@export var projectile_speed = 300
@export var damage = 15

var player
var is_ready = false

func _ready():
	player = get_node("../player")
	add_to_group("enemies")
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

func _on_attack_timer_timeout():
	if get_node("../player"):
		var projectile = projectile_scene.instantiate()
		projectile.position = position #+ Vector2(-60, -10)
		projectile.velocity = Vector2(0, 0).move_toward(player.global_position + player.velocity/3.5 - global_position, projectile_speed).normalized() * projectile_speed
		get_tree().get_root().add_child(projectile)


func _on_area_2d_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
